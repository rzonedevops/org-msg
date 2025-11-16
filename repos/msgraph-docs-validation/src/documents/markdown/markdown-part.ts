// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import MarkdownHeading from './markdown-heading';
import MarkdownTabbedSection from './markdown-tabbed-section';
import MarkdownTable from './markdown-table';
import MarkdownCodeBlock from './markdown-codeblock';
import MarkdownHtmlComment from './markdown-html-comment';
import MarkdownParagraph from './markdown-paragraph';
import MarkdownInclude from './markdown-include';
import MarkdownNamespace from './markdown-namespace';

type MarkdownPart =
  | MarkdownHeading
  | MarkdownTabbedSection
  | MarkdownTable
  | MarkdownCodeBlock
  | MarkdownHtmlComment
  | MarkdownParagraph
  | MarkdownInclude
  | MarkdownNamespace;

export default MarkdownPart;

export function createPartCollectionFromLines(
  lines: string[],
  startIndex: number,
  endIndex: number,
): MarkdownPart[] {
  let index = startIndex;
  let paragraph: MarkdownParagraph = {
    type: MarkdownParagraph.name,
    lines: [],
    lineNumber: -1,
  };

  const docParts: MarkdownPart[] = [];

  while (index < lines.length && index <= endIndex) {
    const currentLine = lines[index].trimEnd();
    // Save any paragraph lines as a paragraph and reset
    if (currentLine.length <= 0) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      index++;
      continue;
    }

    // Is it a header?
    const heading = MarkdownHeading.parse(currentLine, index);
    if (heading) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(heading);
      index++;
      continue;
    }

    // Is it an include?
    const include = MarkdownInclude.parse(currentLine, index);
    if (include) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(include);
      index++;
      continue;
    }

    // Is it a namespace declaration?
    const namespace = MarkdownNamespace.parse(currentLine, index);
    if (namespace) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(namespace);
      index++;
      continue;
    }

    // Is it a tabbed section?
    const tabbedSection = MarkdownTabbedSection.parse(lines, index);
    if (tabbedSection) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(tabbedSection);
      index += tabbedSection.totalLineCount;
      continue;
    }

    // Is it a table?
    const mdTable = MarkdownTable.parse(lines, index);
    if (mdTable) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(mdTable);
      index += mdTable.totalLineCount;
      continue;
    }

    // Is it a metadata block?
    const codeMetadata = MarkdownHtmlComment.parse(lines, index);
    if (codeMetadata) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(codeMetadata);
      index += codeMetadata.lines.length;
      continue;
    }

    // Is it a code block?
    const codeBlock = MarkdownCodeBlock.parse(lines, index);
    if (codeBlock) {
      paragraph = saveAndResetParagraph(docParts, paragraph);
      docParts.push(codeBlock);
      index += codeBlock.lines.length;
      continue;
    }

    // Add to paragraph block
    paragraph.lines.push(currentLine);
    if (paragraph.lineNumber < 0) {
      paragraph.lineNumber = index + 1;
    }
    index++;
  }

  return docParts;
}

function saveAndResetParagraph(
  docParts: MarkdownPart[],
  paragraph: MarkdownParagraph,
): MarkdownParagraph {
  if (paragraph.lines.length > 0) {
    docParts.push(paragraph);
  }

  return {
    type: MarkdownParagraph.name,
    lines: [],
    lineNumber: -1,
  };
}

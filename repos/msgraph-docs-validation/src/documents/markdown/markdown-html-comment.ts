// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const singleLineHtmlCommentRegex = /^<!--\s*({.*})\s*-->(.*)$/;
const lastLineRegex = /^(.*)-->(.*)$/;

type CodeMetaData = {
  blockType: string;
  name?: string;
  truncated?: boolean;
  '@odata.type'?: string;
  keyProperty?: string;
  openType?: boolean;
  sampleKeys?: string | string[];
};

function isCodeMetaData(obj: unknown): obj is CodeMetaData {
  return (
    obj != null &&
    obj != undefined &&
    typeof obj === 'object' &&
    'blockType' in obj &&
    typeof obj['blockType'] === 'string'
  );
}

export default class MarkdownHtmlComment {
  public type: string = MarkdownHtmlComment.name;
  public lines: string[] = [];
  public lineNumber = -1;
  public metadata?: CodeMetaData;
  public trailingText?: string;

  public static parse(
    lines: string[],
    index: number,
  ): MarkdownHtmlComment | undefined {
    let currentLine = lines[index].trim();
    let jsonString = '';

    const htmlComment: MarkdownHtmlComment = {
      type: MarkdownHtmlComment.name,
      lines: [],
      lineNumber: index + 1,
    };

    // Test for a single-line comment
    const match = singleLineHtmlCommentRegex.exec(currentLine);
    if (match) {
      htmlComment.lines.push(currentLine);
      jsonString = match[1];
      if (match[2] && match[2].length > 0) {
        htmlComment.trailingText = match[2].trimEnd();
      }
    } else if (
      currentLine.startsWith('<!--') &&
      currentLine.indexOf('-->') < 0
    ) {
      // Multi-line comment
      const jsonLines: string[] = [];
      htmlComment.lines.push(currentLine);
      // Remove comment open
      currentLine = currentLine.slice(4).trim();
      while (currentLine !== undefined && currentLine.indexOf('-->') < 0) {
        if (currentLine.length > 0) {
          jsonLines.push(currentLine);
        }
        currentLine = lines[++index]?.trim();
        if (currentLine != undefined) {
          htmlComment.lines.push(currentLine);
        }
      }

      if (currentLine) {
        // Remove comment close
        const match = lastLineRegex.exec(currentLine);
        if (match) {
          if (match[1]) {
            jsonLines.push(match[1]);
          }

          if (match[2] && match[2].length > 0) {
            htmlComment.trailingText = match[2].trimEnd();
          }
        }
      }

      jsonString = jsonLines.join(' ');
    }

    if (htmlComment.lines.length > 0) {
      if (jsonString.length > 0) {
        try {
          const metadata = JSON.parse(jsonString) as CodeMetaData;
          if (isCodeMetaData(metadata)) {
            htmlComment.metadata = metadata;
          }
        } catch {
          /* Non-metadata comment */
        }
      }

      return htmlComment;
    }
  }
}

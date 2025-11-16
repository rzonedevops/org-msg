// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `snippet-tabs-alphabetical`
 * Applies to: Markdown API topics (doc_type: apipagetype)
 *
 * Code snippet tabs must be in alphabetical order.
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument, { TopicType } from '../documents/markdown-document';
import MarkdownHeading from '../documents/markdown/markdown-heading';
import MarkdownPart from '../documents/markdown/markdown-part';
import MarkdownTabbedSection, {
  TabbedSection,
} from '../documents/markdown/markdown-tabbed-section';

export default class MGD007 implements LintRule {
  id = 'MGD007';
  alias = 'snippet-tabs-alphabetical';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;
      if (markdown.topicType === TopicType.Api) {
        // Find any tabbed sections under Examples
        const examplesHeading = markdown.docParts.find((part: MarkdownPart) => {
          if (part.type !== MarkdownHeading.name) return false;

          const heading = part as MarkdownHeading;
          return heading.title === 'Examples' || heading.title === 'Example';
        }) as MarkdownHeading;

        if (examplesHeading) {
          const tabbedSections = markdown.docParts.filter(
            (part: MarkdownPart) => {
              return (
                part.type === MarkdownTabbedSection.name &&
                part.lineNumber > examplesHeading.lineNumber
              );
            },
          ) as MarkdownTabbedSection[];

          tabbedSections.forEach((tabbedSection: MarkdownTabbedSection) => {
            // Check that this is a snippet tabbed section
            if (
              !tabbedSection.sections.find((section: TabbedSection) => {
                return section.title === 'HTTP';
              })
            ) {
              return;
            }

            tabbedSection.sections.forEach(
              (section: TabbedSection, index: number) => {
                if (index === 0 && section.title != 'HTTP') {
                  // HTTP must be first
                  problems.push({
                    id: this.id,
                    description: `Tabbed section ${section.title} is first in list of tabs, HTTP must be first`,
                    location: {
                      line: section.lineNumber,
                      column: 0,
                      length:
                        markdown.contentLines[section.lineNumber - 1].length,
                    },
                  });
                } else if (index > 0 && section.title === 'HTTP') {
                  problems.push({
                    id: this.id,
                    description: `HTTP tab must be first in the list of tabs`,
                    location: {
                      line: section.lineNumber,
                      column: 0,
                      length:
                        markdown.contentLines[section.lineNumber - 1].length,
                    },
                  });
                } else if (
                  index > 1 &&
                  section.title.localeCompare(
                    tabbedSection.sections[index - 1].title,
                  ) < 1
                ) {
                  problems.push({
                    id: this.id,
                    description: `Tabbed section ${section.title} is out of alphabetical order`,
                    location: {
                      line: section.lineNumber,
                      column: 0,
                      length:
                        markdown.contentLines[section.lineNumber - 1].length,
                    },
                  });
                }
              },
            );
          });
        }
      }
    }

    return problems;
  }
}

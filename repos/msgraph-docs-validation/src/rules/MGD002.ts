// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `beta-disclaimer`
 * Applies to: Markdown
 *
 * - Topics in the **api-reference/beta** folder MUST contain exactly one instance of the beta disclaimer INCLUDE file
 * - Topics in the **api-reference/v1.0** folder MUST NOT contain any instances of the beta disclaimer INCLUDE file
 * - Topics anywhere else MUST NOT contain more than one instance of the beta disclaimer INCLUDE file
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import MarkdownInclude from '../documents/markdown/markdown-include';

const betaPathRegEx = /[/\\]api-reference[/\\]beta[/\\]/;
const nonBetaPathRegEx = /[/\\]api-reference[/\\]v1.0[/\\]/;

export default class MGD002 implements LintRule {
  id = 'MGD002';
  alias = 'beta-disclaimer';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;
      const disclaimers = document.docParts.filter((part) => {
        if (part.type === MarkdownInclude.name) {
          const include = part as MarkdownInclude;
          return include.filePath.endsWith('beta-disclaimer.md');
        }
      });

      if (betaPathRegEx.test(markdown.filePath)) {
        // Beta reference topics MUST have one and only one disclaimer
        if (disclaimers.length <= 0) {
          problems.push({
            id: this.id,
            description: 'Missing required beta disclaimer',
          });
        } else if (disclaimers.length > 1) {
          disclaimers.forEach((disclaimer, index) => {
            if (index > 0) {
              problems.push({
                id: this.id,
                description: 'Beta disclaimer appears more than once',
                location: {
                  line: disclaimer.lineNumber,
                  column: 0,
                  length:
                    markdown.contentLines[disclaimer.lineNumber - 1].length,
                },
              });
            }
          });
        }
      } else if (nonBetaPathRegEx.test(markdown.filePath)) {
        // Non-beta reference topics MUST have no disclaimers
        if (disclaimers.length > 0) {
          for (const disclaimer of disclaimers) {
            problems.push({
              id: this.id,
              description:
                'Beta disclaimer should not be included in non-beta topics',
              location: {
                line: disclaimer.lineNumber,
                column: 0,
                length: markdown.contentLines[disclaimer.lineNumber - 1].length,
              },
            });
          }
        }
      } else if (disclaimers.length > 1) {
        // Everything else must have 0 or 1 disclaimers
        disclaimers.forEach((disclaimer, index) => {
          if (index > 0) {
            problems.push({
              id: this.id,
              description: 'Beta disclaimer appears more than once',
              location: {
                line: disclaimer.lineNumber,
                column: 0,
                length: markdown.contentLines[disclaimer.lineNumber - 1].length,
              },
            });
          }
        });
      }
    }
    return problems;
  }
}

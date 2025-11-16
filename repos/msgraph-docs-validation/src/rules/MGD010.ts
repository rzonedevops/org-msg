// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `no-onmicrosoft-domains`
 * Applies to: Markdown
 *
 * No occurrences of `onmicrosoft.com` appear in email addresses or URLs.
 * See https://aka.ms/fictitious for guidance on acceptable domains.
 */

import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import LintRule from './lint-rule';
import Problem from './problem';

const domainNameRegex = /[^\s"'/]*onmicrosoft\.com/;

export default class MGD010 implements LintRule {
  id = 'MGD010';
  alias = 'no-onmicrosoft-domains';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;

      markdown.contentLines.forEach((line, index) => {
        const match = domainNameRegex.exec(line);
        if (match) {
          problems.push({
            id: this.id,
            description: `"${match[0]}" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.`,
            location: {
              line: index + 1,
              column: match.index,
              length: match[0].length,
            },
          });
        }
      });
    }

    return problems;
  }
}

// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `yaml-header-present`
 * Applies to: Markdown
 *
 * All topics must have a valid YAML header at the top of the file that contains at least these properties:
 *
 * ```yaml
 * ---
 * title: Title
 * description: Description
 * author: Author
 * doc_type: Doc-Type
 * ---
 * ```
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import { isEmpty } from '../utils';

export default class MGD001 implements LintRule {
  id = 'MGD001';
  alias = 'yaml-header-present';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;
      if (markdown.yamlHeader && markdown.contentLines[0].trim() === '---') {
        if (isEmpty(markdown.yamlHeader.title)) {
          problems.push({
            id: this.id,
            description: this.missingAttribute('title'),
          });
        }
        if (isEmpty(markdown.yamlHeader.description)) {
          problems.push({
            id: this.id,
            description: this.missingAttribute('description'),
          });
        }
        if (isEmpty(markdown.yamlHeader.author)) {
          problems.push({
            id: this.id,
            description: this.missingAttribute('author'),
          });
        }
        if (isEmpty(markdown.yamlHeader.doc_type)) {
          problems.push({
            id: this.id,
            description: this.missingAttribute('doc_type'),
          });
        }
      } else {
        problems.push({
          id: this.id,
          description: 'YAML header missing',
        });
      }
    }
    return problems;
  }

  private missingAttribute(name: string): string {
    return `YAML header missing required attribute "${name}"`;
  }
}

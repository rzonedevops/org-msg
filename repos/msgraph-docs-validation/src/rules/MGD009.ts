// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `tabs-consistent`
 * Applies to: Markdown
 *
 * If multiple tabbed sections exist in a document, they must all contain the same tabs in the same order.
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import MarkdownPart from '../documents/markdown/markdown-part';
import MarkdownTabbedSection from '../documents/markdown/markdown-tabbed-section';

export default class MGD009 implements LintRule {
  id = 'MGD009';
  alias = 'tabs-consistent';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;

      const tabbedSections = markdown.docParts.filter((part: MarkdownPart) => {
        return part.type === MarkdownTabbedSection.name;
      }) as MarkdownTabbedSection[];

      if (tabbedSections.length > 1) {
        // First tabbed section sets the criteria
        const referenceSection = tabbedSections[0];
        for (let i = 1; i < tabbedSections.length; i++) {
          const sectionProblems = this.checkForTabConsistencyProblems(
            tabbedSections[i],
            referenceSection,
          );
          if (sectionProblems.length > 0) {
            sectionProblems.forEach((problem) => {
              if (problem.location) {
                problem.location.length =
                  markdown.contentLines[problem.location.line - 1].length;
              }
            });

            problems.push(...sectionProblems);
          }
        }
      }
    }

    return problems;
  }

  private checkForTabConsistencyProblems(
    tabbedSection: MarkdownTabbedSection,
    referenceSection: MarkdownTabbedSection,
  ): Problem[] {
    const problems: Problem[] = [];
    tabbedSection.sections.forEach((section, index) => {
      if (
        index >= referenceSection.sections.length ||
        section.title !== referenceSection.sections[index].title ||
        section.anchor !== referenceSection.sections[index].anchor
      ) {
        problems.push({
          id: this.id,
          description: `Tab is not consistent with tabs in first tabbed section that starts at line ${referenceSection.lineNumber}`,
          location: {
            line: section.lineNumber,
            column: 0,
            // Must be set by caller
            length: 0,
          },
        });
      }
    });

    return problems;
  }
}

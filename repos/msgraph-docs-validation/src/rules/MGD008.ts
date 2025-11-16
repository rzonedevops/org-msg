// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `language-tabs-correct`
 * Applies to: Markdown
 *
 * Tab anchors for programming languages use the correct casing and anchor value.
 *
 * - C#: #tab/csharp
 * - CLI: #tab/cli
 * - Go: #tab/go
 * - Java: #tab/java
 * - JavaScript: #tab/javascript
 * - PHP: #tab/php
 * - PowerShell: #tab/powershell
 * - Python: #tab/python
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import MarkdownPart from '../documents/markdown/markdown-part';
import MarkdownTabbedSection, {
  TabbedSection,
} from '../documents/markdown/markdown-tabbed-section';

const languageSections: TabbedSection[] = [
  {
    title: 'HTTP',
    anchor: 'tab/http',
    lineNumber: 0,
  },
  {
    title: 'C#',
    anchor: 'tab/csharp',
    lineNumber: 0,
  },
  {
    title: 'CLI',
    anchor: 'tab/cli',
    lineNumber: 0,
  },
  {
    title: 'Go',
    anchor: 'tab/go',
    lineNumber: 0,
  },
  {
    title: 'Java',
    anchor: 'tab/java',
    lineNumber: 0,
  },
  {
    title: 'JavaScript',
    anchor: 'tab/javascript',
    lineNumber: 0,
  },
  {
    title: 'PHP',
    anchor: 'tab/php',
    lineNumber: 0,
  },
  {
    title: 'PowerShell',
    anchor: 'tab/powershell',
    lineNumber: 0,
  },
  {
    title: 'Python',
    anchor: 'tab/python',
    lineNumber: 0,
  },
  {
    title: 'TypeScript',
    anchor: 'tab/typescript',
    lineNumber: 0,
  },
];

export default class MGD008 implements LintRule {
  id = 'MGD008';
  alias = 'language-tabs-correct';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;

      const tabbedSections = markdown.docParts.filter((part: MarkdownPart) => {
        return part.type === MarkdownTabbedSection.name;
      }) as MarkdownTabbedSection[];

      tabbedSections.forEach((tabbedSection: MarkdownTabbedSection) => {
        tabbedSection.sections.forEach((section: TabbedSection) => {
          const problem = this.checkForNamingProblem(section);
          if (problem && problem.location) {
            problem.location.length =
              markdown.contentLines[section.lineNumber - 1].length;
            problems.push(problem);
          }
        });
      });
    }

    return problems;
  }

  private checkForNamingProblem(section: TabbedSection): Problem | undefined {
    const match = languageSections.find((languageSection: TabbedSection) => {
      return (
        languageSection.title.toLowerCase() === section.title.toLowerCase() ||
        languageSection.anchor.toLowerCase() === section.anchor.toLowerCase()
      );
    });

    if (match) {
      if (match.title !== section.title || match.anchor !== section.anchor) {
        return {
          id: this.id,
          description: `Correct section anchor for this language is '[${match.title}](#${match.anchor})' (case-sensitive)`,
          location: {
            line: section.lineNumber,
            column: 0,
            length: 0, // Must be set by caller
          },
        };
      }
    }

    return undefined;
  }
}

// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `correct-version-in-url`
 * Applies to: Markdown
 *
 * - Examples in topics in the **api-reference/beta** folder MUST use the beta endpoint.
 * - Examples in topics in the **api-reference/v1.0** folder MUST use the v1.0 endpoint.
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import MarkdownPart from '../documents/markdown/markdown-part';
import MarkdownCodeBlock from '../documents/markdown/markdown-codeblock';
import { RegExpExecArrayWithIndices } from '../types';
import MarkdownHeading from '../documents/markdown/markdown-heading';
import MarkdownTabbedSection from '../documents/markdown/markdown-tabbed-section';

const betaPathRegEx = /[/\\]api-reference[/\\]beta[/\\]/;
const nonBetaPathRegEx = /[/\\]api-reference[/\\]v1.0[/\\]/;
const versionFromFullUrl =
  /https:\/\/graph\.microsoft\.com\/(?<version>[^/]*)/d;
const versionFromRelativeUrl =
  /(?:(?:GET)|(?:POST)|(?:PUT)|(?:PATCH)|(?:DELETE))\s+\/(?<version>[^/]*)/d;

export default class MGD005 implements LintRule {
  id = 'MGD005';
  alias = 'correct-version-in-url';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;

      if (betaPathRegEx.test(markdown.filePath)) {
        return this.checkApiPathVersion(markdown, 'beta');
      } else if (nonBetaPathRegEx.test(markdown.filePath)) {
        return this.checkApiPathVersion(markdown, 'v1.0');
      }
    }

    return problems;
  }

  private async checkApiPathVersion(
    markdown: MarkdownDocument,
    version: string,
  ) {
    const problems: Problem[] = [];

    // Find the Examples heading
    const exampleHeading = markdown.docParts.find((part: MarkdownPart) => {
      if (part.type === MarkdownHeading.name) {
        const heading = part as MarkdownHeading;
        return heading.title === 'Examples' || heading.title === 'Example';
      } else {
        return false;
      }
    }) as MarkdownHeading;

    if (exampleHeading) {
      // Find the next heading at the same level to serve
      // as our stopping point
      const nextPeerHeading = markdown.docParts.find((part: MarkdownPart) => {
        if (part.type === MarkdownHeading.name) {
          const heading = part as MarkdownHeading;
          return (
            heading.level === exampleHeading.level &&
            heading.lineNumber > exampleHeading.lineNumber
          );
        } else {
          return false;
        }
      });

      // Check all code blocks and tabbed sections in the Examples section
      const subParts = markdown.docParts.filter((part: MarkdownPart) => {
        return (
          (part.type === MarkdownCodeBlock.name ||
            part.type === MarkdownTabbedSection.name) &&
          part.lineNumber > exampleHeading.lineNumber &&
          (nextPeerHeading === undefined ||
            part.lineNumber < nextPeerHeading?.lineNumber)
        );
      });

      if (subParts) {
        const codeBlocks: MarkdownCodeBlock[] = [];

        subParts.forEach((part: MarkdownPart) => {
          if (part.type === MarkdownCodeBlock.name) {
            codeBlocks.push(part as MarkdownCodeBlock);
          } else {
            const tabbedSection = part as MarkdownTabbedSection;

            // Get any code blocks inside the tabbed section
            const containedCodeBlocks = tabbedSection.docParts.filter(
              (part: MarkdownPart) => {
                return part.type === MarkdownCodeBlock.name;
              },
            ) as MarkdownCodeBlock[];
            codeBlocks.push(...containedCodeBlocks);
          }
        });

        codeBlocks.forEach((codeBlock: MarkdownCodeBlock) => {
          if (
            codeBlock.language === undefined ||
            codeBlock.language === 'http' ||
            codeBlock.language === 'msgraph-interactive'
          ) {
            codeBlock.lines.forEach((line: string, index: number) => {
              // Check for fully-qualified URLs
              const fqMatch = versionFromFullUrl.exec(line);
              if (
                fqMatch &&
                fqMatch.groups &&
                fqMatch.groups['version'] !== version
              ) {
                const matchWithIndices = fqMatch as RegExpExecArrayWithIndices;
                problems.push({
                  id: this.id,
                  description: `Incorrect version '${fqMatch.groups['version']}' in API URL`,
                  location: {
                    line: codeBlock.lineNumber + index,
                    column: matchWithIndices.indices[1][0],
                    length: fqMatch.groups['version'].length,
                  },
                });
              } else {
                const relativeMatch = versionFromRelativeUrl.exec(line);
                if (
                  relativeMatch &&
                  relativeMatch.groups &&
                  relativeMatch.groups['version'] !== version
                ) {
                  const matchWithIndices =
                    relativeMatch as RegExpExecArrayWithIndices;
                  problems.push({
                    id: this.id,
                    description: `Incorrect version '${relativeMatch.groups['version']}' in API URL`,
                    location: {
                      line: codeBlock.lineNumber + index,
                      column: matchWithIndices.indices[1][0],
                      length: relativeMatch.groups['version'].length,
                    },
                  });
                }
              }
            });
          }
        });
      }
    }

    return problems;
  }
}

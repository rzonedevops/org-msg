// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `relative-url-http-request`
 * Applies to: Markdown API topics (doc_type: apipagetype)
 *
 * URLs in the **HTTP request** section must be relative and not include version.
 *
 * Correct: `GET /users`
 * Incorrect: `GET /v1.0/users` or `GET https://graph.microsoft.com/v1.0/users`
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument, { TopicType } from '../documents/markdown-document';
import MarkdownHeading from '../documents/markdown/markdown-heading';
import MarkdownPart from '../documents/markdown/markdown-part';
import MarkdownCodeBlock from '../documents/markdown/markdown-codeblock';

const urlFromRequestLine =
  /(?:(?:GET)|(?:POST)|(?:PUT)|(?:PATCH)|(?:DELETE))\s+(?<url>[^\s]*)/;

const betaVersion = '/beta';
const v1Version = '/v1.0';
const graphHost = 'https://graph.microsoft.com';
const betaUrl = graphHost + betaVersion;
const v1Url = graphHost + v1Version;

export default class MGD006 implements LintRule {
  id = 'MGD006';
  alias = 'relative-url-http-request';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;
      if (markdown.topicType === TopicType.Api) {
        // Locate the 'HTTP request' heading
        const requestHeading = markdown.docParts.find((part: MarkdownPart) => {
          if (part.type !== MarkdownHeading.name) return false;

          const heading = part as MarkdownHeading;
          return heading.title === 'HTTP request';
        }) as MarkdownHeading;

        if (requestHeading) {
          const nextPeerHeading = markdown.docParts.find(
            (part: MarkdownPart) => {
              if (
                part.type !== MarkdownHeading.name ||
                part.lineNumber <= requestHeading.lineNumber
              )
                return false;

              const heading = part as MarkdownHeading;
              return heading.level === requestHeading.level;
            },
          );

          const sectionEndLineNumber =
            nextPeerHeading?.lineNumber ?? markdown.contentLines.length;

          // Get all code blocks in HTTP request (and subsections)
          const requestCodeBlocks = markdown.docParts.filter(
            (part: MarkdownPart) => {
              return (
                part.type === MarkdownCodeBlock.name &&
                part.lineNumber > requestHeading.lineNumber &&
                part.lineNumber < sectionEndLineNumber
              );
            },
          ) as MarkdownCodeBlock[];

          requestCodeBlocks.forEach((codeBlock: MarkdownCodeBlock) => {
            if (
              codeBlock.language === undefined ||
              codeBlock.language === 'http'
            ) {
              codeBlock.lines.forEach((line: string, index: number) => {
                const urlMatch = urlFromRequestLine.exec(line);
                if (urlMatch?.groups) {
                  const requestUrl = urlMatch.groups['url'];

                  if (requestUrl.startsWith(betaVersion)) {
                    problems.push(
                      this.createProblem(
                        line,
                        betaVersion,
                        codeBlock.lineNumber + index,
                      ),
                    );
                  } else if (requestUrl.startsWith(v1Version)) {
                    problems.push(
                      this.createProblem(
                        line,
                        v1Version,
                        codeBlock.lineNumber + index,
                      ),
                    );
                  } else if (requestUrl.startsWith(betaUrl)) {
                    problems.push(
                      this.createProblem(
                        line,
                        betaUrl,
                        codeBlock.lineNumber + index,
                      ),
                    );
                  } else if (requestUrl.startsWith(v1Url)) {
                    problems.push(
                      this.createProblem(
                        line,
                        v1Url,
                        codeBlock.lineNumber + index,
                      ),
                    );
                  }
                }
              });
            }
          });
        }
      }
    }

    return problems;
  }

  private createProblem(
    line: string,
    substring: string,
    lineNumber: number,
  ): Problem {
    return {
      id: this.id,
      description:
        'API URLs in HTTP request section should be relative and not contain version',
      location: {
        line: lineNumber,
        column: line.indexOf(substring),
        length: substring.length,
      },
    };
  }
}

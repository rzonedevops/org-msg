// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `properties-alphabetical`
 * Applies to: Markdown resource topics (doc_type: resourcePageType)
 *
 * Properties are listed in alphabetical order in tables and JSON representations
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument, { TopicType } from '../documents/markdown-document';
import MarkdownTable from '../documents/markdown/markdown-table';
import MarkdownCodeBlock from '../documents/markdown/markdown-codeblock';

type OrderProblem = {
  value: string;
  line: number;
  column: number;
};

const jsonPropertyRegEx = /^(\s+)"([^"]+)"\s*:\s*"?([^",\n]+)"?,?$/;

export default class MGD003 implements LintRule {
  id = 'MGD003';
  alias = 'properties-alphabetical';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;
      if (
        markdown.topicType === TopicType.Resource &&
        markdown.resourceElements
      ) {
        if (
          markdown.resourceElements.propertiesTableIndex &&
          markdown.docParts[markdown.resourceElements.propertiesTableIndex]
            .type === MarkdownTable.name
        ) {
          const propertiesTable = markdown.docParts[
            markdown.resourceElements.propertiesTableIndex
          ] as MarkdownTable;

          const problemRows = this.getRowsOutOfOrder(
            propertiesTable,
            markdown.contentLines,
          );
          for (const problemRow of problemRows) {
            problems.push({
              id: this.id,
              description: `Properties table row '${problemRow.value}' is out of alphabetical order`,
              location: {
                line: problemRow.line,
                column: problemRow.column,
                length: problemRow.value.length,
              },
            });
          }
        }

        if (
          markdown.resourceElements.relationShipsTableIndex &&
          markdown.docParts[markdown.resourceElements.relationShipsTableIndex]
            .type === MarkdownTable.name
        ) {
          const relationshipsTable = markdown.docParts[
            markdown.resourceElements.relationShipsTableIndex
          ] as MarkdownTable;

          const problemRows = this.getRowsOutOfOrder(
            relationshipsTable,
            markdown.contentLines,
          );
          for (const problemRow of problemRows) {
            problems.push({
              id: this.id,
              description: `Relationships table row '${problemRow.value}' is out of alphabetical order`,
              location: {
                line: problemRow.line,
                column: problemRow.column,
                length: problemRow.value.length,
              },
            });
          }
        }

        if (
          markdown.resourceElements.jsonRepresentationIndex &&
          markdown.docParts[markdown.resourceElements.jsonRepresentationIndex]
            .type === MarkdownCodeBlock.name
        ) {
          const jsonRepresentation = markdown.docParts[
            markdown.resourceElements.jsonRepresentationIndex
          ] as MarkdownCodeBlock;

          const problemLines = this.getPropertiesOutOfOrder(jsonRepresentation);
          for (const problemLine of problemLines) {
            problems.push({
              id: this.id,
              description: `Property in JSON representation '${problemLine.value}' is out of alphabetical order`,
              location: {
                line: problemLine.line,
                column: problemLine.column,
                length: problemLine.value.length,
              },
            });
          }
        }
      }
    }
    return problems;
  }

  private getRowsOutOfOrder(
    table: MarkdownTable,
    contentLines: string[],
  ): OrderProblem[] {
    const problems: OrderProblem[] = [];

    table.rows.forEach((row, index) => {
      if (index > 0 && row[0].localeCompare(table.rows[index - 1][0]) < 1) {
        problems.push({
          value: row[0],
          line: table.lineNumber + 2 + index,
          column: contentLines[table.lineNumber + 1 + index].indexOf(row[0]),
        });
      }
    });

    return problems;
  }

  private getPropertiesOutOfOrder(
    codeblock: MarkdownCodeBlock,
  ): OrderProblem[] {
    const problems: OrderProblem[] = [];

    if (codeblock.language?.toLowerCase() === 'json') {
      let previousProperty = '';
      let indentSize = 0;
      codeblock.lines.forEach((line, index) => {
        const match = jsonPropertyRegEx.exec(line);
        if (match) {
          if (indentSize <= 0) {
            indentSize = match[1].length;
          }

          if (
            match[1].length === indentSize &&
            match[2].localeCompare(previousProperty) < 1
          ) {
            problems.push({
              value: match[2],
              line: codeblock.lineNumber + index,
              column: line.indexOf(match[2]),
            });
          }
          previousProperty = match[2];
        }
      });
    }

    return problems;
  }
}

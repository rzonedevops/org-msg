// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const tableDividerRegEx = /^\|\s*[-:]+/;
const tableRowRegEx = /[|]([^|\r\n]+)/gm;

export default class MarkdownTable {
  public type: string = MarkdownTable.name;
  public headers: string[] = [];
  public rows: string[][] = [];
  public lineNumber = -1;
  public totalLineCount = -1;

  public static parse(
    lines: string[],
    index: number,
  ): MarkdownTable | undefined {
    if (
      lines[index].startsWith('|') &&
      tableDividerRegEx.test(lines[index + 1])
    ) {
      const mdTable: MarkdownTable = {
        type: MarkdownTable.name,
        // Current line is a table header, extract the headers
        headers: this.extractTableRowValues(lines[index]),
        rows: [],
        lineNumber: index + 1,
        totalLineCount: 0,
      };

      // Skip over divider
      index += 2;
      mdTable.totalLineCount += 2;

      while (index < lines.length && lines[index].startsWith('|')) {
        // Extract row info
        const rowValues = MarkdownTable.extractTableRowValues(lines[index]);
        mdTable.rows.push(rowValues);
        index++;
        mdTable.totalLineCount++;
      }

      return mdTable;
    }
  }

  private static extractTableRowValues(row: string): string[] {
    const values: string[] = [];
    let match: RegExpExecArray | null = null;
    while ((match = tableRowRegEx.exec(row)) !== null) {
      values.push(match[1].trim());
    }

    return values;
  }
}

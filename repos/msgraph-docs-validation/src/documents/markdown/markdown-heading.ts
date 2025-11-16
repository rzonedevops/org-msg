// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const headingRegEx = /^\s*(#+)\s+([^[\n\r]+)/;

export default class MarkdownHeading {
  public type: string = MarkdownHeading.name;
  public level = -1;
  public title = '';
  public lineNumber = -1;

  public static parse(
    line: string,
    index: number,
  ): MarkdownHeading | undefined {
    const headingMatch = headingRegEx.exec(line);
    if (headingMatch) {
      // Number of # indicates level of header
      return {
        type: MarkdownHeading.name,
        level: headingMatch[1].length,
        title: headingMatch[2],
        lineNumber: index + 1,
      };
    }
  }
}

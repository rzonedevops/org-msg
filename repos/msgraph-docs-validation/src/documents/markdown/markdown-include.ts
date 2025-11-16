// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const includeRegEx = /^\s*\[!INCLUDE\s+\[([^\][]*)\]\((.+)\)\]/;

export default class MarkdownInclude {
  public type: string = MarkdownInclude.name;
  public lineNumber = -1;
  public label = '';
  public filePath = '';

  public static parse(
    line: string,
    index: number,
  ): MarkdownInclude | undefined {
    const match = includeRegEx.exec(line);
    if (match) {
      return {
        type: MarkdownInclude.name,
        lineNumber: index + 1,
        label: match[1],
        filePath: match[2],
      };
    }
  }
}

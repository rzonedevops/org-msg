// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const namespaceRegex = /^Namespace:\s+(microsoft.graph\.?.*)/;

export default class MarkdownNamespace {
  public type: string = MarkdownNamespace.name;
  public namespace = '';
  public lineNumber = -1;

  public static parse(
    line: string,
    index: number,
  ): MarkdownNamespace | undefined {
    const namespaceMatch = namespaceRegex.exec(line);
    if (namespaceMatch) {
      return {
        type: MarkdownNamespace.name,
        namespace: namespaceMatch[1],
        lineNumber: index + 1,
      };
    }
  }
}

// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

export default class MarkdownParagraph {
  public type: string = MarkdownParagraph.name;
  public lines: string[] = [];
  public lineNumber = -1;
}

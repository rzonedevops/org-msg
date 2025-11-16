// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const codeBlockWithLangRegex = /^\s*```\s*([^`\s]+)$/;
const codeBlockEmptyRegex = /^\s*```$/;

export default class MarkdownCodeBlock {
  public type: string = MarkdownCodeBlock.name;
  public lines: string[] = [];
  public lineNumber = -1;
  public language?: string;

  public static parse(
    lines: string[],
    index: number,
  ): MarkdownCodeBlock | undefined {
    let currentLine = lines[index].trimEnd();
    const match = codeBlockWithLangRegex.exec(currentLine);
    if (match || codeBlockEmptyRegex.test(currentLine)) {
      const codeBlock: MarkdownCodeBlock = {
        type: MarkdownCodeBlock.name,
        lineNumber: index + 1,
        lines: [currentLine],
        language: match ? match[1] : undefined,
      };

      currentLine = lines[++index];
      while (
        currentLine !== undefined &&
        !codeBlockEmptyRegex.test(currentLine)
      ) {
        codeBlock.lines.push(currentLine);
        currentLine = lines[++index]?.trimEnd();
      }

      if (currentLine !== undefined) codeBlock.lines.push(currentLine);
      return codeBlock;
    }
  }
}

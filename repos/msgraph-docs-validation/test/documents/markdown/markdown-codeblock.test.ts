// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownCodeBlock from '../../../src/documents/markdown/markdown-codeblock';
import * as markdown from './markdown-data';

describe('MarkdownCodeBlock', () => {
  test('parses code block properly', () => {
    const codeblock = MarkdownCodeBlock.parse(markdown.codeblockLines, 0);
    expect(codeblock).toBeDefined();
    expect(codeblock).toHaveProperty('type', MarkdownCodeBlock.name);
    expect(codeblock).toHaveProperty('lineNumber', 1);
    expect(codeblock).toHaveProperty('lines');
    expect(codeblock?.lines).toHaveLength(markdown.codeblockLines.length);
    expect(codeblock).toHaveProperty('language', 'json');
  });

  test('parses code block without language properly', () => {
    const codeblock = MarkdownCodeBlock.parse(
      markdown.codeblockLinesWithoutLanguage,
      0,
    );
    expect(codeblock).toBeDefined();
    expect(codeblock).toHaveProperty('type', MarkdownCodeBlock.name);
    expect(codeblock).toHaveProperty('lineNumber', 1);
    expect(codeblock).toHaveProperty('lines');
    expect(codeblock?.lines).toHaveLength(
      markdown.codeblockLinesWithoutLanguage.length,
    );
    expect(codeblock).toHaveProperty('language');
    expect(codeblock?.language).toBeUndefined();
  });

  test('does not parse non-codeblock lines', () => {
    expect(MarkdownCodeBlock.parse(markdown.headingLines, 0)).toBeUndefined();
    expect(MarkdownCodeBlock.parse(markdown.includeLines, 0)).toBeUndefined();
    expect(MarkdownCodeBlock.parse(markdown.metadataLines, 0)).toBeUndefined();
    expect(MarkdownCodeBlock.parse(markdown.namespaceLines, 0)).toBeUndefined();
    expect(MarkdownCodeBlock.parse(markdown.plainTextLines, 0)).toBeUndefined();
    expect(
      MarkdownCodeBlock.parse(markdown.tabbedSectionLines, 0),
    ).toBeUndefined();
    expect(MarkdownCodeBlock.parse(markdown.tableLines, 0)).toBeUndefined();
  });
});

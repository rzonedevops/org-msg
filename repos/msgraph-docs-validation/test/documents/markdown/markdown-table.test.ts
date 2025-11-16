// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownTable from '../../../src/documents/markdown/markdown-table';
import * as markdown from './markdown-data';

describe('MarkdownTable', () => {
  test('parses table correctly', () => {
    const table = MarkdownTable.parse(markdown.tableLines, 0);
    expect(table).toBeDefined();
    expect(table).toHaveProperty('type', MarkdownTable.name);
    expect(table).toHaveProperty('lineNumber', 1);
    expect(table).toHaveProperty('totalLineCount', markdown.tableLines.length);
    expect(table).toHaveProperty('headers');
    expect(table?.headers).toHaveLength(2);
    expect(table).toHaveProperty('rows');
    expect(table?.rows).toHaveLength(1);
  });

  test('parses table with whitespace padding correctly', () => {
    const table = MarkdownTable.parse(markdown.tableLines, 0);
    expect(table).toBeDefined();
    expect(table).toHaveProperty('type', MarkdownTable.name);
    expect(table).toHaveProperty('lineNumber', 1);
    expect(table).toHaveProperty('totalLineCount', markdown.tableLines.length);
    expect(table).toHaveProperty('headers');
    expect(table?.headers).toHaveLength(2);
    expect(table).toHaveProperty('rows');
    expect(table?.rows).toHaveLength(1);
    expect(table?.rows[0][0]).toEqual('Authorization');
  });

  test('does not parse non-table lines', () => {
    expect(MarkdownTable.parse(markdown.codeblockLines, 0)).toBeUndefined();
    expect(MarkdownTable.parse(markdown.headingLines, 0)).toBeUndefined();
    expect(MarkdownTable.parse(markdown.includeLines, 0)).toBeUndefined();
    expect(MarkdownTable.parse(markdown.metadataLines, 0)).toBeUndefined();
    expect(MarkdownTable.parse(markdown.namespaceLines, 0)).toBeUndefined();
    expect(MarkdownTable.parse(markdown.plainTextLines, 0)).toBeUndefined();
    expect(MarkdownTable.parse(markdown.tabbedSectionLines, 0)).toBeUndefined();
  });
});

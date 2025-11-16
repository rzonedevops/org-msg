// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownInclude from '../../../src/documents/markdown/markdown-include';
import * as markdown from './markdown-data';

describe('MarkdownInclude', () => {
  test('parses include correctly', () => {
    const include = MarkdownInclude.parse(markdown.includeLines[0], 0);
    expect(include).toBeDefined();
    expect(include).toHaveProperty('type', MarkdownInclude.name);
    expect(include).toHaveProperty('lineNumber', 1);
    expect(include).toHaveProperty('label', 'beta-disclaimer');
    expect(include).toHaveProperty(
      'filePath',
      '../../includes/beta-disclaimer.md',
    );
  });

  test('parses include without label correctly', () => {
    const include = MarkdownInclude.parse(
      markdown.includeLinesWithoutLabel[0],
      0,
    );
    expect(include).toBeDefined();
    expect(include).toHaveProperty('type', MarkdownInclude.name);
    expect(include).toHaveProperty('lineNumber', 1);
    expect(include).toHaveProperty('label', '');
    expect(include).toHaveProperty(
      'filePath',
      '../../includes/beta-disclaimer.md',
    );
  });

  test('does not parse non-include lines', () => {
    expect(
      MarkdownInclude.parse(markdown.codeblockLines[0], 0),
    ).toBeUndefined();
    expect(MarkdownInclude.parse(markdown.headingLines[0], 0)).toBeUndefined();
    expect(MarkdownInclude.parse(markdown.metadataLines[0], 0)).toBeUndefined();
    expect(
      MarkdownInclude.parse(markdown.namespaceLines[0], 0),
    ).toBeUndefined();
    for (const line of markdown.plainTextLines) {
      expect(MarkdownInclude.parse(line, 0)).toBeUndefined();
    }
    expect(
      MarkdownInclude.parse(markdown.tabbedSectionLines[0], 0),
    ).toBeUndefined();
    expect(MarkdownInclude.parse(markdown.tableLines[0], 0)).toBeUndefined();
  });
});

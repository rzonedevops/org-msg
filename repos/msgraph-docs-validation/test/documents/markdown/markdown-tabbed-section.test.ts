// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownTabbedSection from '../../../src/documents/markdown/markdown-tabbed-section';
import * as markdown from './markdown-data';

describe('MarkdownTabbedSection', () => {
  test('parses tabbed section correctly', () => {
    const tabbedSection = MarkdownTabbedSection.parse(
      markdown.tabbedSectionLines,
      0,
    );
    expect(tabbedSection).toBeDefined();
    expect(tabbedSection).toHaveProperty('type', MarkdownTabbedSection.name);
    expect(tabbedSection).toHaveProperty('lineNumber', 1);
    expect(tabbedSection).toHaveProperty(
      'totalLineCount',
      markdown.tabbedSectionLines.length,
    );
    expect(tabbedSection).toHaveProperty('sections');
    expect(tabbedSection?.sections).toHaveLength(7);
  });

  test('does not parse non-tabbed section lines', () => {
    expect(
      MarkdownTabbedSection.parse(markdown.codeblockLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownTabbedSection.parse(markdown.headingLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownTabbedSection.parse(markdown.includeLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownTabbedSection.parse(markdown.metadataLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownTabbedSection.parse(markdown.namespaceLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownTabbedSection.parse(markdown.plainTextLines, 0),
    ).toBeUndefined();
    expect(MarkdownTabbedSection.parse(markdown.tableLines, 0)).toBeUndefined();
  });
});

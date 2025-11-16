// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownHeading from '../../../src/documents/markdown/markdown-heading';
import * as markdown from './markdown-data';

describe('MarkdownHeading', () => {
  test('parses heading correctly', () => {
    const heading = MarkdownHeading.parse(markdown.headingLines[0], 0);
    expect(heading).toBeDefined();
    expect(heading).toHaveProperty('type', MarkdownHeading.name);
    expect(heading).toHaveProperty('lineNumber', 1);
    expect(heading).toHaveProperty('level', 2);
    expect(heading).toHaveProperty('title', 'Properties');
  });

  test('parses heading with leading whitespace correctly', () => {
    const heading = MarkdownHeading.parse(
      markdown.headingLinesWithLeadingWhitespace[0],
      0,
    );
    expect(heading).toBeDefined();
    expect(heading).toHaveProperty('type', MarkdownHeading.name);
    expect(heading).toHaveProperty('lineNumber', 1);
    expect(heading).toHaveProperty('level', 1);
    expect(heading).toHaveProperty(
      'title',
      'secureScoreControlStateUpdate resource type',
    );
  });

  test('does not parse non-heading lines', () => {
    expect(
      MarkdownHeading.parse(markdown.codeblockLines[0], 0),
    ).toBeUndefined();
    expect(MarkdownHeading.parse(markdown.includeLines[0], 0)).toBeUndefined();
    expect(MarkdownHeading.parse(markdown.metadataLines[0], 0)).toBeUndefined();
    expect(
      MarkdownHeading.parse(markdown.namespaceLines[0], 0),
    ).toBeUndefined();
    for (const line of markdown.plainTextLines) {
      expect(MarkdownHeading.parse(line, 0)).toBeUndefined();
    }
    expect(
      MarkdownHeading.parse(markdown.tabbedSectionLines[0], 0),
    ).toBeUndefined();
    expect(MarkdownHeading.parse(markdown.tableLines[0], 0)).toBeUndefined();
  });
});

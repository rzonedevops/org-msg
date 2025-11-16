// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownNamespace from '../../../src/documents/markdown/markdown-namespace';
import * as markdown from './markdown-data';

describe('MarkdownNamespace', () => {
  test('parses namespace correctly', () => {
    const namespace = MarkdownNamespace.parse(markdown.namespaceLines[0], 0);
    expect(namespace).toBeDefined();
    expect(namespace).toHaveProperty('type', MarkdownNamespace.name);
    expect(namespace).toHaveProperty('lineNumber', 1);
    expect(namespace).toHaveProperty('namespace', 'microsoft.graph');
  });

  test('parses long namespace correctly', () => {
    const namespace = MarkdownNamespace.parse(
      markdown.namespaceLinesWithLongerName[0],
      0,
    );
    expect(namespace).toBeDefined();
    expect(namespace).toHaveProperty('type', MarkdownNamespace.name);
    expect(namespace).toHaveProperty('lineNumber', 1);
    expect(namespace).toHaveProperty(
      'namespace',
      'microsoft.graph.lorem.ipsum',
    );
  });

  test('does not parse non-namespace lines', () => {
    expect(
      MarkdownNamespace.parse(markdown.codeblockLines[0], 0),
    ).toBeUndefined();
    expect(
      MarkdownNamespace.parse(markdown.headingLines[0], 0),
    ).toBeUndefined();
    expect(
      MarkdownNamespace.parse(markdown.includeLines[0], 0),
    ).toBeUndefined();
    expect(
      MarkdownNamespace.parse(markdown.metadataLines[0], 0),
    ).toBeUndefined();
    for (const line of markdown.plainTextLines) {
      expect(MarkdownNamespace.parse(line, 0)).toBeUndefined();
    }
    expect(
      MarkdownNamespace.parse(markdown.tabbedSectionLines[0], 0),
    ).toBeUndefined();
    expect(MarkdownNamespace.parse(markdown.tableLines[0], 0)).toBeUndefined();
  });
});

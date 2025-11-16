// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD007 from '../../src/rules/MGD007';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD007();

const orderedSnippetsFile = './test/testData/snippets-in-order.md';
const unorderedSnippetsFile = './test/testData/snippets-out-of-order.md';
const httpNotFirstSnippetsFile = './test/testData/snippets-http-not-first.md';

describe('Tabbed snippet sections', () => {
  test('with snippets out of alphabetical order do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(unorderedSnippetsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(1);

    expect(problems[0]).toHaveProperty('id', 'MGD007');
    expect(problems[0]).toHaveProperty(
      'description',
      'Tabbed section CLI is out of alphabetical order',
    );
    expect(problems[0]).toHaveProperty('location.line', 34);
    expect(problems[0]).toHaveProperty('location.column', 0);
    expect(problems[0]).toHaveProperty('location.length', 17);
  });

  test('with HTTP snippet not appearing first do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(httpNotFirstSnippetsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(3);

    expect(problems[0]).toHaveProperty('id', 'MGD007');
    expect(problems[0]).toHaveProperty(
      'description',
      'Tabbed section CLI is first in list of tabs, HTTP must be first',
    );
    expect(problems[0]).toHaveProperty('location.line', 17);
    expect(problems[0]).toHaveProperty('location.column', 0);
    expect(problems[0]).toHaveProperty('location.length', 17);

    expect(problems[1]).toHaveProperty('id', 'MGD007');
    expect(problems[1]).toHaveProperty(
      'description',
      'HTTP tab must be first in the list of tabs',
    );
    expect(problems[1]).toHaveProperty('location.line', 21);
    expect(problems[1]).toHaveProperty('location.column', 0);
    expect(problems[1]).toHaveProperty('location.length', 19);

    expect(problems[2]).toHaveProperty('id', 'MGD007');
    expect(problems[2]).toHaveProperty(
      'description',
      'Tabbed section C# is out of alphabetical order',
    );
    expect(problems[2]).toHaveProperty('location.line', 30);
    expect(problems[2]).toHaveProperty('location.column', 0);
    expect(problems[2]).toHaveProperty('location.length', 19);
  });

  test('with snippets in order validate', async () => {
    const document = await MarkdownDocument.LoadAsync(orderedSnippetsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(0);
  });
});

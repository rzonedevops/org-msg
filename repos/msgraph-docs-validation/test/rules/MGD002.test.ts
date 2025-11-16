// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD002 from '../../src/rules/MGD002';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD002();

describe('beta topics', () => {
  test('with disclaimer are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/api-reference/beta/hasDisclaimer.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('without disclaimer are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/api-reference/beta/noDisclaimer.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD002');
    expect(problems[0]).toHaveProperty(
      'description',
      'Missing required beta disclaimer',
    );
  });

  test('with multiple disclaimers are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/api-reference/beta/hasTwoDisclaimers.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD002');
    expect(problems[0]).toHaveProperty(
      'description',
      'Beta disclaimer appears more than once',
    );
    expect(problems[0].location).toBeDefined();
  });
});

describe('non-beta topics', () => {
  test('with disclaimer are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/api-reference/v1.0/hasDisclaimer.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD002');
    expect(problems[0]).toHaveProperty(
      'description',
      'Beta disclaimer should not be included in non-beta topics',
    );
    expect(problems[0].location).toBeDefined();
  });

  test('without disclaimer are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/api-reference/v1.0/noDisclaimer.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('with multiple disclaimers are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/api-reference/v1.0/hasTwoDisclaimers.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(2);
    expect(problems[0]).toHaveProperty('id', 'MGD002');
    expect(problems[0]).toHaveProperty(
      'description',
      'Beta disclaimer should not be included in non-beta topics',
    );
    expect(problems[0].location).toBeDefined();
    expect(problems[1]).toHaveProperty('id', 'MGD002');
    expect(problems[1]).toHaveProperty(
      'description',
      'Beta disclaimer should not be included in non-beta topics',
    );
    expect(problems[1].location).toBeDefined();
  });
});

describe('non-reference topics', () => {
  test('with disclaimer are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/concepts/hasDisclaimer.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('without disclaimer are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/concepts/noDisclaimer.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('with multiple disclaimers are validated properly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      './test/testData/concepts/hasTwoDisclaimers.md',
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD002');
    expect(problems[0]).toHaveProperty(
      'description',
      'Beta disclaimer appears more than once',
    );
    expect(problems[0].location).toBeDefined();
  });
});

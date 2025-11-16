// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD009 from '../../src/rules/MGD009';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD009();

const consistentTabsFile =
  './test/testData/MGD009/consistent-tabbed-section.md';
const additionalTabsFile =
  './test/testData/MGD009/inconsistent-tabbed-section-additional.md';
const missingTabsFile =
  './test/testData/MGD009/inconsistent-tabbed-section-missing.md';
const outOfOrderTabsFile =
  './test/testData/MGD009/inconsistent-tabbed-section-order.md';

describe('Multiple tabbed sections in a document', () => {
  test('with consistent tabs validate', async () => {
    const document = await MarkdownDocument.LoadAsync(consistentTabsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(0);
  });

  test('with additional tabs in subsequent sections do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(additionalTabsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(1);

    expect(problems[0]).toHaveProperty('id', 'MGD009');
    expect(problems[0]).toHaveProperty(
      'description',
      'Tab is not consistent with tabs in first tabbed section that starts at line 20',
    );
    expect(problems[0]).toHaveProperty('location.line', 110);
    expect(problems[0]).toHaveProperty('location.column', 0);
    expect(problems[0]).toHaveProperty('location.length', 19);
  });

  test('with missing tabs in subsequent sections do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(missingTabsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(3);

    expect(problems[0]).toHaveProperty('id', 'MGD009');
    expect(problems[0]).toHaveProperty(
      'description',
      'Tab is not consistent with tabs in first tabbed section that starts at line 20',
    );
    expect(problems[0]).toHaveProperty('location.line', 94);
    expect(problems[0]).toHaveProperty('location.column', 0);
    expect(problems[0]).toHaveProperty('location.length', 17);

    expect(problems[1]).toHaveProperty('id', 'MGD009');
    expect(problems[1]).toHaveProperty(
      'description',
      'Tab is not consistent with tabs in first tabbed section that starts at line 20',
    );
    expect(problems[1]).toHaveProperty('location.line', 98);
    expect(problems[1]).toHaveProperty('location.column', 0);
    expect(problems[1]).toHaveProperty('location.length', 31);

    expect(problems[2]).toHaveProperty('id', 'MGD009');
    expect(problems[2]).toHaveProperty(
      'description',
      'Tab is not consistent with tabs in first tabbed section that starts at line 20',
    );
    expect(problems[2]).toHaveProperty('location.line', 102);
    expect(problems[2]).toHaveProperty('location.column', 0);
    expect(problems[2]).toHaveProperty('location.length', 23);
  });

  test('with tabs out of order in subsequent sections do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(outOfOrderTabsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(2);

    expect(problems[0]).toHaveProperty('id', 'MGD009');
    expect(problems[0]).toHaveProperty(
      'description',
      'Tab is not consistent with tabs in first tabbed section that starts at line 20',
    );
    expect(problems[0]).toHaveProperty('location.line', 82);
    expect(problems[0]).toHaveProperty('location.column', 0);
    expect(problems[0]).toHaveProperty('location.length', 17);

    expect(problems[1]).toHaveProperty('id', 'MGD009');
    expect(problems[1]).toHaveProperty(
      'description',
      'Tab is not consistent with tabs in first tabbed section that starts at line 20',
    );
    expect(problems[1]).toHaveProperty('location.line', 98);
    expect(problems[1]).toHaveProperty('location.column', 0);
    expect(problems[1]).toHaveProperty('location.length', 17);
  });
});

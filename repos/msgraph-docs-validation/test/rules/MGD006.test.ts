// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD006 from '../../src/rules/MGD006';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD006();

const requestUrlFile = './test/testData/request-urls.md';

describe('API URLs in HTTP request section', () => {
  test('with version and/or host do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(requestUrlFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(2);
    expect(problems[0]).toHaveProperty('id', 'MGD006');
    expect(problems[0]).toHaveProperty(
      'description',
      'API URLs in HTTP request section should be relative and not contain version',
    );
    expect(problems[0]).toHaveProperty('location.line', 46);
    expect(problems[0]).toHaveProperty('location.column', 4);
    expect(problems[0]).toHaveProperty('location.length', 5);

    expect(problems[1]).toHaveProperty('id', 'MGD006');
    expect(problems[1]).toHaveProperty(
      'description',
      'API URLs in HTTP request section should be relative and not contain version',
    );
    expect(problems[1]).toHaveProperty('location.line', 53);
    expect(problems[1]).toHaveProperty('location.column', 4);
    expect(problems[1]).toHaveProperty('location.length', 32);
  });
});

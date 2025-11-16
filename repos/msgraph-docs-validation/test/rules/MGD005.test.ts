// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD005 from '../../src/rules/MGD005';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD005();

const correctVersionBetaFile =
  './test/testData/api-reference/beta/correct-version.md';
const incorrectVersionBetaFile =
  './test/testData/api-reference/beta/incorrect-version.md';
const correctVersionV1File =
  './test/testData/api-reference/v1.0/correct-version.md';
const incorrectVersionV1File =
  './test/testData/api-reference/v1.0/incorrect-version.md';

describe('example API URLs', () => {
  describe('with correct API versions in examples validate', () => {
    test('beta', async () => {
      const document = await MarkdownDocument.LoadAsync(correctVersionBetaFile);
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(0);
    });
    test('v1.0', async () => {
      const document = await MarkdownDocument.LoadAsync(correctVersionV1File);
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(0);
    });
  });

  describe('with incorrect API versions in examples do not validate', () => {
    test('beta', async () => {
      const document = await MarkdownDocument.LoadAsync(
        incorrectVersionBetaFile,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(2);
      expect(problems[0]).toHaveProperty('id', 'MGD005');
      expect(problems[0]).toHaveProperty(
        'description',
        "Incorrect version 'v1.0' in API URL",
      );
      expect(problems[0]).toHaveProperty('location.line', 99);
      expect(problems[0]).toHaveProperty('location.column', 32);
      expect(problems[0]).toHaveProperty('location.length', 4);
    });
    test('v1.0', async () => {
      const document = await MarkdownDocument.LoadAsync(incorrectVersionV1File);
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(2);
      expect(problems[0]).toHaveProperty('id', 'MGD005');
      expect(problems[0]).toHaveProperty(
        'description',
        "Incorrect version 'beta' in API URL",
      );
      expect(problems[0]).toHaveProperty('location.line', 99);
      expect(problems[0]).toHaveProperty('location.column', 32);
      expect(problems[0]).toHaveProperty('location.length', 4);
    });
  });
});

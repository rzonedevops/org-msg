// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { expect, jest, test } from '@jest/globals';
import Validator from '../../src/rules/validator';
import MarkdownDocument from '../../src/documents/markdown-document';
import Document from '../../src/documents/document';
import rules from '../../src/rules/rules';

const allRules = rules.map((value) => value.constructor.name);

const mockLog = jest.fn((_message: string) => {
  return;
});

const validator = new Validator(mockLog);

test('Validating with all rules disabled returns no results', async () => {
  const docs = await validator.validateDocumentSet('./test/testData', {
    disabledRules: allRules,
    includeFiles: '**/**.md',
  });

  expect(docs).toHaveLength(0);
  // Log should only happen twice:
  // Once to output list of rules being disabled
  // Once to inform all rules have been disabled
  expect(mockLog).toHaveBeenCalledTimes(2);
});

test('Loading Markdown file returns a MarkdownDocument', async () => {
  const document = await validator.loadDocument(
    './test/testData/validYamlHeader.md',
  );
  expect(document).toBeInstanceOf(MarkdownDocument);
});

test('Loading text file returns a Document', async () => {
  const document = await validator.loadDocument('./test/testData/textFile.txt');
  expect(document).toBeInstanceOf(Document);
});

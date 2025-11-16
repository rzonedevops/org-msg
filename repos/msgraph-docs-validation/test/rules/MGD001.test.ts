// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { expect, test } from '@jest/globals';
import MGD001 from '../../src/rules/MGD001';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD001();

test('File with valid YAML validates properly', async () => {
  const document = await MarkdownDocument.LoadAsync(
    './test/testData/validYamlHeader.md',
  );
  const problems = await rule.validate(document);
  expect(problems).toHaveLength(0);
});

test('File with no YAML validates properly', async () => {
  const document = await MarkdownDocument.LoadAsync(
    './test/testData/noYamlHeader.md',
  );
  const problems = await rule.validate(document);
  expect(problems).toHaveLength(1);
  expect(problems[0]).toHaveProperty('id', 'MGD001');
  expect(problems[0]).toHaveProperty('description', 'YAML header missing');
});

test('File with incomplete YAML validates properly', async () => {
  const document = await MarkdownDocument.LoadAsync(
    './test/testData/invalidYamlHeader.md',
  );
  const problems = await rule.validate(document);
  expect(problems).toHaveLength(2);
  expect(problems[0]).toHaveProperty('id', 'MGD001');
  expect(problems[0]).toHaveProperty(
    'description',
    'YAML header missing required attribute "author"',
  );
  expect(problems[1]).toHaveProperty('id', 'MGD001');
  expect(problems[1]).toHaveProperty(
    'description',
    'YAML header missing required attribute "doc_type"',
  );
});

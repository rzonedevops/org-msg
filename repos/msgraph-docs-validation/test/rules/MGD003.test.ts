// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD003 from '../../src/rules/MGD003';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD003();

const fileWithAlphabeticalOrder = './test/testData/access-package.md';
const fileWithBadPropertiesTable = './test/testData/propertiesNotAlpha.md';
const fileWithBadPropertiesTable2 = './test/testData/propertiesNotAlpha2.md';
const fileWithBadRelationshipsTable =
  './test/testData/relationshipsNotAlpha.md';
const fileWithBadJsonRepresentation = './test/testData/jsonNotAlpha.md';
const fileWithMultilevelJson = './test/testData/access-package-resource.md';

describe('properties tables', () => {
  test('that are in alphabetical order pass validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithAlphabeticalOrder,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('that are not in alphabetical order fail validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithBadPropertiesTable,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD003');
    expect(problems[0]).toHaveProperty(
      'description',
      `Properties table row 'description' is out of alphabetical order`,
    );
    expect(problems[0].location).toBeDefined();
    expect(problems[0]).toHaveProperty('location.line', 42);
    expect(problems[0]).toHaveProperty('location.column', 1);
    expect(problems[0]).toHaveProperty('location.length', 11);
  });

  test('that are not in alphabetical order with whitespace fail validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithBadPropertiesTable2,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(2);
    expect(problems[0]).toHaveProperty('id', 'MGD003');
    expect(problems[0]).toHaveProperty(
      'description',
      `Properties table row 'appsForWindows' is out of alphabetical order`,
    );
    expect(problems[0].location).toBeDefined();
    expect(problems[0]).toHaveProperty('location.line', 30);
    expect(problems[0]).toHaveProperty('location.column', 2);
    expect(problems[0]).toHaveProperty('location.length', 14);

    expect(problems[1]).toHaveProperty('id', 'MGD003');
    expect(problems[1]).toHaveProperty(
      'description',
      `Properties table row 'appsForMac' is out of alphabetical order`,
    );
    expect(problems[1].location).toBeDefined();
    expect(problems[1]).toHaveProperty('location.line', 31);
    expect(problems[1]).toHaveProperty('location.column', 2);
    expect(problems[1]).toHaveProperty('location.length', 10);
  });
});

describe('relationship tables', () => {
  test('that are in alphabetical order pass validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithAlphabeticalOrder,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('that are not in alphabetical order fail validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithBadRelationshipsTable,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD003');
    expect(problems[0]).toHaveProperty(
      'description',
      `Relationships table row 'catalog' is out of alphabetical order`,
    );
    expect(problems[0].location).toBeDefined();
    expect(problems[0]).toHaveProperty('location.line', 53);
    expect(problems[0]).toHaveProperty('location.column', 1);
    expect(problems[0]).toHaveProperty('location.length', 7);
  });
});

describe('JSON representations', () => {
  test('that are in alphabetical order pass validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithAlphabeticalOrder,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });

  test('that are not in alphabetical order fail validation', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithBadJsonRepresentation,
    );
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(1);
    expect(problems[0]).toHaveProperty('id', 'MGD003');
    expect(problems[0]).toHaveProperty(
      'description',
      `Property in JSON representation 'createdDateTime' is out of alphabetical order`,
    );
    expect(problems[0].location).toBeDefined();
    expect(problems[0]).toHaveProperty('location.line', 73);
    expect(problems[0]).toHaveProperty('location.column', 3);
    expect(problems[0]).toHaveProperty('location.length', 15);
  });

  test('only validate top-level properties', async () => {
    const document = await MarkdownDocument.LoadAsync(fileWithMultilevelJson);
    const problems = await rule.validate(document);
    expect(problems).toHaveLength(0);
  });
});

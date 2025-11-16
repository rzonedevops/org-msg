// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD004 from '../../src/rules/MGD004';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD004();

const orderedFileWithAllCrudOnly =
  './test/testData/MGD004/ordered/all5CrudOnly.md';
const orderedFileWithAllCrudAndAdditional =
  './test/testData/MGD004/ordered/all5CrudWithAdditional.md';
const orderedFileWithOmittedCrudOnly =
  './test/testData/MGD004/ordered/omittedCrudOnly.md';
const orderedFileWithOmittedCrudAndAdditional =
  './test/testData/MGD004/ordered/omittedCrudWithAdditional.md';

const unorderedFileWithAllCrudOnly =
  './test/testData/MGD004/unordered/all5CrudOnly.md';
const unorderedFileWithAllCrudAndAdditional =
  './test/testData/MGD004/unordered/all5CrudWithAdditional.md';
const unorderedFileWithAllCrudAndAdditionalMixed =
  './test/testData/MGD004/unordered/all5CrudWithAdditionalMixed.md';
const unorderedFileWithOmittedCrudOnly =
  './test/testData/MGD004/unordered/omittedCrudOnly.md';
const unorderedFileWithOmittedCrudAndAdditional =
  './test/testData/MGD004/unordered/omittedCrudWithAdditional.md';
const unorderedFileWithOmittedCrudAndAdditionalMixed =
  './test/testData/MGD004/unordered/omittedCrudWithAdditionalMixed.md';
const unorderedFileWithMultipleRows = './test/testData/MGD004/term.md';

describe('methods tables', () => {
  describe('in correct CRUD order validate', () => {
    test('with all five CRUD operations only', async () => {
      const document = await MarkdownDocument.LoadAsync(
        orderedFileWithAllCrudOnly,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(0);
    });

    test('with all five CRUD operations and additional rows', async () => {
      const document = await MarkdownDocument.LoadAsync(
        orderedFileWithAllCrudAndAdditional,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(0);
    });

    test('with omitted CRUD operations', async () => {
      const document = await MarkdownDocument.LoadAsync(
        orderedFileWithOmittedCrudOnly,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(0);
    });

    test('with omitted CRUD operations and additional rows', async () => {
      const document = await MarkdownDocument.LoadAsync(
        orderedFileWithOmittedCrudAndAdditional,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(0);
    });
  });

  describe('in incorrect CRUD order do not validate', () => {
    test('with all five CRUD operations only', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithAllCrudOnly,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(1);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "Update accessPackage" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 25);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 116);
    });

    test('with all five CRUD operations and additional rows', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithAllCrudAndAdditional,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(1);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "List accessPackages" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 22);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 168);
    });

    test('with all five CRUD operations and additional rows with CRUD mixed into actions', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithAllCrudAndAdditionalMixed,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(1);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "List accessPackages" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 34);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 168);
    });

    test('with omitted CRUD operations', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithOmittedCrudOnly,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(1);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "Create accessPackage" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 23);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 151);
    });

    test('with omitted CRUD operations and additional rows', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithOmittedCrudAndAdditional,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(1);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "Get accessPackage" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 24);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 151);
    });

    test('with omitted CRUD operations and additional rows with CRUD mixed into actions', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithOmittedCrudAndAdditionalMixed,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(1);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "Get accessPackage" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 27);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 151);
    });

    test('with multiple rows out of order', async () => {
      const document = await MarkdownDocument.LoadAsync(
        unorderedFileWithMultipleRows,
      );
      const problems = await rule.validate(document);
      expect(problems).toHaveLength(4);
      expect(problems[0]).toHaveProperty('id', 'MGD004');
      expect(problems[0]).toHaveProperty(
        'description',
        'Methods table row "Create term" is not in the required order for CRUD operations',
      );
      expect(problems[0]).toHaveProperty('location.line', 24);
      expect(problems[0]).toHaveProperty('location.column', 0);
      expect(problems[0]).toHaveProperty('location.length', 155);

      expect(problems[1]).toHaveProperty('id', 'MGD004');
      expect(problems[1]).toHaveProperty(
        'description',
        'Methods table row "Get term" is not in the required order for CRUD operations',
      );
      expect(problems[1]).toHaveProperty('location.line', 25);
      expect(problems[1]).toHaveProperty('location.column', 0);
      expect(problems[1]).toHaveProperty('location.length', 182);

      expect(problems[2]).toHaveProperty('id', 'MGD004');
      expect(problems[2]).toHaveProperty(
        'description',
        'Methods table row "Update term" is not in the required order for CRUD operations',
      );
      expect(problems[2]).toHaveProperty('location.line', 26);
      expect(problems[2]).toHaveProperty('location.column', 0);
      expect(problems[2]).toHaveProperty('location.length', 171);

      expect(problems[3]).toHaveProperty('id', 'MGD004');
      expect(problems[3]).toHaveProperty(
        'description',
        'Methods table row "Delete term" is not in the required order for CRUD operations',
      );
      expect(problems[3]).toHaveProperty('location.line', 27);
      expect(problems[3]).toHaveProperty('location.column', 0);
      expect(problems[3]).toHaveProperty('location.length', 93);
    });
  });
});

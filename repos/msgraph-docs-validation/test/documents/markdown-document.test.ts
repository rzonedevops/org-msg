// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownDocument from '../../src/documents/markdown-document';
import { readFile } from 'fs/promises';
import { TextDocument } from 'vscode-languageserver-textdocument';

const mdFile = './test/testData/validYamlHeader.md';
const fileWithThreeSections = './test/testData/fileWithThreeSections.md';
const resourceTopic = './test/testData/access-package.md';
const fileWithUnexpectedTokenInYaml =
  './test/testData/unexpectedTokenInYaml.md';

describe('MarkdownDocument', () => {
  test('loads from file correctly', async () => {
    const mdFileContents = await readFile(mdFile, 'utf-8');
    const document = await MarkdownDocument.LoadAsync(mdFile);
    expect(document).toHaveProperty('filePath', mdFile);
    expect(document).toHaveProperty('content', mdFileContents);
    expect(document).toHaveProperty('contentLines');
    expect(document.contentLines).toHaveLength(9);
    expect(document).toHaveProperty('docProblems');
    expect(document.docProblems).toHaveLength(0);
    expect(document).toHaveProperty('topicType', 1);
    expect(document).toHaveProperty('docParts');
    expect(document.docParts).toHaveLength(1);
    expect(document).toHaveProperty('docSections');
    expect(document.docSections).toHaveLength(1);
    expect(document).toHaveProperty('yamlHeader');
    expect(document.yamlHeader).toBeDefined();
    expect(document).toHaveProperty('yamlHeader.author', 'author');
    expect(document).toHaveProperty('yamlHeader.description', 'Description');
    expect(document).toHaveProperty(
      'yamlHeader.doc_type',
      'conceptualPageType',
    );
    expect(document).toHaveProperty('yamlHeader.title', 'Title');
  });

  test('loads from VS Code TextDocument correctly', async () => {
    const mdFileContents = await readFile(mdFile, 'utf-8');
    const textDocument = TextDocument.create(
      mdFile,
      'markdown',
      0,
      mdFileContents,
    );
    const document = await MarkdownDocument.LoadAsync(textDocument);
    expect(document).toHaveProperty('filePath', mdFile);
    expect(document).toHaveProperty('content', mdFileContents);
    expect(document).toHaveProperty('contentLines');
    expect(document.contentLines).toHaveLength(9);
    expect(document).toHaveProperty('docProblems');
    expect(document.docProblems).toHaveLength(0);
    expect(document).toHaveProperty('topicType', 1);
    expect(document).toHaveProperty('docParts');
    expect(document.docParts).toHaveLength(1);
    expect(document).toHaveProperty('docSections');
    expect(document.docSections).toHaveLength(1);
    expect(document).toHaveProperty('yamlHeader');
    expect(document.yamlHeader).toBeDefined();
    expect(document).toHaveProperty('yamlHeader.author', 'author');
    expect(document).toHaveProperty('yamlHeader.description', 'Description');
    expect(document).toHaveProperty(
      'yamlHeader.doc_type',
      'conceptualPageType',
    );
    expect(document).toHaveProperty('yamlHeader.title', 'Title');
  });

  test('parses sections correctly', async () => {
    const document = await MarkdownDocument.LoadAsync(fileWithThreeSections);
    expect(document.docSections).toHaveLength(3);
    expect(document.docSections[0]).toHaveProperty('title', 'Title');
    expect(document.docSections[0]).toHaveProperty('startIndex', 0);
    expect(document.docSections[0]).toHaveProperty('endIndex', 1);
    expect(document.docSections[1]).toHaveProperty('title', 'Subsection');
    expect(document.docSections[1]).toHaveProperty('startIndex', 2);
    expect(document.docSections[1]).toHaveProperty('endIndex', 4);
    expect(document.docSections[2]).toHaveProperty('title', 'Final section');
    expect(document.docSections[2]).toHaveProperty('startIndex', 5);
    expect(document.docSections[2]).toHaveProperty('endIndex', 8);
  });

  test('loads resource elements correctly', async () => {
    const document = await MarkdownDocument.LoadAsync(resourceTopic);
    expect(document.resourceElements).toBeDefined();
    expect(document.resourceElements).toHaveProperty(
      'resourceName',
      'accessPackage',
    );
    expect(document.resourceElements).toHaveProperty('methodTableIndex', 5);
    expect(document.resourceElements).toHaveProperty('propertiesTableIndex', 7);
    expect(document.resourceElements).toHaveProperty(
      'relationShipsTableIndex',
      9,
    );
    expect(document.resourceElements).toHaveProperty(
      'jsonRepresentationIndex',
      13,
    );
  });

  test('handles malformed YAML correctly', async () => {
    const document = await MarkdownDocument.LoadAsync(
      fileWithUnexpectedTokenInYaml,
    );

    expect(document).toBeDefined();
    expect(document.yamlHeader).toBeUndefined();
  });
});

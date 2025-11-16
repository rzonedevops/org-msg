// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import Document from '../../src/documents/document';
import { readFile } from 'fs/promises';
import { TextDocument } from 'vscode-languageserver-textdocument';

const textFile = './test/testData/textFile.txt';

describe('Document', () => {
  test('loads from file correctly', async () => {
    const textFileContents = await readFile(textFile, 'utf-8');
    const document = await Document.LoadAsync(textFile);
    expect(document).toHaveProperty('filePath', textFile);
    expect(document).toHaveProperty('content', textFileContents);
    expect(document).toHaveProperty('contentLines');
    expect(document.contentLines).toHaveLength(2);
    expect(document).toHaveProperty('docProblems');
    expect(document.docProblems).toHaveLength(0);
  });

  test('loads from VS Code TextDocument correctly', async () => {
    const textFileContents = await readFile(textFile, 'utf-8');
    const textDocument = TextDocument.create(
      textFile,
      'text',
      0,
      textFileContents,
    );
    const document = await Document.LoadAsync(textDocument);
    expect(document).toHaveProperty('filePath', textFile);
    expect(document).toHaveProperty('content', textFileContents);
    expect(document).toHaveProperty('contentLines');
    expect(document.contentLines).toHaveLength(2);
    expect(document).toHaveProperty('docProblems');
    expect(document.docProblems).toHaveLength(0);
  });
});

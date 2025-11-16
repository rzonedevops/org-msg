// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD008 from '../../src/rules/MGD008';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD008();

const incorrectLanguageTabsFile = './test/testData/language-tabs.md';

describe('Programming language tabs in tabbed sections', () => {
  test('with incorrect titles or anchors do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(
      incorrectLanguageTabsFile,
    );
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(7);

    expect(problems[0]).toHaveProperty('id', 'MGD008');
    expect(problems[0]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[HTTP](#tab/http)' (case-sensitive)",
    );
    expect(problems[0]).toHaveProperty('location.line', 45);
    expect(problems[0]).toHaveProperty('location.column', 0);
    expect(problems[0]).toHaveProperty('location.length', 19);

    expect(problems[1]).toHaveProperty('id', 'MGD008');
    expect(problems[1]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[C#](#tab/csharp)' (case-sensitive)",
    );
    expect(problems[1]).toHaveProperty('location.line', 51);
    expect(problems[1]).toHaveProperty('location.column', 0);
    expect(problems[1]).toHaveProperty('location.length', 15);

    expect(problems[2]).toHaveProperty('id', 'MGD008');
    expect(problems[2]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[CLI](#tab/cli)' (case-sensitive)",
    );
    expect(problems[2]).toHaveProperty('location.line', 55);
    expect(problems[2]).toHaveProperty('location.column', 0);
    expect(problems[2]).toHaveProperty('location.length', 17);

    expect(problems[3]).toHaveProperty('id', 'MGD008');
    expect(problems[3]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[Go](#tab/go)' (case-sensitive)",
    );
    expect(problems[3]).toHaveProperty('location.line', 59);
    expect(problems[3]).toHaveProperty('location.column', 0);
    expect(problems[3]).toHaveProperty('location.length', 15);

    expect(problems[4]).toHaveProperty('id', 'MGD008');
    expect(problems[4]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[Java](#tab/java)' (case-sensitive)",
    );
    expect(problems[4]).toHaveProperty('location.line', 63);
    expect(problems[4]).toHaveProperty('location.column', 0);
    expect(problems[4]).toHaveProperty('location.length', 20);

    expect(problems[5]).toHaveProperty('id', 'MGD008');
    expect(problems[5]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[JavaScript](#tab/javascript)' (case-sensitive)",
    );
    expect(problems[5]).toHaveProperty('location.line', 67);
    expect(problems[5]).toHaveProperty('location.column', 0);
    expect(problems[5]).toHaveProperty('location.length', 23);

    expect(problems[6]).toHaveProperty('id', 'MGD008');
    expect(problems[6]).toHaveProperty(
      'description',
      "Correct section anchor for this language is '[PowerShell](#tab/powershell)' (case-sensitive)",
    );
    expect(problems[6]).toHaveProperty('location.line', 75);
    expect(problems[6]).toHaveProperty('location.column', 0);
    expect(problems[6]).toHaveProperty('location.length', 23);
  });
});

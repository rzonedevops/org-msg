// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MGD010 from '../../src/rules/MGD010';
import MarkdownDocument from '../../src/documents/markdown-document';

const rule = new MGD010();

const emailsFile = './test/testData/MGD010/emails.md';
const urlsFile = './test/testData/MGD010/urls.md';

describe('Documents with onmicrosoft.com domains', () => {
  test('in email addresses do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(emailsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(4);

    expect(problems[0]).toHaveProperty('id', 'MGD010');
    expect(problems[0]).toHaveProperty(
      'description',
      '"admin@contoso.onmicrosoft.com" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.',
    );
    expect(problems[0]).toHaveProperty('location.line', 161);
    expect(problems[0]).toHaveProperty('location.column', 20);
    expect(problems[0]).toHaveProperty('location.length', 29);

    expect(problems[1]).toHaveProperty('id', 'MGD010');
    expect(problems[1]).toHaveProperty(
      'description',
      '"admin@contoso.onmicrosoft.com" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.',
    );
    expect(problems[1]).toHaveProperty('location.line', 167);
    expect(problems[1]).toHaveProperty('location.column', 20);
    expect(problems[1]).toHaveProperty('location.length', 29);

    expect(problems[2]).toHaveProperty('id', 'MGD010');
    expect(problems[2]).toHaveProperty(
      'description',
      '"admin@contoso.onmicrosoft.com" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.',
    );
    expect(problems[2]).toHaveProperty('location.line', 200);
    expect(problems[2]).toHaveProperty('location.column', 20);
    expect(problems[2]).toHaveProperty('location.length', 29);

    expect(problems[3]).toHaveProperty('id', 'MGD010');
    expect(problems[3]).toHaveProperty(
      'description',
      '"admin@contoso.onmicrosoft.com" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.',
    );
    expect(problems[3]).toHaveProperty('location.line', 206);
    expect(problems[3]).toHaveProperty('location.column', 20);
    expect(problems[3]).toHaveProperty('location.length', 29);
  });

  test('in urls do not validate', async () => {
    const document = await MarkdownDocument.LoadAsync(urlsFile);
    const problems = await rule.validate(document);

    expect(problems).toHaveLength(2);

    expect(problems[0]).toHaveProperty('id', 'MGD010');
    expect(problems[0]).toHaveProperty(
      'description',
      '"Contosolunchdelivery@contoso.onmicrosoft.com" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.',
    );
    expect(problems[0]).toHaveProperty('location.line', 125);
    expect(problems[0]).toHaveProperty('location.column', 58);
    expect(problems[0]).toHaveProperty('location.length', 44);

    expect(problems[1]).toHaveProperty('id', 'MGD010');
    expect(problems[1]).toHaveProperty(
      'description',
      '"contoso.onmicrosoft.com" uses an unapproved "onmicrosoft.com" domain name. Please see https://aka.ms/fictitious for guidance on approved fictitious domains.',
    );
    expect(problems[1]).toHaveProperty('location.line', 129);
    expect(problems[1]).toHaveProperty('location.column', 32);
    expect(problems[1]).toHaveProperty('location.length', 23);
  });
});

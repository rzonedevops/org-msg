// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import Validator, { ValidationOptions } from './rules/validator';
import Document from './documents/document';
import MarkdownDocument from './documents/markdown-document';
import Problem from './rules/problem';
import rules from './rules/rules';
import { writeFile } from 'fs/promises';

export { Document, MarkdownDocument, Problem, ValidationOptions, Validator };

async function main() {
  const validator = new Validator((message: string) => {
    console.log(message);
  });

  const allRules: string[] = [];
  rules.forEach((value) => {
    allRules.push(value.constructor.name);
  });

  const documents = await validator.validateDocumentSet(
    'C:/Source/Repos/msgraph-docs-validation/test/testData',
    {
      includeFiles: '**/**.md',
      ignoreFiles: '**/includes/**/**',
      disabledRules: [
        'yaml-header-present',
        'MGD002',
        'MGD003',
        'MGD004',
        'MGD005',
        'MGD006',
        'MGD007',
        'MGD008',
        'MGD009',
      ],
    },
  );

  await writeFile('./docs.json', JSON.stringify(documents, null, 2));

  // const documents = await validator.validateDocumentSet(
  //   'C:/Source/Repos/microsoft-graph-docs',
  //   {
  //     includeFiles: ['concepts/**/**.md', 'api-reference/**/**.md'],
  //     ignoreFiles: '**/includes/**/**',
  //     disabledRules: ['yaml-header-present', 'MGD002', 'MGD003'],
  //   }
  // );

  const docsWithProblems = documents.filter(
    (doc) => doc.docProblems.length > 0,
  );

  console.log(`${docsWithProblems.length} docs have problems`);
  if (docsWithProblems.length > 0) {
    const problemLines: string[] = [];

    for (const doc of docsWithProblems) {
      problemLines.push(doc.filePath + '\n');
      for (const problem of doc.docProblems) {
        problemLines.push(
          `  ${problem.id}${
            problem.location
              ? `[${problem.location.line},${problem.location.column}]`
              : ''
          }: ${problem.description}` + '\n',
        );
      }
    }

    await writeFile('./docProblems.txt', problemLines);
  }
}

main();

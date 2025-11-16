// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import Document from '../documents/document';
import MarkdownDocument from '../documents/markdown-document';
import LintRule from './lint-rule';
import rules from './rules';
import { extname } from 'path';
import { glob } from 'glob';
import { TextDocument } from 'vscode-languageserver-textdocument';

export type ValidationOptions = {
  includeFiles: string | string[];
  ignoreFiles?: string | string[];
  disabledRules?: string[];
};

export default class Validator {
  enabledRules: LintRule[] = [];
  supportedFileTypes = ['.md'];
  log?: (message: string) => void;

  constructor(log?: (message: string) => void) {
    this.enabledRules = rules;
    this.log = log;
  }

  private logMessage(message: string): void {
    if (this.log) {
      this.log(message);
    }
  }

  private disableRules(disabledRules?: string[]): LintRule[] {
    let filteredRules = rules;

    if (disabledRules && disabledRules.length > 0) {
      this.logMessage(
        `Disabling the following rules: ${disabledRules.join(',')}`,
      );

      // Make it case-insensitive
      disabledRules.forEach((value, index, array) => {
        array[index] = value.toUpperCase();
      });

      filteredRules = rules.filter(
        (rule) =>
          disabledRules.indexOf(rule.id.toUpperCase()) < 0 &&
          disabledRules.indexOf(rule.alias.toUpperCase()) < 0,
      );
    }

    return filteredRules;
  }

  public async validateDocumentSet(
    rootDirectory: string,
    options: ValidationOptions,
  ): Promise<Document[]> {
    // Disable rules if needed
    this.enabledRules = this.disableRules(options.disabledRules);
    if (this.enabledRules.length <= 0) {
      this.logMessage('All validation rules are disabled, aborting.');
      return [];
    }

    const startLoadDocs = new Date();
    const files = await glob(options.includeFiles, {
      ignore: options.ignoreFiles,
      cwd: rootDirectory,
      absolute: true,
      nocase: true,
    });

    // IMPORTANT: Need to load in a serial fashion here
    // Trying to load multiples async causes too many
    // open file handles
    const documents: Document[] = [];
    for (const file of files) {
      documents.push(await this.loadDocument(file));
    }
    const endLoadDocs = new Date();

    this.logMessage(
      `Loaded ${documents.length} documents in ${
        endLoadDocs.getTime() - startLoadDocs.getTime()
      } milliseconds`,
    );

    const startValidation = new Date();
    await Promise.all(
      documents.map(async (document) => await this.validateDocument(document)),
    );
    const endValidation = new Date();

    this.logMessage(
      `Ran ${this.enabledRules.length} validations in ${
        endValidation.getTime() - startValidation.getTime()
      } milliseconds`,
    );

    return documents;
  }

  public async loadDocument(filePath: string): Promise<Document> {
    const fileExtension = extname(filePath);
    if (fileExtension.toLowerCase() === '.md') {
      return MarkdownDocument.LoadAsync(filePath);
    }
    return Document.LoadAsync(filePath);
  }

  public async loadDocumentFromTextDocument(
    textDocument: TextDocument,
  ): Promise<Document> {
    const fileExtension = extname(textDocument.uri);
    if (fileExtension.toLowerCase() === '.md') {
      return MarkdownDocument.LoadAsync(textDocument);
    }
    return Document.LoadAsync(textDocument);
  }

  public async validateDocument(document: Document): Promise<void> {
    const problems = await Promise.all(
      this.enabledRules.map(async (rule) => await rule.validate(document)),
    );

    document.docProblems = problems.flat();
  }
}

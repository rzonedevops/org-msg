// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { open } from 'fs/promises';
import Problem from '../rules/problem';
import { TextDocument } from 'vscode-languageserver-textdocument';

export type DocumentConstructor<T = object> = new (
  filePath: string | TextDocument,
) => T;

export default class Document {
  public filePath = '';
  public content = '';
  public contentLines: string[] = [];
  public docProblems: Problem[] = [];

  constructor(file: string | TextDocument) {
    if (typeof file === 'string') {
      this.filePath = file;
    } else {
      this.filePath = file.uri;
    }
  }

  static async LoadAsync<T extends Document>(
    this: DocumentConstructor<T>,
    file: string | TextDocument,
  ): Promise<T> {
    const instance = new this(file);

    if (typeof file === 'string') {
      const file = await open(instance.filePath, 'r');
      instance.content = await file.readFile('utf-8');
      await file.close();
    } else {
      instance.content = file.getText();
    }

    instance.contentLines = instance.content.split(/\r?\n/);

    return instance;
  }
}

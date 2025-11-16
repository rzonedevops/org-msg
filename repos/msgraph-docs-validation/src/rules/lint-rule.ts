// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import Problem from './problem';
import Document from '../documents/document';

export default interface LintRule {
  id: string;
  alias: string;
  fileTypes: string[];
  validate: (document: Document) => Promise<Problem[]>;
}

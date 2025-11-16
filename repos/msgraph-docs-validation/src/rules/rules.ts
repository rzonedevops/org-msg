// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import LintRule from './lint-rule';
import MGD001 from './MGD001';
import MGD002 from './MGD002';
import MGD003 from './MGD003';
import MGD004 from './MGD004';
import MGD005 from './MGD005';
import MGD006 from './MGD006';
import MGD007 from './MGD007';
import MGD008 from './MGD008';
import MGD009 from './MGD009';
import MGD010 from './MGD010';

const rules: LintRule[] = [
  new MGD001(),
  new MGD002(),
  new MGD003(),
  new MGD004(),
  new MGD005(),
  new MGD006(),
  new MGD007(),
  new MGD008(),
  new MGD009(),
  new MGD010(),
];

export default rules;

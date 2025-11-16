// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

export function isEmpty(value?: string): boolean {
  return !value || value.trim().length <= 0;
}

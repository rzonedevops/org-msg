// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

export type RegExpExecArrayWithIndices = RegExpExecArray & {
  indices: Array<[number, number]>;
};

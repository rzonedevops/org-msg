// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

type Problem = {
  id: string;
  description: string;
  location?: {
    line: number;
    column: number;
    length: number;
  };
};

export default Problem;

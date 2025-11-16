// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * Alias: `methods-in-order`
 * Applies to: Markdown resource topics (doc_type: resourcePageType)
 *
 * Methods tables list CRUD operations in proper order
 * List, Create, Get, Update, Delete
 */

import LintRule from './lint-rule';
import Problem from './problem';
import Document from '../documents/document';
import MarkdownDocument, { TopicType } from '../documents/markdown-document';
import MarkdownTable from '../documents/markdown/markdown-table';
import * as pluralize from 'pluralize';

enum MethodIndex {
  List,
  Create,
  Get,
  Update,
  Delete,
  FirstNonCrud,
}

const methodNameRegex = /^\[([^\]]+)\]/;

export default class MGD004 implements LintRule {
  id = 'MGD004';
  alias = 'methods-in-order';
  fileTypes = ['.md'];

  public async validate(document: Document) {
    const problems: Problem[] = [];

    if (document instanceof MarkdownDocument) {
      const markdown = document as MarkdownDocument;
      if (
        markdown.topicType === TopicType.Resource &&
        markdown.resourceElements &&
        markdown.resourceElements.methodTableIndex &&
        markdown.docParts[markdown.resourceElements.methodTableIndex].type ===
          MarkdownTable.name
      ) {
        const methodsTable = markdown.docParts[
          markdown.resourceElements.methodTableIndex
        ] as MarkdownTable;
        const resourceName =
          markdown.resourceElements.resourceName?.toLowerCase();

        // Items in required order may be absent
        // Also, some may include resource name ("Get user"),
        // some may not ("Delete")
        const methodIndexes = [-1, -1, -1, -1, -1, -1];
        methodsTable.rows.forEach((row, index) => {
          const methodName = this.getMethodName(row[0])?.trim().toLowerCase();
          if (
            methodName === 'list' ||
            (resourceName &&
              methodName === `list ${pluralize.plural(resourceName)}`)
          ) {
            methodIndexes[MethodIndex.List] = index;
          } else if (
            methodName === 'create' ||
            (resourceName && methodName === `create ${resourceName}`)
          ) {
            methodIndexes[MethodIndex.Create] = index;
          } else if (
            methodName === 'get' ||
            (resourceName && methodName === `get ${resourceName}`)
          ) {
            methodIndexes[MethodIndex.Get] = index;
          } else if (
            methodName === 'update' ||
            (resourceName && methodName === `update ${resourceName}`)
          ) {
            methodIndexes[MethodIndex.Update] = index;
          } else if (
            methodName === 'delete' ||
            (resourceName && methodName === `delete ${resourceName}`)
          ) {
            methodIndexes[MethodIndex.Delete] = index;
          } else if (methodIndexes[MethodIndex.FirstNonCrud] < 0) {
            methodIndexes[MethodIndex.FirstNonCrud] = index;
          }
        });

        methodIndexes.forEach((methodIndex, index) => {
          for (let i = index; i < methodIndexes.length; i++) {
            if (methodIndexes[i] >= 0 && methodIndex > methodIndexes[i]) {
              // PROBLEM
              const methodName =
                this.getMethodName(methodsTable.rows[methodIndex][0]) || '';
              problems.push({
                id: this.id,
                description: `Methods table row "${methodName}" is not in the required order for CRUD operations`,
                location: {
                  line: methodsTable.lineNumber + 2 + methodIndex,
                  column: 0,
                  length:
                    markdown.contentLines[
                      methodsTable.lineNumber + 1 + methodIndex
                    ].length,
                },
              });
              return;
            }
          }

          // If a required item is below a non-required, that's
          // an invalid placement of this item
          // if (
          //   indexOfFirstNonRequired >= 0 &&
          //   methodIndex > indexOfFirstNonRequired
          // ) {
          //   const methodName =
          //     this.getMethodName(methodsTable.rows[methodIndex][0]) || '';
          //   problems.push({
          //     id: this.id,
          //     description: `Methods table row "${methodName}" is not in the required order for CRUD operations`,
          //     location: {
          //       line: methodsTable.lineNumber + 2 + methodIndex,
          //       column: 0,
          //       length:
          //         markdown.contentLines[
          //           methodsTable.lineNumber + 1 + methodIndex
          //         ].length,
          //     },
          //   });
          // } else if (
          //   lastIndex >= 0 &&
          //   methodIndex >= 0 &&
          //   methodIndex < methodIndexes[lastIndex]
          // ) {
          //   const methodName =
          //     this.getMethodName(
          //       methodsTable.rows[methodIndexes[lastIndex]][0]
          //     ) || '';
          //   problems.push({
          //     id: this.id,
          //     description: `Methods table row "${methodName}" is not in the required order for CRUD operations`,
          //     location: {
          //       line: methodsTable.lineNumber + 2 + methodIndexes[lastIndex],
          //       column: 0,
          //       length:
          //         markdown.contentLines[
          //           methodsTable.lineNumber + 1 + methodIndexes[lastIndex]
          //         ].length,
          //     },
          //   });
          // }
          // lastIndex = methodIndex >= 0 ? index : lastIndex;
        });
      }
    }

    return problems;
  }

  private getMethodName(cellContents: string): string | undefined {
    const match = methodNameRegex.exec(cellContents);
    if (match && match[1]) {
      return match[1];
    }
  }
}

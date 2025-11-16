// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import { describe, expect, test } from '@jest/globals';
import MarkdownHtmlComment from '../../../src/documents/markdown/markdown-html-comment';
import * as markdown from './markdown-data';

describe('MarkdownHtmlComment', () => {
  test('parses code metadata properly', () => {
    const comment = MarkdownHtmlComment.parse(markdown.metadataLines, 0);
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(markdown.metadataLines.length);
    expect(comment?.trailingText).toBeUndefined();
    expect(comment).toHaveProperty('metadata');
    expect(comment?.metadata).toBeDefined();
    expect(comment).toHaveProperty('metadata.blockType', 'resource');
    expect(comment).toHaveProperty('metadata.keyProperty', 'id');
    expect(comment).toHaveProperty(
      ['metadata', '@odata.type'],
      'microsoft.graph.accessPackage',
    );
    expect(comment).toHaveProperty('metadata.openType', false);
    expect(comment).not.toHaveProperty('metadata.name');
    expect(comment).not.toHaveProperty('metadata.truncated');
    expect(comment).not.toHaveProperty('metadata.sampleKeys');
  });

  test('handles opening brace on second line', () => {
    const comment = MarkdownHtmlComment.parse(
      markdown.metadataLinesWithOpenBraceOnSecondLine,
      0,
    );
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(
      markdown.metadataLinesWithOpenBraceOnSecondLine.length,
    );
    expect(comment?.trailingText).toBeUndefined();
    expect(comment).toHaveProperty('metadata');
    expect(comment?.metadata).toBeDefined();
    expect(comment).toHaveProperty('metadata.blockType', 'response');
    expect(comment).toHaveProperty('metadata.truncated', true);
    expect(comment).toHaveProperty(
      ['metadata', '@odata.type'],
      'Collection(microsoft.graph.accessPackageAssignment)',
    );
    expect(comment).not.toHaveProperty('metadata.openType');
    expect(comment).not.toHaveProperty('metadata.name');
    expect(comment).not.toHaveProperty('metadata.keyProperty');
    expect(comment).not.toHaveProperty('metadata.sampleKeys');
  });

  test('handles closing brace on same line with comment close', () => {
    const comment = MarkdownHtmlComment.parse(
      markdown.metadataLinesWithClosingBraceOnSameLine,
      0,
    );
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(
      markdown.metadataLinesWithClosingBraceOnSameLine.length,
    );
    expect(comment?.trailingText).toBeUndefined();
    expect(comment).toHaveProperty('metadata');
    expect(comment?.metadata).toBeDefined();
    expect(comment).toHaveProperty('metadata.blockType', 'request');
    expect(comment).toHaveProperty('metadata.name', 'update_access_package');
    expect(comment).not.toHaveProperty('metadata.truncated');
    expect(comment).not.toHaveProperty(['metadata', '@odata.type']);
    expect(comment).not.toHaveProperty('metadata.truncated');
    expect(comment).not.toHaveProperty('metadata.openType');
    expect(comment).not.toHaveProperty('metadata.keyProperty');
    expect(comment).not.toHaveProperty('metadata.sampleKeys');
  });

  test('parses non-metadata comments correctly', () => {
    const comment = MarkdownHtmlComment.parse(
      markdown.nonMetadataHtmlComment,
      0,
    );
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(markdown.nonMetadataHtmlComment.length);
    expect(comment?.trailingText).toBeUndefined();
    expect(comment?.metadata).toBeUndefined();
  });

  test('parses unclosed comments correctly', () => {
    const comment = MarkdownHtmlComment.parse(markdown.unclosedHtmlComment, 0);
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(markdown.unclosedHtmlComment.length);
    expect(comment?.trailingText).toBeUndefined();
    expect(comment?.metadata).toBeUndefined();
  });

  test('parses single-line metadata correctly', () => {
    const comment = MarkdownHtmlComment.parse(markdown.singleLineMetadata, 0);
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(markdown.singleLineMetadata.length);
    expect(comment?.trailingText).toBeUndefined();
    expect(comment?.metadata).toBeDefined();
    expect(comment).toHaveProperty('metadata.blockType', 'request');
    expect(comment).toHaveProperty('metadata.name', 'update_access_package');
  });

  test('parses single-line metadata with trailing character correctly', () => {
    const comment = MarkdownHtmlComment.parse(
      markdown.singleLineMetadataWithExtraCharacters,
      0,
    );
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(
      markdown.singleLineMetadataWithExtraCharacters.length,
    );
    expect(comment).toHaveProperty('trailingText', 's');
    expect(comment?.metadata).toBeDefined();
    expect(comment).toHaveProperty('metadata.blockType', 'request');
    expect(comment).toHaveProperty('metadata.name', 'update_access_package');
  });

  test('parses comment with extra characters correctly', () => {
    const comment = MarkdownHtmlComment.parse(
      markdown.commentWithExtraCharacters,
      0,
    );
    expect(comment).toBeDefined();
    expect(comment).toHaveProperty('type', MarkdownHtmlComment.name);
    expect(comment).toHaveProperty('lineNumber', 1);
    expect(comment).toHaveProperty('lines');
    expect(comment?.lines).toHaveLength(
      markdown.commentWithExtraCharacters.length,
    );
    expect(comment).toHaveProperty('trailingText', 's');
    expect(comment?.metadata).toBeUndefined();
  });

  test('parses comments with empty lines correctly', () => {
    const comment = MarkdownHtmlComment.parse(
      markdown.commentWithEmptyLines,
      0,
    );
    expect(comment?.lines).toHaveLength(markdown.commentWithEmptyLines.length);

    const unclosedComment = MarkdownHtmlComment.parse(
      markdown.unclosedCommentsWithEmptyLines,
      0,
    );
    expect(unclosedComment?.lines).toHaveLength(
      markdown.unclosedCommentsWithEmptyLines.length,
    );
  });

  test('does not parse non-metadata lines', () => {
    expect(
      MarkdownHtmlComment.parse(markdown.codeblockLines, 0),
    ).toBeUndefined();
    expect(MarkdownHtmlComment.parse(markdown.headingLines, 0)).toBeUndefined();
    expect(MarkdownHtmlComment.parse(markdown.includeLines, 0)).toBeUndefined();
    expect(
      MarkdownHtmlComment.parse(markdown.namespaceLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownHtmlComment.parse(markdown.plainTextLines, 0),
    ).toBeUndefined();
    expect(
      MarkdownHtmlComment.parse(markdown.tabbedSectionLines, 0),
    ).toBeUndefined();
    expect(MarkdownHtmlComment.parse(markdown.tableLines, 0)).toBeUndefined();
  });
});

// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// Comments
export const singleLineMetadata = [
  '<!-- { "blockType": "request", "name": "update_access_package" } -->',
];

export const singleLineMetadataWithExtraCharacters = [
  '<!-- { "blockType": "request", "name": "update_access_package" } -->s',
];

export const metadataLines = [
  '<!-- {',
  '  "blockType": "resource",',
  '  "keyProperty": "id",',
  '  "@odata.type": "microsoft.graph.accessPackage",',
  '  "openType": false',
  '}',
  '-->',
];

export const metadataLinesWithOpenBraceOnSecondLine = [
  '<!--',
  '{',
  '  "blockType": "response",',
  '  "truncated": true,',
  '  "@odata.type": "Collection(microsoft.graph.accessPackageAssignment)"',
  '}',
  '-->',
];

export const metadataLinesWithClosingBraceOnSameLine = [
  '<!-- {',
  '  "blockType": "request",',
  '  "name": "update_access_package"',
  '} -->',
];

export const nonMetadataHtmlComment = [
  '<!--',
  '  "blockType": "request",',
  '  "name": "update_access_package"',
  '-->',
];

export const unclosedHtmlComment = [
  '<!--',
  'Future: add links to articles that use federated identity credentials to access Azure AD resources.',
  '>',
  'Hello world',
];

export const commentWithExtraCharacters = [
  '<!-- {',
  '  "type": "#page.annotation",',
  '  "description": "onlineMeetingInfo resource",',
  '  "keywords": "",',
  '  "section": "documentation",',
  '  "tocPath": ""',
  '}-->s',
];

// Code block
export const codeblockLines = [
  '``` json',
  '{',
  '  "@odata.type": "#microsoft.graph.accessPackage",',
  '  "createdDateTime": "String (timestamp)",',
  '  "description": "String",',
  '  "displayName": "String",',
  '  "id": "String (identifier)",',
  '  "isHidden": "Boolean",',
  '  "modifiedDateTime": "String (timestamp)"',
  '}',
  '```',
];

export const codeblockLinesWithoutLanguage = [
  '```',
  '{',
  '  "@odata.type": "#microsoft.graph.accessPackage",',
  '  "createdDateTime": "String (timestamp)",',
  '  "description": "String",',
  '  "displayName": "String",',
  '  "id": "String (identifier)",',
  '  "isHidden": "Boolean",',
  '  "modifiedDateTime": "String (timestamp)"',
  '}',
  '```',
];

export const commentWithEmptyLines = [
  '<!--',
  'Here is some text',
  '',
  '',
  'and here is more',
  '',
];

export const unclosedCommentsWithEmptyLines = [
  '<!--',
  '{',
  '  "type": "#page.annotation",',
  '  "description": "message resource",',
  '  "keywords": "",',
  '  "section": "documentation",',
  '  "tocPath": ""',
  '}',
  '',
  '',
  '',
  '',
];

// Heading
export const headingLines = ['## Properties', '', 'These are the properties'];

export const headingLinesWithLeadingWhitespace = [
  ' #  secureScoreControlStateUpdate resource type',
  'Contains the history of the control states updated by the user (control states include Default, Ignored, ThirdParty, Reviewed).',
];

// Include
export const includeLines = [
  '[!INCLUDE [beta-disclaimer](../../includes/beta-disclaimer.md)]',
  '',
  'Some text',
];

export const includeLinesWithoutLabel = [
  '[!INCLUDE [](../../includes/beta-disclaimer.md)]',
  '',
  'Some text',
];

// Namespace
export const namespaceLines = ['Namespace: microsoft.graph', '', 'Some text'];

export const namespaceLinesWithLongerName = [
  'Namespace: microsoft.graph.lorem.ipsum',
  '',
  'Some text',
];

// Tabbed section
export const tabbedSectionLines = [
  '# [HTTP](#tab/http)',
  '<!-- {',
  '  "blockType": "request",',
  '  "name": "accesspackageassignment_additionalaccess"',
  '}',
  '-->',
  '```http',
  'GET https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/assignments/additionalAccess',
  '```',
  '',
  '# [C#](#tab/csharp)',
  '[!INCLUDE [sample-code](../includes/snippets/csharp/accesspackageassignment-additionalaccess-csharp-snippets.md)]',
  '[!INCLUDE [sdk-documentation](../includes/snippets/snippets-sdk-documentation-link.md)]',
  '',
  '# [JavaScript](#tab/javascript)',
  '[!INCLUDE [sample-code](../includes/snippets/javascript/accesspackageassignment-additionalaccess-javascript-snippets.md)]',
  '[!INCLUDE [sdk-documentation](../includes/snippets/snippets-sdk-documentation-link.md)]',
  '',
  '# [Java](#tab/java)',
  '[!INCLUDE [sample-code](../includes/snippets/java/accesspackageassignment-additionalaccess-java-snippets.md)]',
  '[!INCLUDE [sdk-documentation](../includes/snippets/snippets-sdk-documentation-link.md)]',
  '',
  '# [Go](#tab/go)',
  '[!INCLUDE [sample-code](../includes/snippets/go/accesspackageassignment-additionalaccess-go-snippets.md)]',
  '[!INCLUDE [sdk-documentation](../includes/snippets/snippets-sdk-documentation-link.md)]',
  '',
  '# [PowerShell](#tab/powershell)',
  '[!INCLUDE [sample-code](../includes/snippets/powershell/accesspackageassignment-additionalaccess-powershell-snippets.md)]',
  '[!INCLUDE [sdk-documentation](../includes/snippets/snippets-sdk-documentation-link.md)]',
  '',
  '# [PHP](#tab/php)',
  '[!INCLUDE [sample-code](../includes/snippets/php/accesspackageassignment-additionalaccess-php-snippets.md)]',
  '[!INCLUDE [sdk-documentation](../includes/snippets/snippets-sdk-documentation-link.md)]',
  '',
  '---',
];

// Table
export const tableLines = [
  '|Name|Description|',
  '|:---|:---|',
  '|Authorization|Bearer {token}. Required.|',
];

export const paddedTableLines = [
  '| Name | Description |',
  '| :--- | :--- |',
  '| Authorization | Bearer {token}. Required. |',
];

// Plain text
export const plainTextLines = [
  'Hello world',
  'Lorem ipsum',
  '',
  'This is # Not a heading',
];

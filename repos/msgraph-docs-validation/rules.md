# Implemented validation rules

## MGD001

Alias: `yaml-header-present`
Applies to: Markdown

All topics must have a valid YAML header at the top of the file that contains at least these properties:

```yaml
---
title: Title
description: Description
author: Author
doc_type: Doc-Type
---
```

## MGD002

Alias: `beta-disclaimer`
Applies to: Markdown

- Topics in the **api-reference/beta** folder MUST contain exactly one instance of the beta disclaimer INCLUDE file.
- Topics in the **api-reference/v1.0** folder MUST NOT contain any instances of the beta disclaimer INCLUDE file.
- Topics anywhere else MUST NOT contain more than one instance of the beta disclaimer INCLUDE file.

## MGD003

Alias: `properties-alphabetical`
Applies to: Markdown resource topics (doc_type: resourcePageType)

Properties are listed in alphabetical order in tables and JSON representations.

## MGD004

Alias: `methods-in-order`
Applies to: Markdown resource topics (doc_type: resourcePageType)

Methods tables list CRUD operations in proper order:
List, Create, Get, Update, Delete

## MGD005

Alias: `correct-version-in-url`
Applies to: Markdown

- Examples in topics in the **api-reference/beta** folder MUST use the beta endpoint.
- Examples in topics in the **api-reference/v1.0** folder MUST use the v1.0 endpoint.

## MGD006

Alias: `relative-url-http-request`
Applies to: Markdown API topics (doc_type: apipagetype)

URLs in the **HTTP request** section must be relative and not include version.

Correct: `GET /users`
Incorrect: `GET /v1.0/users` or `GET https://graph.microsoft.com/v1.0/users`

## MGD007

Alias: `snippet-tabs-alphabetical`
Applies to: Markdown API topics (doc_type: apipagetype)

Code snippet tabs must have the HTTP tab first, and the rest must be in alphabetical order.

## MGD008

Alias: `language-tabs-correct`
Applies to: Markdown

Tab anchors for programming languages use the correct casing and anchor value.

- C#: #tab/csharp
- CLI: #tab/cli
- Go: #tab/go
- Java: #tab/java
- JavaScript: #tab/javascript
- PHP: #tab/php
- PowerShell: #tab/powershell
- Python: #tab/python

## MGD009

Alias: `tabs-consistent`
Applies to: Markdown

If multiple tabbed sections exist in a document, they must all contain the same tabs in the same order.

## MGD010

Alias: `no-onmicrosoft-domains`
Applies to: Markdown

No occurrences of `onmicrosoft.com` appear in email addresses or URLs. See [https://aka.ms/fictitious](https://aka.ms/fictitious) for guidance on acceptable domains.

// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import * as YAML from 'yaml';
import { TextDocument } from 'vscode-languageserver-textdocument';
import Document, { DocumentConstructor } from './document';
import MarkdownHeading from './markdown/markdown-heading';
import MarkdownTable from './markdown/markdown-table';
import MarkdownPart, {
  createPartCollectionFromLines,
} from './markdown/markdown-part';
import MarkdownCodeBlock from './markdown/markdown-codeblock';

const resourceTitleRegex = /(\S+)\s+resource\s+type/;

export enum TopicType {
  Api,
  Concept,
  Resource,
  Unknown,
}

export type YamlHeader = {
  title?: string;
  description?: string;
  author?: string;
  doc_type?: string;
};

export type DocSection = {
  title: string;
  startIndex: number;
  endIndex: number;
};

export type ResourceElements = {
  resourceName?: string;
  methodTableIndex?: number;
  propertiesTableIndex?: number;
  relationShipsTableIndex?: number;
  jsonRepresentationIndex?: number;
};

export default class MarkdownDocument extends Document {
  public topicType: TopicType = TopicType.Unknown;
  public yamlHeader?: YamlHeader;
  public docParts: MarkdownPart[] = [];
  public docSections: DocSection[] = [];
  public resourceElements?: ResourceElements;

  constructor(file: string | TextDocument) {
    super(file);
  }

  static async LoadAsync<T extends Document>(
    this: DocumentConstructor<T>,
    file: string | TextDocument,
  ): Promise<T> {
    const instance = await super.LoadAsync(file);
    const markdownDoc = instance as MarkdownDocument;

    const markdownStartIndex = markdownDoc.ParseYamlHeader();
    markdownDoc.ParseMarkdownContent(markdownStartIndex);

    return instance as T;
  }

  private ParseYamlHeader(): number {
    // The first line should be the opening marker for
    // YAML front-matter: ---
    if (this.contentLines[0].trimEnd() === '---') {
      // Find the closing marker (also ---)
      const endFrontMatterIndex = this.contentLines.findIndex(
        (value, index) => index > 0 && value.trimEnd() === '---',
      );

      if (endFrontMatterIndex > 0) {
        // Extract YAML from between markers
        const yamlLines = this.contentLines.slice(1, endFrontMatterIndex);
        const yamlString = yamlLines.join('\n');
        try {
          this.yamlHeader = YAML.parse(yamlString) as YamlHeader;
        } catch (err) {
          // Invalid YAML header
        }

        switch (this.yamlHeader?.doc_type?.toLowerCase()) {
          case 'apipagetype':
            this.topicType = TopicType.Api;
            break;
          case 'conceptualpagetype':
            this.topicType = TopicType.Concept;
            break;
          case 'resourcepagetype':
            this.topicType = TopicType.Resource;
            break;
          default:
            this.topicType = TopicType.Unknown;
        }

        return endFrontMatterIndex + 1;
      }
    }

    return 0;
  }

  private ParseMarkdownContent(startIndex: number) {
    this.docParts = createPartCollectionFromLines(
      this.contentLines,
      startIndex,
      this.contentLines.length - 1,
    );

    let currentSection: DocSection = {
      title: '',
      startIndex: -1,
      endIndex: -1,
    };

    this.docParts.forEach((part, index) => {
      if (part.type === MarkdownHeading.name) {
        const heading = part as MarkdownHeading;
        // Entered a new section, save current
        if (currentSection.startIndex >= 0) {
          currentSection.endIndex = index - 1;
          this.docSections.push(currentSection);
          currentSection = {
            title: heading.title,
            startIndex: index,
            endIndex: -1,
          };
        } else {
          currentSection.title = heading.title;
          currentSection.startIndex = index;
        }
      }

      if (index === this.docParts.length - 1) {
        // Last element, save current section
        currentSection.endIndex = index;
        this.docSections.push(currentSection);
      }
    });

    switch (this.topicType) {
      case TopicType.Api:
        break;
      case TopicType.Concept:
        break;
      case TopicType.Resource:
        this.resourceElements = this.parseResourceTopicElements();
        break;
    }
  }

  private parseResourceTopicElements(): ResourceElements {
    // Locate important elements in resource topics
    const resourceElements: ResourceElements = {};

    // Resource name
    const docTitle = this.docParts.find((part) => {
      if (part.type === MarkdownHeading.name) {
        const heading = part as MarkdownHeading;
        return heading.level === 1;
      }
      return false;
    }) as MarkdownHeading;

    const match = resourceTitleRegex.exec(docTitle.title);
    if (match && match[1]) {
      resourceElements.resourceName = match[1];
    }

    // Methods table
    const methodSection = this.docSections.find(
      (section) => section.title.toLowerCase() === 'methods',
    );
    if (methodSection) {
      for (
        let i = methodSection.startIndex + 1;
        i <= methodSection.endIndex;
        i++
      ) {
        if (this.docParts[i].type === MarkdownTable.name) {
          // Check headings to verify
          const table = this.docParts[i] as MarkdownTable;
          if (table.headers[0].toLowerCase() === 'method') {
            resourceElements.methodTableIndex = i;
            // Note: only the first table with "Method" as
            // the first heading will be considered
            break;
          }
        }
      }
    }

    // Properties table
    const propsSection = this.docSections.find(
      (section) => section.title.toLowerCase() === 'properties',
    );
    if (propsSection) {
      for (
        let i = propsSection.startIndex + 1;
        i <= propsSection.endIndex;
        i++
      ) {
        if (this.docParts[i].type === MarkdownTable.name) {
          // Check headings to verify
          const table = this.docParts[i] as MarkdownTable;
          if (table.headers[0].toLowerCase() === 'property') {
            resourceElements.propertiesTableIndex = i;
            // Note: only the first table with "Property" as
            // the first heading will be considered
            break;
          }
        }
      }
    }

    // Relationships table
    const relationshipsSection = this.docSections.find(
      (section) => section.title.toLowerCase() === 'relationships',
    );
    if (relationshipsSection) {
      for (
        let i = relationshipsSection.startIndex + 1;
        i <= relationshipsSection.endIndex;
        i++
      ) {
        if (this.docParts[i].type === MarkdownTable.name) {
          // Check headings to verify
          const table = this.docParts[i] as MarkdownTable;
          if (table.headers[0].toLowerCase() === 'relationship') {
            resourceElements.relationShipsTableIndex = i;
            // Note: only the first table with "Relationship" as
            // the first heading will be considered
            break;
          }
        }
      }
    }

    // JSON representation
    const jsonSection = this.docSections.find(
      (section) => section.title.toLowerCase() === 'json representation',
    );
    if (jsonSection) {
      for (let i = jsonSection.startIndex + 1; i <= jsonSection.endIndex; i++) {
        if (this.docParts[i].type === MarkdownCodeBlock.name) {
          // Check headings to verify
          const codeBlock = this.docParts[i] as MarkdownCodeBlock;
          if (codeBlock.language?.toLowerCase() === 'json') {
            resourceElements.jsonRepresentationIndex = i;
            // Note: only the first codeblock with language "json"
            // will be considered
            break;
          }
        }
      }
    }

    return resourceElements;
  }
}

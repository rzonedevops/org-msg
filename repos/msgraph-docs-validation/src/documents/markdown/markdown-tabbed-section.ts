// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import MarkdownPart, { createPartCollectionFromLines } from './markdown-part';

const tabbedSectionStartRegEx = /^#+\s+\[([^[\]]*)\]\(#([^()]*)\)/;

export type TabbedSection = {
  title: string;
  anchor: string;
  lineNumber: number;
};

export default class MarkdownTabbedSection {
  public type: string = MarkdownTabbedSection.name;
  public sections: TabbedSection[] = [];
  //public sectionTitles: string[] = [];
  public docParts: MarkdownPart[] = [];
  public lineNumber = -1;
  public totalLineCount = -1;

  public static parse(
    lines: string[],
    index: number,
  ): MarkdownTabbedSection | undefined {
    let currentLine = lines[index].trimEnd();
    const tabbedSectionMatch = tabbedSectionStartRegEx.exec(currentLine);
    if (tabbedSectionMatch) {
      // Process tabbed section
      const tabbedSection: MarkdownTabbedSection = {
        type: MarkdownTabbedSection.name,
        lineNumber: index + 1,
        sections: [
          {
            title: tabbedSectionMatch[1],
            anchor: tabbedSectionMatch[2],
            lineNumber: index + 1,
          },
        ],
        //sectionTitles: [tabbedSectionMatch[1]],
        docParts: [],
        totalLineCount: 0,
      };

      // Continue processing until we find an end marker (---)
      index++;
      tabbedSection.totalLineCount++;

      // Keep track of where each section starts
      //const sectionLines: number[] = [index];

      currentLine = lines[index].trimEnd();
      while (currentLine !== undefined && !currentLine.startsWith('---')) {
        const subSectionMatch = tabbedSectionStartRegEx.exec(currentLine);

        if (subSectionMatch) {
          tabbedSection.sections.push({
            title: subSectionMatch[1],
            anchor: subSectionMatch[2],
            lineNumber: index + 1,
          });
          //tabbedSection.sectionTitles.push(subSectionMatch[1]);
          //sectionLines.push(index + 1);
        }

        index++;
        tabbedSection.totalLineCount++;
        currentLine = lines[index]?.trimEnd();
      }

      // Account for the closing '---' line
      tabbedSection.totalLineCount++;

      // Parse contained doc parts
      tabbedSection.sections.forEach(
        (section: TabbedSection, arrayIndex: number) => {
          const endIndex =
            arrayIndex < tabbedSection.sections.length - 1
              ? tabbedSection.sections[arrayIndex + 1].lineNumber - 2
              : index;
          const currentSectionParts = createPartCollectionFromLines(
            lines,
            section.lineNumber,
            endIndex,
          );
          tabbedSection.docParts.push(...currentSectionParts);
        },
      );

      return tabbedSection;
    }
  }
}

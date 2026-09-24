# Summarize To Feishu

Use this module when the user provides source material and wants a concise, structured Feishu knowledge document.

## Intent

- Extract core conclusions
- Preserve source meaning
- Organize content into a readable knowledge-note structure

## Suggested Structure

- Title
- Core takeaway
- Key concepts
- Important details
- Example or scenario
- Pitfalls or notes
- Short summary

## Rules

- Base the summary on the provided source.
- Clearly separate supplemental explanation from source-derived points.
- Use native `sheet` if the summary naturally contains maintained tables or comparisons.

## Must Also Read If

- The destination is an existing Feishu doc:
  - `existing-doc-safe-edit.md`
- The source is a PDF:
  - `pdf-to-feishu.md`
- The source is a Word/docx file:
  - `word-to-feishu.md`
- The source is Markdown or TXT:
  - `markdown-to-feishu.md`
- The result contains maintained tables, comparisons, or checklists:
  - `sheet-table-handling.md`

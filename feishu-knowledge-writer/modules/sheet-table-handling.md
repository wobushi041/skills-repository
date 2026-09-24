# Sheet Table Handling

Use this module when the task involves tables, comparisons, checklists, or sheet-backed content.

## Intent

- Prefer Feishu native `sheet` over Markdown tables for maintained content
- Protect existing table data during formatting or migration

## Rules

- If a Feishu doc contains `<sheet>`, never assume the visible table data is stored in Markdown.
- Read and write table data through sheet-specific APIs.
- Do not convert native sheets to Markdown tables unless the user explicitly asks.

## Pairing

- For existing docs, also read `existing-doc-safe-edit.md`.
- For safety rules, also read `../references/sheet-safety-rules.md`.

## Must Also Read If

- The table content comes from PDF extraction:
  - `pdf-to-feishu.md`
- The table content comes from Word/docx:
  - `word-to-feishu.md`
- The table content comes from Markdown or TXT:
  - `markdown-to-feishu.md`
- The user only wants formatting changes in a sheet-bearing doc:
  - `format-only.md`

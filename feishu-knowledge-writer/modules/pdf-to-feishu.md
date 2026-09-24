# PDF To Feishu

Use this module when the source material is a PDF.

## Intent

- Extract usable text and structure from PDF content
- Decide whether the user wants summary, outline, tutorial, or direct formatting

## Workflow

1. Extract text safely.
2. Identify headings, lists, tables, and code-like content.
3. Route to another content module if needed:
   - `summarize-to-feishu.md`
   - `expand-to-tutorial.md`
   - `outline-generation.md`
   - `ppt-outline-generation.md`

## Rules

- Watch for broken line wraps from PDF extraction.
- If tables are important, prefer native Feishu `sheet`.

## Use With

- For summary output:
  - `summarize-to-feishu.md`
- For tutorial-style expansion:
  - `expand-to-tutorial.md`
- For structured outline output:
  - `outline-generation.md`
- For presentation outline output:
  - `ppt-outline-generation.md`
- For existing Feishu doc write-back:
  - `existing-doc-safe-edit.md`
- For table-heavy or comparison-heavy content:
  - `sheet-table-handling.md`

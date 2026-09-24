# Word To Feishu

Use this module when the source material is Word/docx.

## Intent

- Preserve document structure where reasonable
- Protect tables, lists, and code-like blocks
- Prepare safe content for Feishu write-back

## Rules

- Treat Word tables as candidates for native Feishu `sheet`.
- Be careful with embedded content and pasted formatting noise.
- If the destination is an existing Feishu doc, pair with `existing-doc-safe-edit.md`.

## Use With

- For summary output:
  - `summarize-to-feishu.md`
- For tutorial-style expansion:
  - `expand-to-tutorial.md`
- For structured outline output:
  - `outline-generation.md`
- For presentation outline output:
  - `ppt-outline-generation.md`
- For maintained tables or converted document tables:
  - `sheet-table-handling.md`

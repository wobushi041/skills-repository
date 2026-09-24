# Batch Doc Operations

Use this module when the user wants similar processing applied across multiple documents.

## Intent

- Keep batch work safe, traceable, and consistent
- Avoid repeating risky full-document edits

## Rules

- Scan documents first before editing.
- Separate low-risk docs from docs with embedded blocks.
- Prefer generating a repair or action list before mass write-back.
- Validate results in small batches instead of assuming everything succeeded.

## Default Batch Sequence

1. Inventory target docs.
2. Classify by risk and embed presence.
3. Back up only the docs that need risky operations.
4. Test the workflow on one sample.
5. Apply changes in small batches.
6. Validate each batch before continuing.
7. Record exceptions and incomplete items.
8. Delete temporary cached working files after the batch completes unless the user asked to keep them.

## Good Fits

- Batch formatting
- Batch embed detection
- Batch code-block repair
- Batch sheet-preservation checks

## Must Also Read If

- The batch job is format-only:
  - `format-only.md`
- The batch job writes back to existing Feishu docs:
  - `existing-doc-safe-edit.md`
- The batch job involves native sheets or table migration:
  - `sheet-table-handling.md`
- The batch job starts from PDFs:
  - `pdf-to-feishu.md`
- The batch job starts from Word/docx files:
  - `word-to-feishu.md`
- The batch job starts from Markdown or TXT:
  - `markdown-to-feishu.md`

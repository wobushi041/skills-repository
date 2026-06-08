# Existing Doc Safe Edit

Use this module when updating a real existing Feishu/Lark document.

## Safe Workflow

1. Fetch the target document.
2. Inspect for embedded blocks such as `<sheet>`, `<image>`, `<file>`, and `<whiteboard>`.
3. Back up fetched Markdown locally before writing.
4. Back up native sheets separately if present.
5. Prefer targeted updates such as `replace_range`, `insert_before`, `insert_after`, or append.
6. Read back the document after writing.
7. Verify embedded blocks and affected sheet data still exist.
8. Delete temporary cached backups or exports created only for this task unless the user explicitly asked to keep them.

## Never Do

- Do not full-overwrite a doc that contains embedded blocks.
- Do not rebuild a whole doc from fetched Markdown when native sheet data is involved.
- Do not assume keeping the same `<sheet token="..."/>` string guarantees preserved sheet data.

## Failure / Fallback

- If `replace_range` is a poor fit for multi-paragraph replacement, switch to a safer delete-plus-insert pattern or another targeted method.
- If document fetch succeeds but sheet read fails, stop before write-back on sheet-bearing docs.
- If embedded structures are unclear, prefer a narrower edit scope instead of guessing.
- If a cached backup is needed for recovery during the run, keep it only until verification is complete unless the user asks to retain it.

## Validation Checks

- Embedded block count did not unexpectedly decrease.
- Expected native sheet references still exist.
- Affected sheet ranges are readable and non-empty when applicable.
- No broken code fences were introduced.
- Temporary cached files created for the task were deleted after verification unless the user asked to keep them.

## Must Also Read If

- The user requested format-only changes:
  - `format-only.md`
- The task is summary-driven:
  - `summarize-to-feishu.md`
- The task expands notes into a tutorial:
  - `expand-to-tutorial.md`
- The output is an outline:
  - `outline-generation.md`
- The output is a PPT outline:
  - `ppt-outline-generation.md`
- Native sheets or maintained tables are involved:
  - `sheet-table-handling.md`

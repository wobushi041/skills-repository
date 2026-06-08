---
name: feishu-knowledge-writer
description: Use when creating, summarizing, expanding, formatting, repairing, or safely updating Feishu/Lark knowledge-base documents from PDF, Word/docx, Markdown, TXT, Excel, screenshots, user chat input, or existing Feishu docs. Prefer Feishu native sheet tables and avoid unsafe full-document overwrite when embedded blocks exist.
metadata:
  short-description: Modular Feishu knowledge writer
---

# Feishu Knowledge Writer

Use this skill when the user wants to create, summarize, expand, format, repair, or safely update Feishu/Lark knowledge-base documents.

## Global Rules

- Reply in Simplified Chinese unless the user explicitly requests another language.
- Keep commands, code identifiers, logs, API fields, and tokens in their original language.
- Prefer Feishu native `sheet` for tables that need maintenance, comparison, checklists, field descriptions, or spreadsheet-like structure.
- Before editing an existing Feishu doc, inspect whether it contains `<sheet>`, `<image>`, `<file>`, `<whiteboard>`, or other embedded blocks.
- If embedded blocks exist, do not use full-document Markdown overwrite.
- If the user says `只调格式` or `不改内容`, do not add knowledge, rewrite meaning, unify terminology, or change code logic.
- If temporary cached source files, fetched Markdown, exported sheets, or intermediate conversion files are created for the task, delete them after the task is completed unless the user explicitly asks to keep them.

## Routing Priority

When multiple modules may apply, decide in this order:

1. Destination risk: existing Feishu doc vs new doc
2. Source type: PDF / Word / Markdown / TXT / chat input
3. Output intent: format-only / summary / tutorial / outline / PPT outline
4. Table risk: native `sheet` involved or not

If a request is a mixed scenario, load the highest-risk module first, then the source module, then the intent module.

## Routing

Read only the modules needed for the current task instead of loading everything.

- Format only / no content change
  - Read `modules/format-only.md`
- Summarize source material into a Feishu doc
  - Read `modules/summarize-to-feishu.md`
- Expand material into a tutorial-style Feishu doc
  - Read `modules/expand-to-tutorial.md`
- Generate a structured outline
  - Read `modules/outline-generation.md`
- Generate a PPT outline
  - Read `modules/ppt-outline-generation.md`
- Convert PDF into Feishu content
  - Read `modules/pdf-to-feishu.md`
- Convert Word/docx into Feishu content
  - Read `modules/word-to-feishu.md`
- Convert Markdown/TXT into Feishu content
  - Read `modules/markdown-to-feishu.md`
- Handle tables, sheet migration, or sheet-first formatting
  - Read `modules/sheet-table-handling.md`
- Safely edit an existing Feishu doc
  - Read `modules/existing-doc-safe-edit.md`
- Handle batch document operations
  - Read `modules/batch-doc-operations.md`

If the target doc contains native sheets, also read:

- `references/sheet-safety-rules.md`

If sheet data disappears or embed references become invalid, also read:

- `references/recovery-playbook.md`

If creating a new structured knowledge article, also read:

- `templates/knowledge-doc-template.md`

## Operating Style

- Keep the working set small and load only the relevant module files.
- Prefer targeted updates over document-wide rewrite.
- Separate source-derived content from optional supplemental content.
- Validate after write-back when the task touches a real Feishu document.

## Failure / Fallback

- If a write method is unsafe for the current doc structure, do not force it. Switch to a safer targeted method or stop and report the constraint.
- If source extraction quality is poor, preserve structure conservatively instead of aggressively rewriting content.
- If native sheet access fails, do not overwrite the host document as a workaround.
- If a task is `format-only` but the source document is structurally damaged, prefer partial repair over broad rewriting.
- If cached working files were created during a failed run, clean them up before ending the task unless the user asked to retain them.

## Validation

Before final response, verify what applies:

- The target document still exists and the title is correct.
- Existing embedded blocks still exist.
- Affected native sheets still contain data.
- Code blocks are not broken by escaping or bad backticks.
- If the task was format-only, content meaning was not changed.
- Temporary cached files created for the task were deleted, unless the user explicitly asked to keep them.

## Optional Growth

This skill can grow later with:

- `scripts/` for repeatable helper automation
- `examples/` for common task patterns and safe-handling examples

These folders are optional and are added manually when repeated workflows justify them.

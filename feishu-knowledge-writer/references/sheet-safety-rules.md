# Sheet Safety Rules

Use this reference when a Feishu document contains native `<sheet>` blocks.

## Core Idea

Native Feishu sheets are not Markdown tables. The visible table data lives in spreadsheet storage, not in the Markdown body.

## Hard Rules

- Do not full-overwrite documents that contain native sheets.
- Do not convert native sheets to Markdown tables unless the user explicitly asks.
- Read and write sheet data through sheet-specific APIs.
- Back up sheet data before risky operations.

## Validation

- Re-fetch the doc after edits.
- Confirm sheet references still exist.
- Read affected sheet ranges and confirm they are non-empty.

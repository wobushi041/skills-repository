# Format Only

Use this module when the user wants formatting cleanup without changing meaning.

## Intent

- Adjust headings, spacing, lists, quotes, and code block fences.
- Preserve wording, conclusions, values, and code logic.

## Rules

- Do not add new knowledge.
- Do not rewrite terminology unless the user explicitly asks.
- Do not silently convert native Feishu sheets to Markdown tables.
- If editing an existing Feishu doc, pair this module with `existing-doc-safe-edit.md`.
- Do not rename headings unless the user explicitly asks.
- Do not merge sections unless they are obviously duplicated by formatting damage.
- Do not rewrite prose into a summary style.
- Do not replace examples, values, or code with "cleaner" alternatives unless the formatting itself is broken.
- Do not normalize wording only because another phrasing seems more standard.

## Do Not Use Alone When

- The target is an existing Feishu doc with embedded blocks.
- The document contains tables that should remain native Feishu sheets.
- The source is structurally damaged and may require safe-edit validation after repair.

## Typical Output

- Cleaner heading hierarchy
- Fixed code block fences
- Better paragraph breaks
- Safer list formatting

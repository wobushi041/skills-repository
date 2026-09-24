# Markdown To Feishu

Use this module when the source is Markdown or plain text.

## Intent

- Normalize headings, lists, quotes, and code fences
- Preserve semantic structure while making it Feishu-friendly

## Rules

- Check for broken code fences and bad nesting.
- Do not force Markdown tables when native `sheet` is the better long-term format.
- Route to `sheet-table-handling.md` if table content should be maintained in Feishu.

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

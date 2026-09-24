# Recovery Playbook

Use this reference when native sheet content disappears, becomes empty, or no longer matches the expected embed references.

## Response Goals

- Stop unsafe write-back
- Preserve remaining references
- Recover from backups or prior sheet exports when available

## First Checks

1. Re-fetch the document.
2. Compare current sheet references with the pre-edit state.
3. Read affected sheet ranges directly.
4. Check whether a spreadsheet export or local backup exists.

## Recovery Direction

- Restore sheet-backed data through sheet APIs when possible.
- Avoid another full-document rewrite during recovery.

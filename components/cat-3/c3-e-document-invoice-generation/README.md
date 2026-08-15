# C3-E - Document / Invoice Generation

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Builds deterministic document or invoice render payloads from structured data, including invoice totals.

## Input
`type` (`document|invoice`) plus structured `data`.

## Output
Markdown render payload; invoices also return normalized totals and currency.

## Boundary
Rendering/export to Google Docs/PDF/e-signature is an adapter responsibility.

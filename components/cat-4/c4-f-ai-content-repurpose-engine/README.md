# C4-F - AI Content Repurpose Engine

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Prepares a multi-target repurposing request and validates returned content before human approval.

## Input
`source_content`, `targets[]`, optional second-pass `ai_result`.

## Output
LLM request or normalized per-target outputs with missing-target detection.

## Boundary
All generated external-facing content is approval-first; publishing/sending belongs to other components.

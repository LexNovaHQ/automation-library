# C1-E - Multi-Step Sequence Engine

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Maintains a controlled outreach/follow-up sequence state, chooses the next uncompleted step, enforces stop conditions, and calculates the due time.

## Input
`sequence[]`, current `state`, and optional `now`.

## Output
Sequence status, stop reason where applicable, and a guarded `next_step` with due time.

## Boundary
This engine schedules intent only. Provider sending belongs to attached email/messaging adapters, and suppression/consent should be enforced through C2-P.

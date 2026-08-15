# C3-I - Welcome Sequence

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Creates a deterministic onboarding/welcome communication schedule from client and step configuration.

## Input
`client`, `steps[]`, optional `start_at`.

## Output
Scheduled provider-neutral messages with due times and approval flags.

## Boundary
Actual sending is delegated to Gmail/Outlook/SMTP/other adapters.

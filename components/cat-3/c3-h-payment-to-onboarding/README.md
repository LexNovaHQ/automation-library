# C3-H - Payment to Onboarding

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Gates onboarding from normalized payment status so onboarding only starts after an accepted paid/succeeded/captured state.

## Input
`payment` with id, status, client/customer id, amount and currency.

## Output
Payment verification result and onboarding-start payload.

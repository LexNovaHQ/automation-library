# C3-G - Subscription Billing Engine

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Maintains a provider-neutral subscription state from billing events and decides retry/manual-review actions.

## Input
`subscription` plus a normalized billing `event`.

## Output
Updated subscription state and controlled billing action.

## Boundary
No charge is created here. Provider billing actions require Stripe/Razorpay/etc. adapters.

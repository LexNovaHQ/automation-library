# TPL-P0-005 - AI Email Draft to Approval to Send

**Status:** Implemented as two portable source workflows; local compile/import/end-to-end verification pending.

## Architecture
1. `Request` workflow: C4-E -> C4-M -> C2-O. It generates the email, packages it, and creates an approval request.
2. `Resume` workflow: C2-O2 captures the reviewer decision. Only an `approve` decision is allowed to call the existing ADP-GMAIL-SEND webhook adapter. Reject/revise stops before sending.

This split preserves a real human-in-the-loop boundary instead of pretending approval is synchronous.

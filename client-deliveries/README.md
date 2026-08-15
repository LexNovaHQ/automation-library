# Client Delivery Pack

Reusable client-facing handoff templates for automation jobs. Copy the templates into the project delivery folder, replace placeholders, and deliver only material relevant to that client's scope.

Minimum delivery for a normal workflow build:
1. `01-handoff-overview.md`
2. `02-setup-credentials.md`
3. `03-test-results.md`
4. `04-known-limitations.md`
5. `05-change-log.md`

For a repair/debug job also include `06-repair-report.md`.

Never include passwords, API tokens, OAuth secrets, private keys, or n8n credential IDs that expose client internals.

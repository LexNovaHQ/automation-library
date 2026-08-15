# TPL-P0-004 - Webhook to Normalize to API Sync

**Status:** Implemented source template; local compile/import/end-to-end verification pending.

Normalizes an incoming webhook/business event through C2-C, validates the payload through C2-F, then delegates the actual no-auth REST request to the built ADP-REST webhook adapter. Provider-specific/authenticated long-tail APIs should use a dedicated adapter or client credential path rather than hard-coded auth in this template.

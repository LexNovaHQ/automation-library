# September Full Build Status

Working branch: `sept-launch-full-build`

Rule: implementation and verification are tracked separately. A component is not promoted to `BUILT` in the machine classification until its workflow JSON imports successfully, declared test payloads pass, outputs are captured, and any provider-dependent path is exercised with a sandbox/test credential.

## Scope

This sprint covers every currently classified `NOT_BUILT`, `DEFERRED`, and `DEFERRED_ADAPTER` item, all six P0 templates, Windows development-machine bootstrap, public repo presentation, and reusable client-delivery assets.

## Status vocabulary

- `SCAFFOLD`: existing placeholder only.
- `IMPLEMENTED`: workflow/docs/tests authored; local import/runtime verification pending.
- `LOCAL_VERIFIED`: imports and deterministic tests pass on local n8n.
- `PROVIDER_VERIFIED`: real/sandbox provider credential path exercised where required.
- `BUILT`: machine classification may be promoted after the applicable verification gates pass.

## Security gate

The former hard-coded n8n encryption key has been removed from `docker-compose.yml`. New machines must create a local ignored `.env` from `.env.example` and use a fresh encryption key.

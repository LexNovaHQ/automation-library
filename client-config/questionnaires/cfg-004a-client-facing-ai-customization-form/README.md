# CFG-004A - Client-Facing AI Customization Form

## Status
Built v1.0

## Layer Type
CLIENT_CONFIG_ASSET

## Purpose
Simplified client-facing form for capturing AI voice, tone, output rules, forbidden claims, examples, approval preferences, and risk boundaries.

## File
- `../client-facing-ai-customization-form.md`

## Output
Client answers from CFG-004A should populate:

- `CFG-001.ai_profile.voice`
- `CFG-001.ai_profile.business_context`
- `CFG-001.ai_profile.output_rules`
- `CFG-001.ai_profile.risk_boundaries`
- `CFG-001.ai_profile.examples`

The Assembly Engine or Template Config Generator then maps this master profile into C4-specific `client_ai_profile` structures.

## Version
v1.0

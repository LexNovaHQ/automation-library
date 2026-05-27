# CFG-004 - AI Profile Compatibility Pack

## Status
Built v1.0

## Layer Type
CLIENT_CONFIG_ASSET

## Purpose
Maps the master `CFG-001.ai_profile` into the existing `client_ai_profile` runtime structures expected by C4 AI components.

CFG-004 does not create a separate AI profile system. It integrates and upgrades the existing C4 AI customization model.

## File
- `../ai-profile-compatibility-map.md`
- `../../examples/ai-profile-response.example.json`

## Compatible Components
- C4-A AI Classification Pipeline
- C4-B AI Extraction Parser
- C4-D AI Content Generation Pipeline
- C4-E AI Email Draft Generator
- C4-L Lead Qualification Pipeline
- C4-M AI Draft Approval Pipeline

## Preserved Runtime Keys
- `client_ai_profile`
- `client_profile`
- `audience_profile`
- `voice_profile`
- `offer_profile`
- `classification_rules`
- `extraction_rules`
- `content_rules`
- `email_rules`
- `lead_qualification_rules`
- `risk_boundaries`
- `approval_rules`

## Version
v1.0

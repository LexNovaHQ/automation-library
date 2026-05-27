# Client Config Schemas

## Purpose

This folder contains structured schemas for reusable client configuration.

Client configuration turns hardcoded workflows into reusable templates.

## Current Schemas

### `client-profile-schema.json`

Master client operating profile.

It defines:

- client identity
- business context
- tool stack
- workflow preferences
- approval rules
- communication defaults
- embedded AI profile
- data rules
- deployment context
- assembly preferences for the future ChatGPT Project/GPT Assembly Engine

## How It Is Used

The client profile is consumed by:

- template glue workflows
- reusable core components
- provider adapters
- AI components
- approval/manual review flows
- status/error logging
- future ChatGPT Assembly Engine

The intended future assembly flow is:

```text
client profile + job profile
        ↓
ChatGPT Assembly Engine
        ↓
template selection
        ↓
component selection
        ↓
adapter gap check
        ↓
template config generation
        ↓
n8n/build instructions/client handoff
Relationship to AI Profile

The AI profile is embedded inside the client profile as ai_profile.

The AI profile controls:

tone
style
output rules
forbidden claims
risk boundaries
confidence/manual review thresholds
examples of good/bad outputs

This prevents C4 AI workflows from being generic or hardcoded.

Related Future Assets
CFG-002 Workflow Discovery Questionnaire
CFG-003 Tool Stack Questionnaire
CFG-004 AI Customization Questionnaire
CFG-005 Credential Collection Checklist
CFG-006 Template Config Generator

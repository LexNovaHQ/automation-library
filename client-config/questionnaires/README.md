# Client Config Questionnaires

## Purpose

Questionnaires used to capture client and job requirements before template configuration.

These questionnaires feed:

- Template Config Generator
- future ChatGPT Project/GPT Assembly Engine
- client onboarding
- template selection
- adapter gap scoping
- AI profile compatibility mapping
- credential readiness checks

## Current Questionnaires

### CFG-002 - Workflow Discovery Questionnaire

File:

- `workflow-discovery-questionnaire.md`

Purpose:

- internal master workflow discovery framework
- captures complete job-profile requirements
- includes Assembly Engine notes

### CFG-002A - Client-Facing Workflow Discovery Form

File:

- `client-facing-workflow-discovery-form.md`

Purpose:

- simplified version clients can fill
- avoids internal component/adapter/template terminology
- can be converted into CFG-002 structured job profile

### CFG-003 - Tool Stack Questionnaire

File:

- `tool-stack-questionnaire.md`

Purpose:

- internal master tool stack mapping framework
- captures source/destination systems, tool access, credentials, and adapter gaps
- supports Assembly Engine adapter selection

### CFG-003A - Client-Facing Tool Stack Form

File:

- `client-facing-tool-stack-form.md`

Purpose:

- simplified version clients can fill
- identifies client tools, required integrations, and access constraints
- can be converted into CFG-003 structured tool stack response

### CFG-004 - AI Profile Compatibility Pack

File:

- `ai-profile-compatibility-map.md`

Purpose:

- maps `CFG-001.ai_profile` into existing C4 `client_ai_profile` runtime contracts
- preserves upstream C4 payload compatibility
- prevents schema drift between client config and C4 AI components

### CFG-004A - Client-Facing AI Customization Form

File:

- `client-facing-ai-customization-form.md`

Purpose:

- simplified version clients can fill
- captures voice, tone, output rules, forbidden claims, risk boundaries, and examples
- populates `CFG-001.ai_profile`

### CFG-005 - Credential Collection Checklist

File:

- `credential-collection-checklist.md`

Purpose:

- internal credential and access-readiness checklist
- captures tool access, OAuth/API keys, permissions, test data, security limits, and implementation blockers

### CFG-005A - Client-Facing Credential Checklist

File:

- `client-facing-credential-checklist.md`

Purpose:

- simplified version clients can fill
- identifies access availability and restrictions before implementation

## Future Questionnaires

- CFG-006 Template Config Generator

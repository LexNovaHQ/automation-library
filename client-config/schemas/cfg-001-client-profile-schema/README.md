# CFG-001 - Client Profile Schema

## Status
Built v1.0

## Layer Type
CLIENT_CONFIG_ASSET

## Purpose
Defines the master client operating profile consumed by reusable automation templates, AI workflows, provider adapters, approval flows, status/error systems, and the future ChatGPT Assembly Engine.

## Files
- `../client-profile-schema.json`
- `../../examples/client-profile.example.json`

## Top-Level Sections
- `client_identity`
- `business_context`
- `tool_stack`
- `workflow_preferences`
- `approval_rules`
- `communication`
- `ai_profile`
- `data_rules`
- `deployment`
- `assembly_preferences`

## AI Profile Integration
The AI profile schema is embedded as `ai_profile`.

This section is used by C4 AI components:

- C4-A AI Classification
- C4-B AI Extraction
- C4-D AI Content Generation
- C4-E AI Email Draft
- C4-L Lead Qualification
- C4-M Draft Approval Package

## Assembly Engine Compatibility
The schema includes `assembly_preferences` for the future ChatGPT Project/GPT Assembly Engine.

The Assembly Engine will use:

- client profile
- job profile
- component classification matrix
- template roadmap
- adapter availability

to decide the final workflow assembly.

## Version
v1.0

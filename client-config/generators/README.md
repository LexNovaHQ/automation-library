# Client Config Generators

## Purpose

Scripts/specs/workflows that convert client discovery inputs into validated template configuration objects.

## Current Generators

### CFG-006 - Template Config Generator

Folder:

- `template-config-generator/`

Purpose:

- converts client profile, workflow discovery, tool stack, AI profile, credential readiness, and classification matrix into template-ready config outputs
- defines rules for template selection, component selection, adapter selection, adapter gap reporting, credential blocker detection, and test plan generation
- acts as the spec for the future ChatGPT Project/GPT Assembly Engine

Outputs:

- `template_config.json`
- `adapter_gap_report.json`
- `assembly_recommendation.json`

## Future Upgrade

A later version may include:

- `generate-template-config.ps1`
- JSON schema validation for generated configs
- automated classification CSV lookup
- ChatGPT Assembly Engine project instructions

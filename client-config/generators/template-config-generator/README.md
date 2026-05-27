# CFG-006 - Template Config Generator

## Status
Built v1.0 spec

## Layer Type
CLIENT_CONFIG_ASSET

## Purpose
Defines the generator rules that convert client discovery inputs into a template-ready build configuration.

CFG-006 is not yet a full coded Assembly Engine.

It is the deterministic spec that the future ChatGPT Project/GPT Assembly Engine will follow.

## Inputs
CFG-006 consumes:

- `CFG-001` Client Profile Schema
- `CFG-002` Workflow Discovery response
- `CFG-003` Tool Stack response
- `CFG-004` AI Profile response / compatibility map
- `CFG-005` Credential Readiness response
- `audit/config/component-classification.csv`
- `docs/component-readiness-matrix.md`
- `docs/universal-automation-roadmap.md`

## Outputs
CFG-006 produces:

- `template_config.json`
- `adapter_gap_report.json`
- `assembly_recommendation.json`
- required components list
- required adapters list
- manual handoff list
- missing client information list
- credential blocker list
- test plan

## Role in Platform
CFG-006 is the bridge between discovery and implementation.

It answers:

```text
Given this client and this job, what exact workflow/template should we build, with which components, which adapters, which configs, and what blockers?
Version

v1.0 spec

# Automation Library Docs

## Purpose

This folder contains human-readable documentation for the automation-library repo.

The repo has three documentation layers:

1. Canonical strategy and architecture docs
2. Generated audit/report docs
3. Local component/config/template docs

These layers must not duplicate each other.

---

## Source of Truth Rules

### Machine-readable classification source

`audit/config/component-classification.csv`

This is the machine-readable source of truth for component classification, layer type, readiness, priority, dependencies, and notes.

### Human-readable component catalog

`docs/catalog/component-catalog.md`

This is the human-readable component catalog and build record.

### Generated audit reports

`audit/reports/`

Audit reports are generated outputs. They should not be treated as canonical manual strategy docs.

### Local component docs

`components/**/README.md`

Component READMEs explain the local component only. They should not define global strategy.

### Client config docs

`client-config/`

Client config docs define the reusable client/profile/questionnaire/config-generator layer.

---

## Canonical Docs Structure

- docs/README.md
- docs/architecture/platform-architecture-classification.md
- docs/roadmap/universal-automation-roadmap.md
- docs/catalog/component-catalog.md
- docs/catalog/component-readiness-matrix.md
- docs/process/assembly-pipeline.md
- docs/archive/

---

## Doc Roles

| Doc | Role | Edit Rule |
|---|---|---|
| `docs/architecture/platform-architecture-classification.md` | Defines layer types: core, adapter, glue, config, scaffold, deferred adapter, handoff core | Edit only when classification model changes |
| `docs/roadmap/universal-automation-roadmap.md` | Defines locked build order and commercial roadmap | Edit when strategy changes |
| `docs/catalog/component-catalog.md` | Human-readable component catalogue/build record | Update when components are built or renamed |
| `docs/catalog/component-readiness-matrix.md` | Human-readable readiness snapshot | Should eventually be generated from classification CSV |
| `docs/process/assembly-pipeline.md` | Defines assembly process after components/adapters are ready | Must not override roadmap build order |
| `audit/reports/*` | Generated audit outputs | Regenerate, do not manually edit as canonical docs |

---

## Current Locked Build Strategy

The current locked build strategy is:

1. Complete Category 2 universal automation core + adapters
2. Build Category 1 outreach / sequence infrastructure
3. Build Category 3 onboarding / payment / document delivery infrastructure
4. Finish Category 6 fixing / debugging / reliability infrastructure
5. Use Category 5 dashboards as add-ons across every category
6. Then build controlled AI agents / AI add-ons
7. Use AI add-ons as free bonuses for first 5-10 jobs
8. Build template glue after the core/adapter foundation is ready
9. Restructure repo only after the foundation is proven

---

## Dashboard Add-On Rule

Category 5 is not a heavy separate build phase right now.

Dashboards are add-ons across Category 1, Category 2, Category 3, and Category 6.

Every serious workflow should include:

- status table
- manual review queue
- error log / retry queue

---

## AI Add-On Rule

AI agents are not the first build phase.

Initial AI add-ons must be:

- approval-first
- client-profile aware
- logged
- reversible where possible
- safe on low confidence
- manual-review friendly

Do not build fully autonomous agents until action permissions, run logs, approval gates, and rollback/retry logic are mature.



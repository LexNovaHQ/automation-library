
---

## Primary Category and 80-20 Build Standard

Every component must have a clear primary category.

A component may be shared or borrowed by other categories, but its built status is judged against the job it is supposed to perform in its primary category.

## Required Classification Fields

Every component or adapter must be classed by:

- primary_category
- layer_type
- primary_job
- borrowed_by_categories
- production_80_20_status

## Allowed Layer Types

- CORE_COMPONENT
- PROVIDER_ADAPTER
- UNIVERSAL_ADAPTER
- DIAGNOSTIC_CORE
- DIAGNOSTIC_ADAPTER
- CONFIG_COMPONENT
- GLUE_TEMPLATE
- DEFERRED_ADAPTER
- SCAFFOLD_ONLY

## 80-20 Built Rule

A component may be marked BUILT only when roughly 80 percent of its production job is complete at component level.

The remaining 10-20 percent must be limited to client configuration, credential selection, account-specific IDs, field mapping, endpoint selection, template selection, or destination details.

A component is not validly built if a client job would still require rebuilding core workflow logic, adding missing validation, inventing output contracts, adding missing error handling, or redesigning the component.

## Built Status Test

Before marking any component BUILT, answer yes to all:

- Does it perform its primary category job?
- Is the workflow logic already implemented?
- Are validation paths present?
- Are success outputs normalized?
- Are error outputs normalized?
- Are manual-review, status, or error-log hooks present where relevant?
- Is client customization limited to the expected 10-20 percent?
- Can it be assembled into a real production workflow without rebuilding the component?

If any answer is no, do not mark it BUILT.

Use one of these instead:

- SCAFFOLD_ONLY
- SPEC_DRAFTED
- DEMO_ONLY
- DIAGNOSTIC_ONLY
- DEFERRED

## Category Ownership Rule

No component is category-less.

Universal components and adapters must still have a primary functional home.

Examples:

| Component | Primary Category | Layer Type | Borrowed By | Built Judgment Basis |
|---|---|---|---|---|
| C2-A Parent Data Sync Router | Category 2 | CORE_COMPONENT | Cat 1, Cat 3, Cat 4, Cat 6 | Data routing job is 80 percent implemented. |
| ADP-REST Generic REST API Adapter | Universal adapter layer / Category 2 support | UNIVERSAL_ADAPTER | Cat 1, Cat 2, Cat 3, Cat 4, Cat 6 | Generic REST execution job is production-usable with config-level customization. |
| ADP-WEBHOOK-SEND Generic Webhook Sender | Universal adapter layer / Category 2 support | UNIVERSAL_ADAPTER | Cat 1, Cat 2, Cat 3, Cat 4, Cat 6 | Outbound webhook delivery is production-usable with URL/header/payload customization. |
| Credential / API Access Diagnostic Core | Category 6 | DIAGNOSTIC_CORE | Cat 1, Cat 2, Cat 3, Cat 4, Cat 5 | Credential/API failure detection is the primary production job. |

## Do-Not-Deviate Rule

Do not mark demo workflows as BUILT.

Do not let a universal adapter pretend to be a provider adapter.

Do not let a diagnostic utility pretend to be a delivery workflow.

Do not build category-less components.

Do not continue a build if the component cannot meet the 80-20 production assembly-ready rule for its own primary category.


# CFG-003 - Tool Stack Questionnaire

## Status
Built v1.0

## Layer Type
CLIENT_CONFIG_ASSET

## Purpose
Internal master questionnaire for mapping the client's tool stack, access methods, and adapter requirements.

It identifies:

- source systems
- destination systems
- CRM/database tools
- email/calendar/payment/publishing tools
- file/document tools
- credential requirements
- built adapters available
- deferred adapters required
- adapter gaps

## File
- `../tool-stack-questionnaire.md`
- `../../examples/tool-stack-response.example.json`

## Assembly Engine Role
The future Assembly Engine will use the tool stack response to decide:

- which built adapters can be used
- which independent adapters are needed
- which handoff-only cores require live provider adapters
- which adapter gaps must be scoped
- whether the template is ready to assemble

## Version
v1.0

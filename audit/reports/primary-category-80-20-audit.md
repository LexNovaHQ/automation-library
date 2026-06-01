# Primary Category + 80/20 Audit

Generated: 2026-06-01 16:34:03

## Status Counts

| 80/20 Status | Count |
|---|---:|
| BROKEN_ARTIFACTS | 3 |
| DEFERRED | 4 |
| NOT_BUILT | 7 |
| PASS_80_20 | 31 |
| PASS_80_20_FOR_DECLARED_SCOPE | 2 |
| PASS_CONFIG_ASSET | 10 |
| PASS_HANDOFF_ONLY | 5 |
| REVIEW_REQUIRED | 1 |
| SCAFFOLD_ONLY | 22 |

## Discussion Items

| ID | Name | Layer | Status | Reason |
|---|---|---|---|---|
| ADP-GDRIVE | Google Drive File Storage Adapter | INDEPENDENT_ADAPTER | BROKEN_ARTIFACTS | workflows=1; payloads=0; samples=6; nodes=7; credentials=1 |
| ADP-OUTLOOK-INBOX | Outlook/M365 Inbox Trigger Adapter | INDEPENDENT_ADAPTER | BROKEN_ARTIFACTS | workflows=0; payloads=7; samples=7; nodes=0; credentials=0 |
| ADP-SMTP-SEND | Generic SMTP Send Adapter | INDEPENDENT_ADAPTER | BROKEN_ARTIFACTS | workflows=1; payloads=0; samples=8; nodes=6; credentials=1 |
| ADP-TEAMS-SEND | Microsoft Teams Send Adapter | INDEPENDENT_ADAPTER | REVIEW_REQUIRED | workflows=0; payloads=6; samples=0; nodes=0; credentials=0 |
| ADP-REST | Generic REST API Adapter | INDEPENDENT_ADAPTER | PASS_80_20_FOR_DECLARED_SCOPE | workflows=1; payloads=7; samples=7; nodes=11; credentials=0 |
| ADP-WEBHOOK-SEND | Generic Webhook Sender | INDEPENDENT_ADAPTER | PASS_80_20_FOR_DECLARED_SCOPE | workflows=1; payloads=6; samples=6; nodes=7; credentials=0 |

## Primary Category Counts

| Primary Category | Count |
|---|---:|
| Category 1 - Outreach / Sequencing | 1 |
| Category 2 - Automation Workflows | 21 |
| Category 3 - Client Onboarding / Delivery | 6 |
| Category 4 - AI Workflow Systems | 9 |
| Category 5 - Dashboards / Status / Review | 9 |
| Category 6 - Debugging / Reliability | 8 |
| Client Config Layer | 10 |
| Template Glue Layer | 6 |
| Universal Adapter Layer | 15 |

## Built Artifact Snapshot

| ID | Layer | 80/20 | Workflows | Nodes | Payloads | Samples |
|---|---|---|---:|---:|---:|---:|
| ADP-GDRIVE | INDEPENDENT_ADAPTER | BROKEN_ARTIFACTS | 1 | 7 | 0 | 6 |
| ADP-GMAIL-INBOX | INDEPENDENT_ADAPTER | PASS_80_20 | 1 | 5 | 6 | 6 |
| ADP-GMAIL-SEND | INDEPENDENT_ADAPTER | PASS_80_20 | 1 | 6 | 7 | 7 |
| ADP-IMAP-INBOX | INDEPENDENT_ADAPTER | PASS_80_20 | 1 | 5 | 7 | 7 |
| ADP-OUTLOOK-INBOX | INDEPENDENT_ADAPTER | BROKEN_ARTIFACTS | 0 | 0 | 7 | 7 |
| ADP-OUTLOOK-SEND | INDEPENDENT_ADAPTER | PASS_80_20 | 1 | 6 | 7 | 6 |
| ADP-REST | INDEPENDENT_ADAPTER | PASS_80_20_FOR_DECLARED_SCOPE | 1 | 11 | 7 | 7 |
| ADP-SLACK-SEND | INDEPENDENT_ADAPTER | PASS_80_20 | 1 | 6 | 6 | 7 |
| ADP-SMTP-SEND | INDEPENDENT_ADAPTER | BROKEN_ARTIFACTS | 1 | 6 | 0 | 8 |
| ADP-WEBHOOK-SEND | INDEPENDENT_ADAPTER | PASS_80_20_FOR_DECLARED_SCOPE | 1 | 7 | 6 | 6 |
| C2-A | CORE_COMPONENT | PASS_80_20 | 1 | 4 | 7 | 7 |
| C2-A1 | COMPONENT_ADAPTER | PASS_80_20 | 1 | 6 | 3 | 3 |
| C2-A2 | COMPONENT_ADAPTER | PASS_80_20 | 1 | 6 | 3 | 3 |
| C2-A3 | COMPONENT_ADAPTER | PASS_80_20 | 1 | 6 | 3 | 3 |
| C2-B | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 5 | 4 |
| C2-C | CORE_COMPONENT | PASS_80_20 | 2 | 7 | 6 | 4 |
| C2-D | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 5 | 5 |
| C2-E | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 6 | 6 |
| C2-F | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 6 | 5 |
| C2-G | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 8 | 8 |
| C2-H | HANDOFF_ONLY_CORE | PASS_HANDOFF_ONLY | 1 | 3 | 10 | 10 |
| C2-I | CORE_COMPONENT | PASS_80_20 | 1 | 6 | 3 | 3 |
| C2-J | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 6 | 6 |
| C2-K | COMPONENT_ADAPTER | PASS_80_20 | 1 | 7 | 5 | 5 |
| C2-L | HANDOFF_ONLY_CORE | PASS_HANDOFF_ONLY | 1 | 3 | 9 | 9 |
| C2-M | HANDOFF_ONLY_CORE | PASS_HANDOFF_ONLY | 1 | 3 | 10 | 10 |
| C2-N | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 7 | 7 |
| C2-O | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 5 | 5 |
| C2-O2 | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 7 | 7 |
| C2-P | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 6 | 6 |
| C2-Q | HANDOFF_ONLY_CORE | PASS_HANDOFF_ONLY | 1 | 3 | 11 | 11 |
| C4-A | CORE_COMPONENT | PASS_80_20 | 1 | 7 | 7 | 7 |
| C4-B | CORE_COMPONENT | PASS_80_20 | 1 | 7 | 7 | 7 |
| C4-D | CORE_COMPONENT | PASS_80_20 | 1 | 7 | 7 | 7 |
| C4-E | CORE_COMPONENT | PASS_80_20 | 1 | 7 | 6 | 6 |
| C4-L | CORE_COMPONENT | PASS_80_20 | 1 | 7 | 7 | 7 |
| C4-M | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 5 | 5 |
| C4-T | HANDOFF_ONLY_CORE | PASS_HANDOFF_ONLY | 1 | 3 | 9 | 9 |
| C5-E | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 6 | 6 |
| C5-W | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 5 | 5 |
| C6-G | CORE_COMPONENT | PASS_80_20 | 1 | 3 | 5 | 5 |
| CFG-001 | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-002 | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-002A | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-003 | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-003A | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-004 | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-004A | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-005 | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-005A | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |
| CFG-006 | CLIENT_CONFIG_ASSET | PASS_CONFIG_ASSET | 0 | 0 | 0 | 0 |

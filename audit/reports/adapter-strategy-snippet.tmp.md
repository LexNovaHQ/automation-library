
---

## Adapter Strategy Lock

The repo will not build 10-15 platform adapters blindly.

The locked adapter strategy is:

- core component
- generic REST/webhook adapter path
- 3-4 highest-demand specialised adapters
- manual/handoff fallback

## Adapter Build Rule

For each adapter family, prefer:

1. A stable core component contract.
2. A generic REST/webhook route for long-tail APIs.
3. A small number of high-ROI specialised adapters.
4. A manual/handoff fallback for unsupported providers.

Do not build low-demand provider adapters until real client/job demand proves the need.

## Immediate P0 Adapter Sprint

| Order | Adapter | Type | Why |
|---:|---|---|---|
| 1 | ADP-REST Generic REST API Adapter | Generic independent adapter | Universal long-tail API adapter. |
| 2 | ADP-WEBHOOK-SEND Generic Webhook Sender | Generic independent adapter | Universal outbound webhook adapter. |
| 3 | ADP-OAUTH-TEST OAuth Credential Test Adapter | Diagnostic adapter | Prevents credential/access failures before build. |
| 4 | ADP-GMAIL-SEND Gmail Send Adapter | Specialised adapter | Email send is universal. |
| 5 | ADP-GMAIL-INBOX Gmail Inbox Trigger Adapter | Specialised adapter | Inbound/reply workflows. |
| 6 | ADP-WHATSAPP-CLOUD WhatsApp Cloud API Adapter | Specialised adapter | Very high-demand business messaging. |
| 7 | ADP-WHATSAPP-TEMPLATE WhatsApp Template Message Adapter | Specialised adapter | Required for compliant outbound WhatsApp templates. |

## P1 Adapter Sprint

| Adapter | Type | Why |
|---|---|---|
| ADP-WHATSAPP-INBOUND | Specialised adapter | WhatsApp reply/support/lead capture. |
| ADP-SLACK-SEND | Specialised adapter | Team alerts, status, error notifications. |
| ADP-GDRIVE | Specialised adapter | File routing, onboarding, document workflows. |
| ADP-PDF | Specialised adapter | Document parsing/extraction workflows. |
| ADP-NOTION-DB | Specialised adapter | SMB/agency/creator database workflows. |
| ADP-GCAL-CREATE | Specialised adapter | Calendar event creation. |
| ADP-STRIPE-LINK | Specialised adapter | Payment links for global clients. |

## Adapter Family Rules

| Family | Core Component | Generic Route | Specialised Adapters Now | Later Only If Demand Proves |
|---|---|---|---|---|
| Data write / CRM / database | C2-A | ADP-REST, ADP-WEBHOOK-SEND | C2-A1, C2-A2, C2-A3, ADP-NOTION-DB | Pipedrive, GHL, Zoho, Close, Monday, ClickUp |
| Messaging / notification | C2-I, C2-M | ADP-REST, ADP-WEBHOOK-SEND | ADP-GMAIL-SEND, ADP-WHATSAPP-CLOUD, ADP-WHATSAPP-TEMPLATE, ADP-SLACK-SEND | Twilio, WATI, Telegram, Discord, SMS |
| Inbound message / inbox | C1-F, C2-C, C2-M | C2-C Webhook Trigger | ADP-GMAIL-INBOX, ADP-WHATSAPP-INBOUND | Outlook, Telegram, Slack inbound |
| File / document | C2-G, C4-T, C4-B | ADP-REST | ADP-GDRIVE, ADP-PDF | Dropbox, OneDrive, S3, Google Vision |
| Scheduling / calendar | C2-L | ADP-REST | ADP-GCAL-CREATE | Outlook Calendar, Calendly, Cal.com |
| Payment | C2-H, C3-H | ADP-REST | ADP-STRIPE-LINK, ADP-RAZORPAY-LINK | PayPal, Wise, Square, Paddle |

## Do-Not-Deviate Rule

Do not expand the adapter backlog just because a platform exists.

Only build a new specialised adapter when it is:

- frequently requested in client/freelance jobs,
- useful across multiple categories,
- hard to handle cleanly with ADP-REST/ADP-WEBHOOK-SEND,
- credential/auth/object-mapping heavy, or
- valuable enough to improve portfolio/demo credibility.

Current next adapter build:

ADP-REST - Generic REST API Adapter


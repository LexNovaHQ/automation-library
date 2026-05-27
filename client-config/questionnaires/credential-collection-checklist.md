# CFG-005 - Credential Collection Checklist

## Purpose

This is the internal credential and access-readiness checklist for automation delivery.

It identifies:

- required tool access
- credential type needed
- who owns credentials
- OAuth/API key availability
- workspace invite requirements
- test/sandbox availability
- production restrictions
- security/privacy constraints
- adapter readiness
- blocker status before implementation

This checklist feeds:

- CFG-001 Client Profile Schema
- CFG-003 Tool Stack Questionnaire
- CFG-006 Template Config Generator
- future ChatGPT Project/GPT Assembly Engine
- adapter gap scoping
- implementation readiness checks

---

# 1. Credential Overview

## 1.1 Project / workflow name

```text
workflow:
client:
date:
owner:
1.2 Credential readiness status

Choose one:

ready
partially ready
blocked
awaiting client
not required yet
1.3 Access owner

Who is responsible for providing credentials?

name:
role:
email:
backup contact:
1.4 Implementation environment

Choose:

development
test
staging
production
client workspace only
not sure
2. Tool Access Inventory

For each tool required by the workflow, complete:

tool:
purpose:
required for:
credential type:
access level required:
access owner:
available now:
sandbox/test available:
production access allowed:
credential storage notes:
security restrictions:
status:
blockers:
Credential type options
admin invite
member invite
OAuth connection
API key
private app token
webhook secret
SMTP credentials
service account
app password
manual export/import
no credentials required
other
Access level options
owner
admin
editor
member
read-only
API-only
test/sandbox only
production
unknown
3. Source Tool Credentials
3.1 Form providers

Examples:

Tally
Google Forms
Typeform
Jotform
Fillout
Webflow form

For each:

tool:
access method:
webhook setup required: yes/no
sample submission available: yes/no
admin access needed: yes/no
status:
3.2 Email inbox sources

Examples:

Gmail
Outlook/Microsoft 365
IMAP

For each:

tool:
access method: OAuth/API/forwarding/manual
mailbox owner:
read permission required: yes/no
send permission required: yes/no
reply/thread access required: yes/no
status:
3.3 File/document sources

Examples:

Google Drive
Dropbox
OneDrive
email attachments
upload form

For each:

tool:
folder/location:
read access required:
write access required:
file sample available:
sensitive files involved:
status:
3.4 Webhook/API sources

For each:

source system:
webhook URL can be configured: yes/no
secret/signature available: yes/no
sample payload available: yes/no
API documentation available: yes/no
status:
4. Destination Tool Credentials
4.1 CRM/database destinations

Examples:

HubSpot
Airtable
Google Sheets
Notion
Pipedrive
GoHighLevel
Salesforce
Zoho
Supabase/Postgres

For each:

tool:
credential type:
objects/tables needed:
create permission required:
update permission required:
read/search permission required:
delete permission required: yes/no
test record allowed: yes/no
status:
4.2 Notification destinations

Examples:

Gmail
Outlook
SMTP
Slack
Teams
WhatsApp
SMS

For each:

tool:
credential type:
send permission required:
channel/list recipient:
approval needed from workspace admin:
test message allowed:
status:
4.3 Scheduling destinations

Examples:

Google Calendar
Outlook Calendar
Calendly
Cal.com

For each:

tool:
credential type:
create event required:
read availability required:
booking webhook required:
attendees/meeting links required:
test event allowed:
status:
4.4 Payment destinations

Examples:

Stripe
Razorpay
PayPal
Wise/manual

For each:

tool:
credential type:
test mode available:
live mode access required:
payment link creation required:
webhook status tracking required:
refund/cancel permission required:
status:
4.5 Publishing destinations

Examples:

LinkedIn
WordPress
Webflow
X/Twitter
Buffer

For each:

tool:
credential type:
draft creation required:
live publishing required:
media upload required:
approval required before publish:
test/draft environment available:
status:
5. OAuth / API Security
5.1 OAuth possible?
yes
no
not sure
tool dependent
5.2 API keys available?
yes
no
client needs guidance
not applicable
5.3 Credential storage policy

Where can credentials be stored?

n8n credentials
Make connections
Zapier connections
client-owned workspace only
environment variables
password manager
cannot store credentials
not sure
5.4 Credential sharing restrictions

Choose all that apply:

cannot share admin access
cannot share API keys directly
must use OAuth only
must use client workspace
production credentials only after approval
no third-party storage
sensitive data involved
other
5.5 Credential rotation expectations
rotation required: yes/no/not sure
rotation frequency:
who owns rotation:
6. Test / Sandbox Readiness
6.1 Is test data available?
yes
no
client will provide
must create dummy data
6.2 Is sandbox access available?
yes
no
not supported by tool
not sure
6.3 Can test records be created in production?
yes
no
only with prefix/tag
not sure
6.4 Test record naming rule

Example:

TEST - Automation Library - Do Not Use
6.5 Rollback/delete policy

What should happen to test records after testing?

delete
archive
leave with test label
client decides
not sure
7. Webhooks
7.1 Webhook setup required?
yes
no
not sure
7.2 Webhook tools

List tools needing webhook setup.

7.3 Webhook security

For each webhook:

tool:
secret/signature supported:
signature verification required:
replay protection required:
IP allowlist required:
status:
7.4 Webhook test payloads

Can the client provide sample webhook events?

yes
no
later
8. Data / Privacy / Security Constraints
8.1 Sensitive data involved?

Choose all that apply:

personal data
payment data
health data
legal data
financial data
customer complaints
employee data
confidential business data
none
8.2 Data logging restrictions

Can workflow logs include full payloads?

yes
no
redacted only
not sure
8.3 PII redaction required?
yes
no
not sure
8.4 File retention rules
retain files for:
delete after:
archive location:
8.5 Client workspace isolation required?
yes
no
not sure
9. Blocker Assessment
9.1 Current blockers

List unresolved access blockers.

tool:
blocker:
owner:
needed by:
deadline:
9.2 Build can start?

Choose one:

yes, all access ready
yes, with dummy data/manual mocks
partially, some adapters blocked
no, credentials/access missing
not sure
9.3 Adapter readiness

For each required adapter:

adapter:
credential ready: yes/no
test data ready: yes/no
live execution allowed: yes/no
status:
9.4 Final credential readiness recommendation

Choose one:

ready for implementation
ready for mock/demo only
ready except live-send/payment/publish
blocked until client grants access
blocked due to security restrictions

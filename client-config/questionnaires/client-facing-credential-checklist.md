# CFG-005A - Client-Facing Credential Checklist

## Purpose

This is the simplified client-facing checklist for collecting access and credential readiness information.

It helps us understand what access is available before implementation.

This form avoids internal terms like:

- adapter readiness
- component dependency
- execution contract
- classification matrix
- Assembly Engine

---

# 1. Basic Access Information

## 1.1 Who will provide access?

```text
Name:
Role:
Email:
Backup contact:
1.2 Where should the automation be built?

Choose one:

my own n8n/Make/Zapier workspace
your workspace first, then transfer
client-owned workspace only
not sure
1.3 Can we create test records?
yes
no
only with clear test labels
not sure
2. Tool Access

For each tool involved in the workflow, please provide:

Tool name:
What it is used for:
Who owns it:
Can access be provided now? yes/no/later
Preferred access method:
Any restrictions:
Common access methods
admin invite
member invite
OAuth connection
API key
private app token
webhook setup
SMTP/app password
manual export/import
not sure
3. Source Tools
3.1 Forms / websites

Examples:

Tally
Google Forms
Typeform
Webflow
website form

Questions:

Which form/website tool starts the workflow?
Can we access submissions?
Can we set up webhooks?
Can you provide a test submission?
3.2 Email inbox

Examples:

Gmail
Outlook / Microsoft 365

Questions:

Do we need to read incoming emails?
Do we need to send emails?
Can OAuth access be provided?
Can we use a test mailbox?
3.3 File storage

Examples:

Google Drive
Dropbox
OneDrive

Questions:

Where are files stored?
Do we need read access?
Do we need write/upload access?
Can you provide sample files?
4. Destination Tools
4.1 CRM / database

Examples:

HubSpot
Airtable
Google Sheets
Notion
Pipedrive
GoHighLevel
Salesforce

Questions:

Where should records be created or updated?
Do we need create permission?
Do we need update permission?
Do we need search/read permission for duplicate checks?
Can test records be created?
4.2 Notifications

Examples:

email
Slack
Teams
WhatsApp
SMS

Questions:

Where should notifications be sent?
Who should receive them?
Can we send a test message?
Does a workspace admin need to approve access?
4.3 Calendar / scheduling

Examples:

Google Calendar
Outlook Calendar
Calendly
Cal.com

Questions:

Do we need to create calendar events?
Do we need to check availability?
Do we need to send booking links?
Can test events be created?
4.4 Payments / invoices

Examples:

Stripe
Razorpay
PayPal
Wise

Questions:

Do we need payment links or invoices?
Is test mode available?
Do we need live payment access?
Do we need payment status webhooks?
4.5 Publishing

Examples:

LinkedIn
WordPress
Webflow
X/Twitter
Buffer

Questions:

Do we need to publish live?
Is draft/manual review enough?
Can test drafts be created?
Who approves publishing?
5. Security and Restrictions
5.1 Any access restrictions?

Choose any:

cannot share admin access
cannot share API keys
OAuth only
must work inside client workspace
no third-party storage
production access only after approval
sensitive customer data involved
other
5.2 Can workflow logs include full data?
yes
no
only redacted data
not sure
5.3 Is sensitive data involved?

Choose any:

personal data
payment data
health data
legal data
financial data
customer complaints
employee data
confidential business data
none
5.4 Should data be deleted after a period?
No / Yes
If yes, after how long?
6. Test Data
6.1 Can you provide sample data?

Examples:

sample form submission
sample email
sample spreadsheet row
sample CRM record
sample file/document
sample payment event
6.2 Can dummy data be used?
yes
no
not sure
6.3 How should test records be labelled?

Example:

TEST - Automation Setup
6.4 What should happen to test records after setup?
delete
archive
keep with test label
decide later
7. Final Readiness
7.1 Are all required tool accesses ready?
yes
partially
no
not sure
7.2 Which access is still missing?
Tool:
Missing access:
Who will provide:
Expected date:
7.3 Can implementation start with mock/demo data?
yes
no
not sure
7.4 Anything else we should know about access/security?


# CFG-003 - Tool Stack Questionnaire

## Purpose

This is the internal master questionnaire for mapping a client's tool stack.

It is used to determine:

- source systems
- destination systems
- notification channels
- CRM/database tools
- email/calendar/payment/publishing tools
- file/document tools
- credential requirements
- existing adapter availability
- adapter gaps
- live execution vs manual handoff requirements

This questionnaire feeds:

- CFG-001 Client Profile Schema
- CFG-002 Workflow Discovery Questionnaire
- CFG-006 Template Config Generator
- future ChatGPT Project/GPT Assembly Engine

---

# 1. Tool Stack Overview

## 1.1 What tools does the client currently use?

List all relevant tools.

Examples:

```text
Tally
Google Forms
HubSpot
Airtable
Google Sheets
Gmail
Outlook
Slack
Google Calendar
Calendly
Stripe
Razorpay
Google Drive
Notion
Pipedrive
GoHighLevel
1.2 Which tools are essential?

Which tools must be included in the automation?

1.3 Which tools are optional?

Which tools are nice-to-have but not mandatory?

1.4 Which tools should not be touched?

List any systems that should not be modified by automation.

2. Source Systems
2.1 What systems can start workflows?

Choose all that apply:

form tool
email inbox
webhook/API
CRM record
spreadsheet row
uploaded file
calendar event
payment event
chat/message
manual trigger
scheduled trigger
2.2 Source tool names

For each source, list the exact tool.

Example:

lead form -> Tally
incoming emails -> Gmail
file uploads -> Google Drive
payments -> Stripe
2.3 Source access method

How can we access each source?

webhook
API
email forwarding
export/import
CSV upload
direct platform trigger
manual upload
not sure
2.4 Source sample availability

Can the client provide sample records from each source?

For each source:

tool:
sample available: yes/no
sample type:
3. Destination Systems
3.1 Where should automation write/update data?

Choose all that apply:

Google Sheets
Airtable
HubSpot
Notion
Pipedrive
GoHighLevel
Salesforce
Zoho
ClickUp
Asana
Trello
Monday.com
Supabase/Postgres
custom API
other
3.2 What should be created or updated?

For each destination:

tool:
record type:
create/update/upsert:
unique key:
required fields:

Examples:

HubSpot -> contact -> upsert -> email
Google Sheets -> row -> append -> none
Notion -> database item -> create -> page_id
Pipedrive -> deal -> create/update -> email/company
3.3 Is live writing required?

For each destination, choose:

live API write required
manual handoff acceptable
CSV import acceptable
not sure
4. CRM / Database Stack
4.1 Main CRM

Which CRM is the source of truth?

HubSpot
Pipedrive
GoHighLevel
Salesforce
Zoho
Airtable
Notion
Google Sheets
none
other
4.2 CRM object types needed

Choose all that apply:

contact
company
deal
lead
ticket
task
note
custom object
4.3 Dedupe key

What field identifies duplicates?

email
phone
company
domain
CRM ID
custom field
4.4 Existing pipeline/stage fields

If applicable:

pipeline:
stage:
owner field:
status field:
source field:
5. Communication Tools
5.1 Email provider

Choose:

Gmail
Outlook / Microsoft 365
SMTP
SendGrid
Mailgun
other
none
5.2 Email use case

Choose all that apply:

send notifications
send client/customer emails
send approval requests
send daily digest
read inbound emails
track replies
no email
5.3 Team notification tools

Choose all that apply:

Slack
Microsoft Teams
WhatsApp
SMS
Discord
Telegram
none
5.4 Notification rules

For each event, where should notification go?

new lead:
approval needed:
workflow error:
daily digest:
payment received:
manual review:
5.5 Live sending required?

For each communication channel:

live send required
manual handoff acceptable
not needed
6. Calendar / Scheduling Tools
6.1 Calendar provider

Choose:

Google Calendar
Outlook Calendar
Calendly
Cal.com
TidyCal
manual link
none
6.2 Scheduling use case

Choose all that apply:

send booking link
create calendar event
check availability
send reminder
reschedule/cancel event
capture booking webhook
no scheduling
6.3 Live calendar execution required?
yes
no, handoff/link is fine
not sure
6.4 Meeting details

If events are created:

default duration:
meeting location:
video meeting provider:
attendees:
reminder timing:
7. Payment / Invoice Tools
7.1 Payment provider

Choose:

Stripe
Razorpay
PayPal
Wise
Payoneer
manual bank transfer
none
7.2 Payment use case

Choose all that apply:

create payment link
create invoice
track payment status
send payment reminder
notify on payment received
refund/cancellation handoff
no payment
7.3 Live payment execution required?
yes
no, manual payment instructions are fine
not sure
7.4 Payment event source

Can payment status be received by webhook/API?

yes
no
not sure
8. File / Document Tools
8.1 File storage

Choose:

Google Drive
Dropbox
OneDrive
temporary upload
email attachments
Notion
none
8.2 Document/file use case

Choose all that apply:

upload files
route files by type
extract text from PDF
extract text from DOCX
OCR images/scans
extract invoice/receipt fields
attach file to CRM record
archive files
manual review
8.3 OCR / document parsing requirement

Choose:

not needed
text extraction only
OCR required
table extraction required
invoice/receipt extraction required
not sure
9. Publishing / Marketing Tools
9.1 Publishing platforms

Choose all that apply:

LinkedIn
WordPress
Webflow
X/Twitter
Facebook Page
Instagram Business
Shopify Blog
Buffer
Hypefury
SocialBee
none
9.2 Publishing use case

Choose all that apply:

draft content only
approval workflow
manual publishing handoff
live publishing
content calendar
media upload
no publishing
9.3 Live publishing required?
yes
manual handoff acceptable
not sure
10. Access / Credentials
10.1 What access can the client provide?

For each tool:

tool:
access type: owner/admin/member/API key/OAuth/invite/manual export
available now: yes/no/later
notes:
10.2 Are API keys available?
yes
no
client needs guidance
not applicable
10.3 Are OAuth connections possible?
yes
no
not sure
10.4 Are test accounts/sandbox available?
yes
no
not sure
10.5 Any access restrictions?

Examples:

no admin access
cannot share API key
must use client workspace
cannot use external storage
production access only after approval
11. Adapter Mapping

Internal section.

11.1 Existing built adapters available

Mark which built adapters can be used:

C2-A1 Google Sheets Write Adapter
C2-A2 Airtable Write Adapter
C2-A3 HubSpot Contact Write Adapter
C2-I Email Notification Adapter
C2-K LLM in Workflow Adapter
11.2 Handoff-only cores involved

Mark which handoff-only cores may need live adapters:

C2-H Payment-on-Intake Flow
C2-L Calendar / Scheduling Automation
C2-M WhatsApp Message Automation
C2-Q Publishing Adapter Family
C4-T OCR / Document Processing Pipeline
11.3 Deferred adapters required

List any required adapters not yet built:

Gmail Send Adapter
Slack Send Adapter
Generic REST API Adapter
Google Calendar Adapter
Stripe Payment Link Adapter
PDF Text Extraction Adapter
11.4 Adapter gap action

Choose one:

build custom adapter
use manual handoff
use generic REST adapter
replace tool
reject/avoid template
decide later
12. Assembly Engine Output

Internal section.

12.1 Required adapter list

Final required adapters:

built adapters:
deferred adapters:
custom adapters:
manual handoffs:
12.2 Tool risk level
low
medium
high

Factors:

no API access
unclear credentials
tool not supported
unstable data format
no sample data
high compliance sensitivity
12.3 Final recommendation

Choose one:

ready to assemble with existing components
ready but requires adapter build
needs more client information
not suitable for current library

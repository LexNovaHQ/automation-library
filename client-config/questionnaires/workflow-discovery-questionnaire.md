# CFG-002 - Workflow Discovery Questionnaire

## Purpose

This is the internal master questionnaire for discovering a client automation job.

It is not meant to be sent to every client as-is. It is the complete internal framework used by the operator and future ChatGPT Assembly Engine to convert client answers into a structured job profile.

It captures:

- trigger/source
- input data
- processing logic
- decisions/routing
- outputs/actions
- approvals
- error handling
- AI requirements
- success metrics
- Assembly Engine notes

---

# 1. Workflow Identity

## 1.1 Workflow name

What should this workflow be called?

## 1.2 Workflow objective

What business outcome should this automation achieve?

## 1.3 Current manual process

Describe how this process currently works manually.

Include:

- who receives the input
- where they check it
- what they copy/paste
- where records are updated
- who gets notified
- what usually gets missed

## 1.4 Pain / reason for automation

Why is this workflow being automated now?

Common options:

- slow response time
- missed leads
- manual copy-paste
- duplicate records
- poor follow-up
- inconsistent data
- no visibility/status tracking
- AI drafting/classification needed
- payment/scheduling/publishing handoff needed
- other

---

# 2. Trigger / Source

## 2.1 What starts the workflow?

Choose one or more:

- form submission
- webhook event
- new email
- uploaded file
- CSV/Excel upload
- calendar event
- payment event
- CRM status change
- manual trigger
- scheduled trigger
- other

## 2.2 Source tool

Where does the trigger come from?

Examples:

- Tally
- Google Forms
- Typeform
- Webflow form
- HubSpot
- Gmail
- Outlook
- Google Drive
- Slack
- Stripe
- Razorpay
- custom API
- manual upload

## 2.3 Trigger frequency

How often does this happen?

- many times per day
- daily
- weekly
- occasional
- seasonal
- unknown

## 2.4 Expected volume

Approximate number of items:

```text
per day:
per week:
per month:
peak volume:
2.5 Sample input available?

Can the client provide a real or dummy sample input?

yes
no
later

If yes:

form sample
webhook JSON
email example
CSV file
document/image
CRM record
other
3. Input Data
3.1 Expected fields

List expected fields.

Example:

name
email
company
phone
message
budget
timeline
source
service_interest
3.2 Required fields

Which fields are mandatory?

3.3 Optional fields

Which fields are useful but optional?

3.4 Sensitive fields

Does the workflow contain sensitive data?

Examples:

phone number
payment details
health data
legal data
financial data
customer complaints
internal notes
personal IDs
other
3.5 Fields that must never be inferred

Which fields should AI/workflow never guess?

Examples:

email
phone
payment amount
legal status
diagnosis
consent status
address
3.6 Data quality issues

What problems happen with incoming data?

missing email
wrong phone format
duplicate leads
unclear message
spam
bad company name
wrong file type
incomplete form
other
4. Processing / Logic
4.1 What should the workflow do after receiving input?

Choose all that apply:

validate required fields
normalize fields
classify item
extract fields from text
score/qualify lead
detect duplicates
check suppression/opt-out
route by category
create/update CRM record
create task
draft email
send notification
request approval
create payment handoff
create scheduling handoff
create publishing handoff
run OCR/document extraction
log status
log errors
other
4.2 Classification needed?

Should the workflow classify the item?

Examples:

lead type
ticket category
priority
spam/not spam
buyer intent
support issue
document type
payment status
publish type
4.3 Extraction needed?

Should the workflow extract structured fields from text/documents/emails?

If yes, list target fields.

4.4 Scoring / qualification needed?

Should the workflow score or qualify the item?

Examples:

qualified lead
unqualified lead
manual review
high priority
low priority
ready for follow-up
not ready
4.5 Decision rules

List routing or decision rules.

Example:

If budget >= 500 and timeline <= 30 days -> qualified
If email missing -> manual review
If duplicate exists -> merge/update existing record
If confidence below 0.75 -> manual review
If opted out -> suppress
4.6 Dedupe rules

How should duplicates be detected?

email only
phone only
email + company
domain + company
CRM ID
custom rule
4.7 Suppression / consent rules

Should the workflow check opt-out or suppression lists?

If yes, where is the suppression list?

5. Outputs / Actions
5.1 Where should data be written?

Examples:

Google Sheets
Airtable
HubSpot
Notion
Pipedrive
GoHighLevel
Salesforce
ClickUp
custom API
none
5.2 What record should be created or updated?

Examples:

contact
company
deal
lead
task
ticket
row
database item
status record
document record
5.3 Notifications needed?

Who should be notified?

Channels:

email
Slack
Teams
WhatsApp
SMS
5.4 Email drafting/sending needed?

Choose one:

draft only
draft + approval
draft + auto-send
no email
5.5 Scheduling needed?

Choose one:

create scheduling link handoff
create calendar event
send booking email
send reminder
no scheduling
5.6 Payment needed?

Choose one:

create payment request handoff
create live payment link
create invoice
track payment status
no payment
5.7 Publishing needed?

Choose one:

prepare content for publishing
publish to CMS/social
manual review only
no publishing
5.8 Documents/files needed?

Choose one:

route uploaded file
extract text
run OCR
extract fields
manual review
no documents
6. Human Approval / Review
6.1 What requires approval?

Choose all that apply:

AI email drafts
AI content drafts
CRM updates
payment requests
publishing
high-value leads
low-confidence AI outputs
errors/failures
nothing
6.2 Who approves?
Approver role:
Approver email:
Backup approver:
6.3 Allowed approval actions
approve
edit
reject
request more info
manual review
retry
6.4 Approval SLA
immediate
same day
24 hours
48 hours
no SLA
7. Error Handling / Reliability
7.1 Missing required data action

What should happen if required data is missing?

manual review
reject record
request more info
continue with partial data
other
7.2 Tool/API failure action

What should happen if an API/tool fails?

retry
log error
notify owner
manual review
stop workflow
7.3 Retry rules
max retries:
delay between retries:
which errors should not retry:
7.4 Manual review triggers

When should a record go to manual review?

Examples:

missing required field
duplicate conflict
low confidence
unsupported file type
payment issue
unclear intent
API failure
7.5 Status tracking

Should the workflow track status for every item?

If yes, where?

8. AI Requirements
8.1 Is AI required?
yes
no
optional
8.2 AI task type

Choose all that apply:

classify
extract
summarize
qualify
draft email
draft content
detect risk
decide route
repair malformed data
other
8.3 Confidence threshold

Default recommendation:

manual review if confidence < 0.75
8.4 AI restrictions

What should AI never do?

Examples:

never invent email/phone
never auto-send without approval
never make legal/medical/financial claims
never promise results
never change payment amount
never override opt-out
9. Success Metrics
9.1 What does success mean?

Examples:

lead response time under 15 minutes
0 missed form submissions
all leads logged in CRM
duplicate rate reduced
email drafts approved faster
manual work reduced
errors visible in status table
9.2 Acceptance tests

Examples:

Submit test form -> CRM record created
Missing email -> manual review
Duplicate email -> existing record updated
Qualified lead -> notification sent
AI confidence low -> approval required
API failure -> error logged
9.3 Must-pass test cases
valid input:
missing required field:
duplicate record:
low confidence:
tool/API failure:
manual review:
10. Assembly Engine Notes

Internal only.

10.1 Preferred template

If known:

TPL-P0-001 Lead Intake to Qualification to Follow-up
TPL-P0-002 Form Submission to CRM Update to Team Alert
TPL-P0-003 CSV/Excel Cleanup to CRM Import
TPL-P0-004 Webhook to Normalize to API Sync
TPL-P0-005 AI Email Draft to Approval to Send
TPL-P0-006 Inbound Email to Extract to CRM Update
10.2 Known required components

List known components if any.

10.3 Known required adapters

List known adapters if any.

10.4 Adapter gaps

What provider-specific execution is needed but may not be built yet?

10.5 Final assembly output wanted

Choose one:

stepwise build instructions
n8n workflow build plan
n8n workflow JSON
client handoff pack
implementation checklist
adapter gap report

# CFG-002A - Client-Facing Workflow Discovery Form

## Purpose

This is the simplified client-facing version of the workflow discovery questionnaire.

Clients can answer this directly through Tally, Google Forms, Typeform, Fillout, Notion, email, or a discovery call.

This form intentionally avoids internal terms like:

- component
- adapter
- template glue
- Assembly Engine
- C2/C4/C5/C6 IDs

---

# 1. Basic Information

## 1.1 What should we call this automation?

Example:

```text
New lead intake automation
Invoice processing workflow
Support ticket routing workflow
1.2 What do you want this automation to do?

Describe the result you want in simple words.

Example:

When someone fills our lead form, add them to HubSpot, notify us, and draft a follow-up email.
1.3 Why do you want to automate this now?

Choose any that apply:

we miss leads/messages
follow-up is too slow
too much copy-paste
duplicate records
data is messy
team forgets to update CRM/sheets
no one knows the status
we need AI help with sorting/drafting
other
1.4 How does this process work today?

Briefly explain the current manual process.

Prompts:

who receives the information?
where do they check it?
what do they copy/paste?
what tool do they update?
who do they notify?
where does the process break?
2. Starting Point
2.1 What starts the workflow?

Choose one:

form submission
new email
uploaded file
spreadsheet/CSV upload
webhook/API event
new CRM record
calendar booking
payment event
manual trigger
scheduled trigger
other
2.2 Which tool does it come from?

Examples:

Tally
Google Forms
Typeform
Gmail
Outlook
HubSpot
Airtable
Google Sheets
Google Drive
Stripe
Razorpay
Slack
other
2.3 How often does this happen?
many times per day
daily
weekly
occasionally
not sure
2.4 Can you provide a sample?

Can you share a real or dummy example of the input?

Examples:

form submission
email
spreadsheet
uploaded file
webhook JSON
CRM record
screenshot
3. Information Collected
3.1 What information comes in?

List the fields or information you receive.

Example:

name
email
company
phone
message
budget
timeline
service needed
3.2 Which fields are required?

Which information must be present for the workflow to work?

3.3 Which fields are optional?

Which information is useful but not mandatory?

3.4 Is any information sensitive?

Examples:

phone numbers
payment details
customer complaints
health information
legal information
financial information
personal IDs
internal notes
3.5 What should the automation never guess?

Examples:

email
phone number
payment amount
address
consent/opt-out status
legal/medical/financial conclusions
4. What Should Happen Next?
4.1 What actions should the automation perform?

Choose any that apply:

check required fields
clean/format the data
remove or detect duplicates
decide whether the item is important
classify the item
extract details from a message/document
score or qualify a lead
update CRM
update Google Sheets/Airtable/Notion
create a task
notify someone
draft an email
send an email
request approval first
create a booking/scheduling step
create a payment request
process a file/document
log status
log errors
4.2 Are there any decision rules?

Example:

If email is missing, send to manual review.
If budget is above $500, mark as high priority.
If person already exists in CRM, update the existing record.
If message is unclear, ask a human to review it.
4.3 Should duplicates be checked?

If yes, how should duplicates be detected?

email
phone
company name
CRM ID
other
4.4 Should any contacts be excluded?

Example:

unsubscribed contacts
existing customers
competitors
internal test records
blocked domains
5. Where Should Outputs Go?
5.1 Where should the data be saved?

Choose any:

Google Sheets
Airtable
HubSpot
Notion
Pipedrive
GoHighLevel
Salesforce
ClickUp
other CRM
custom API
not sure
5.2 What should be created or updated?

Examples:

contact
lead
company
deal
task
ticket
spreadsheet row
database item
status record
5.3 Who should be notified?

Examples:

owner
sales team
support team
finance
marketing
client
approver
5.4 Where should notifications be sent?
email
Slack
Microsoft Teams
WhatsApp
SMS
other
6. Email / Scheduling / Payment / Files
6.1 Do you need email drafting or sending?

Choose one:

no email needed
draft email only
draft email and ask for approval
draft and send automatically
not sure
6.2 Do you need scheduling?

Choose one:

no scheduling needed
send booking link
create calendar event
send reminder
not sure
6.3 Do you need payment or invoice steps?

Choose one:

no payment needed
create payment request
create payment link
create invoice
track payment status
not sure
6.4 Do you need file/document handling?

Choose one:

no files
route uploaded file
extract text from document
process receipts/invoices
OCR scanned documents/images
not sure
7. Approval and Human Review
7.1 What should require human approval?

Choose any:

AI-generated email
AI-generated content
CRM update
payment request
publishing/posting
high-value lead
unclear/low-confidence result
errors
nothing
7.2 Who approves?
Name:
Role:
Email:
Backup approver:
7.3 What actions can the approver take?
approve
edit
reject
request more information
send to manual review
7.4 How quickly should approvals happen?
immediately
same day
within 24 hours
within 48 hours
no strict timeline
8. Failure Handling
8.1 What should happen if required information is missing?
send to manual review
reject/stop
request more information
continue with partial data
not sure
8.2 What should happen if a tool/API fails?
retry
log the error
notify someone
send to manual review
stop the workflow
not sure
8.3 Should every item have a status?

Example statuses:

received
validated
duplicate_found
qualified
draft_created
approval_pending
sent
failed
manual_review

Yes / No / Not sure.

9. AI Requirements
9.1 Do you want AI involved?
yes
no
maybe
9.2 What should AI help with?
classify items
extract details
summarize messages/documents
qualify leads
draft emails
draft content
detect urgency/risk
decide routing
other
9.3 What should AI never do?

Examples:

never invent contact details
never send without approval
never make legal/medical/financial claims
never promise results
never change payment amounts
never override opt-outs
10. Success and Testing
10.1 What does success look like?

Examples:

leads followed up within 15 minutes
no missed form submissions
all leads logged in CRM
duplicates reduced
team notified instantly
errors visible
manual work reduced
10.2 How should we test the workflow?

List 3-6 test cases.

Examples:

Valid form submission
Missing email
Duplicate contact
Low-confidence AI result
Tool/API failure
Manual review
10.3 Anything else we should know?

Add any context, edge cases, preferences, or concerns.

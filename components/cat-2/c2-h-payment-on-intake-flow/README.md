# C2-H - Payment-on-Intake Flow

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Prepares provider-agnostic payment request handoffs for payment links, invoices, manual payment instructions, and payment review workflows.

C2-H v1 does not directly charge cards, collect money, create live payment links, create live invoices, or call payment provider APIs. It prepares structured payment request objects and downstream provider/manual handoff objects.

## Architecture
C2-H contains one n8n workflow:

1. `C2-H_CORE_Payment_On_Intake_Flow_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `prepare_payment_request`.
   - Requires provider, mode, and payment type.
   - Requires amount and currency.
   - Supports approval-required gating.
   - Supports allowed currency gating.
   - Supports allowed payment type gating.
   - Supports Razorpay payment link handoff.
   - Supports Stripe payment link handoff.
   - Supports PayPal invoice handoff.
   - Supports Wise/manual payment instruction handoff.
   - Supports manual payment review.
   - Does not call payment APIs directly.

## Workflow Files
- `workflows/c2-h-core-payment-on-intake-flow-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- Edit Fields / Set node

## Input Contract

```json
{
  "input": {
    "success": true,
    "component_id": "",
    "component_version": "",
    "event_id": "",
    "event_type": "approved_payment_request",
    "payload": {
      "customer_name": "",
      "customer_email": "",
      "customer_phone": "",
      "company": "",
      "amount": 0,
      "currency": "",
      "description": "",
      "reference_id": ""
    },
    "approved_action": {
      "approved": true,
      "action": "prepare_payment_request"
    },
    "metadata": {},
    "error": null,
    "next_action": "prepare_payment_request"
  },
  "config": {
    "provider": "razorpay",
    "mode": "payment_link_handoff",
    "payment_type": "advance_payment",
    "requires_approval": true,
    "approval_status_required": true,
    "allowed_currencies": [],
    "allowed_payment_types": [],
    "payment_terms": {
      "due_in_days": 7,
      "allow_partial_payment": false,
      "send_reminder": true
    },
    "manual_payment_instructions": {},
    "reviewer_email": "",
    "default_next_action": "create_payment_provider_handoff"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-H",
  "component_version": "v1",
  "event_id": "",
  "event_type": "approved_payment_request",
  "payment_request": {
    "provider": "",
    "mode": "",
    "status": "ready",
    "payment_type": "",
    "amount": 0,
    "currency": "",
    "description": "",
    "reference_id": "",
    "customer": {
      "name": "",
      "email": "",
      "phone": "",
      "company": ""
    },
    "payment_terms": {
      "due_in_days": 7,
      "due_at": "",
      "allow_partial_payment": false,
      "send_reminder": true
    },
    "requires_approval": true,
    "approval_status_required": true,
    "prepared_at": ""
  },
  "provider_handoff": {
    "next_component": "",
    "input": {},
    "config": {}
  },
  "manual_review_handoff": {
    "next_component": "C5-E",
    "input": {},
    "config": {}
  },
  "source_result": {},
  "error": null,
  "next_action": "create_payment_provider_handoff"
}
Providers Supported in v1
razorpay
stripe
paypal
wise
manual
Modes Supported in v1
payment_link_handoff
invoice_handoff
manual_payment_handoff
manual_review
Payment Types Supported in v1
advance_payment
full_payment
deposit
invoice_payment
manual_transfer
Provider / Mode Rules
Provider    Supported Mode    Output
razorpay    payment_link_handoff    Razorpay payment adapter handoff
stripe    payment_link_handoff    Stripe payment adapter handoff
paypal    invoice_handoff    PayPal payment adapter handoff
wise    manual_payment_handoff    Wise/manual payment instruction handoff
manual    manual_review    C5-E manual payment review handoff
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
PAYMENT_NOT_REQUESTED
MISSING_PROVIDER
MISSING_MODE
MISSING_PAYMENT_TYPE
UNSUPPORTED_PROVIDER
UNSUPPORTED_MODE
UNSUPPORTED_PAYMENT_TYPE
PAYMENT_TYPE_NOT_ALLOWED
PAYMENT_NOT_APPROVED
MISSING_OR_INVALID_AMOUNT
MISSING_CURRENCY
MISSING_CUSTOMER_EMAIL
CURRENCY_NOT_ALLOWED
INVALID_PROVIDER_MODE
Test Payloads
test-payloads/razorpay-payment-link.valid.json
test-payloads/stripe-payment-link.valid.json
test-payloads/paypal-invoice.valid.json
test-payloads/wise-manual-payment.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/payment-not-requested.invalid.json
test-payloads/missing-provider.invalid.json
test-payloads/missing-amount.invalid.json
test-payloads/not-approved.invalid.json
test-payloads/currency-not-allowed.invalid.json
Output Samples
output-samples/success-razorpay-payment-link.json
output-samples/success-stripe-payment-link.json
output-samples/success-paypal-invoice.json
output-samples/success-wise-manual-payment.json
output-samples/error-upstream-action-failed.json
output-samples/error-payment-not-requested.json
output-samples/error-missing-provider.json
output-samples/error-missing-amount.json
output-samples/error-not-approved.json
output-samples/error-currency-not-allowed.json
Passed Tests
Razorpay payment link
Stripe payment link
PayPal invoice
Wise manual payment
Upstream failed
Payment not requested
Missing provider
Missing amount
Not approved
Currency not allowed
80/20 Interoperability Rule

The reusable 80% layer is the payment request preparation engine: input validation, provider/mode validation, approval gating, amount/currency checks, allowed currency enforcement, payment type enforcement, provider payload construction, provider handoff creation, and manual review handoff creation. The configurable 20% layer is provider, mode, amount, currency, payment type, payment terms, provider adapter target, manual payment instructions, reviewer, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic payment handoff preparation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using routers, filters, payment-provider modules, HTTP modules, and manual approval paths.

Zapier

Can be rebuilt using Paths, Webhooks, Stripe/PayPal actions, and manual review steps.

Not Included

These are intentionally excluded from C2-H v1 and belong to other components/adapters:

Actual Razorpay payment link creation -> future Razorpay adapter
Actual Stripe payment link/session creation -> future Stripe adapter
Actual PayPal invoice creation -> future PayPal adapter
Actual Wise transfer execution -> manual/provider process
Payment status tracking -> C5-W or future payment status component
Payment reminder notifications -> C2-I / C2-J / future reminder component
Draft approval packaging -> C4-M
Human approval request -> C2-O
Approval response capture -> C2-O2
Error logging -> C6-G
Version

v1.0

Last Tested

2026-05-25

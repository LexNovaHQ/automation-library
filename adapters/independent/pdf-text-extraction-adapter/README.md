# ADP-PDF - PDF Text Extraction Adapter

**Status:** Implemented; local import/runtime verification pending.

## Job
Extract embedded text from a digital PDF supplied as n8n binary data.

## Input
Incoming binary PDF in property `data` by default. Override with JSON field `binary_property` when needed.

## Implementation
Uses n8n's built-in `Extract from File` node with the PDF operation. The normalized adapter output returns extracted `text` plus source file metadata where available.

## Boundary
This is **not OCR**. Image-only/scanned PDFs should be routed through C4-T to an OCR-capable provider/manual-review path. Large or hostile PDFs can be memory intensive and should be bounded in client implementations.

# C6-D - Data Mapping Diagnostic

**Status:** Implemented; local verification pending.

## Purpose
Validates field mappings before data is sent to a CRM/API/database. It detects missing required sources, missing targets, and type mismatches while producing a mapped preview.

## Input
`source` plus `mapping[]` rules containing `source_path`, `target_path`, optional `type`, and optional `required`.

## Output
`mapping_status`, structured `issues[]`, and `mapped_preview`.

## Boundary
This component does not write to the destination. Use the destination adapter only after the mapping contract passes.

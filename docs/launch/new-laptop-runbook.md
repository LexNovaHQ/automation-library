# New Windows Laptop Runbook — Automation Library

## Phase 1 — Machine tools
Run `scripts/windows/bootstrap-01-machine.ps1` **as Administrator**.

It installs/updates:
- WSL2 + Ubuntu
- Docker Desktop
- Git
- GitHub CLI
- VS Code
- PowerShell 7
- Node.js LTS
- Python 3.14
- Windows Terminal

Restart Windows if WSL/Docker requests it. Launch Ubuntu once and create the Linux user. Launch Docker Desktop and confirm the WSL2 engine is running.

## Phase 2 — Project
Open PowerShell 7 and run the project bootstrap script. The default branch for this sprint is `sept-launch-full-build`.

The script:
- clones/updates the repo;
- creates a fresh local ignored `.env`;
- generates a new n8n encryption key;
- installs VS Code extensions;
- starts n8n through Docker;
- verifies the local toolchain.

## Phase 3 — First n8n login
Open `http://localhost:5678` and create the owner account if this is a fresh data volume.

## Phase 4 — Sandbox credentials
Configure only test/sandbox credentials first. Prioritize:
1. Google/Gmail/Sheets
2. HubSpot test account
3. Airtable test base
4. Slack test workspace
5. Groq/OpenAI-compatible API credential
6. Microsoft Graph test tenant/account if verifying OneDrive/Teams
7. Notion/Pipedrive/GoHighLevel only when verifying those adapters

Never commit credential values.

## Phase 5 — Import / compile
Run `scripts/windows/compile-import-library.ps1`.

The script imports reusable component/adapters, exports the local workflow database to resolve runtime IDs, compiles portable P0 template source files into `.build/compiled-templates`, imports the compiled templates, and restarts n8n.

## Phase 6 — Verification
Run deterministic component tests first, then provider sandbox tests. Capture expected outputs in the relevant `output-samples/` folders only after actual execution.

Promotion rule:
- `IMPLEMENTED` is not `BUILT`.
- Promote to `BUILT` only after import succeeds and applicable local/provider tests pass.

## Phase 7 — Final audit
After verification:
- rerun the repository audit scripts;
- update `audit/config/component-classification.csv`;
- regenerate audit reports;
- confirm no secrets in Git diff/history added by this sprint;
- confirm all P0 template source workflows compile and import;
- merge `sept-launch-full-build` into `main` only after the verification gate is clean.

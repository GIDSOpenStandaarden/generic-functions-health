# CLAUDE.md

## Project Overview

This is a FHIR R4 Implementation Guide (IG) for Generic Functions for Health (Gezondheid), targeting health/prevention use cases in the Netherlands. It is built with FHIR Shorthand (FSH) and the HL7 FHIR IG Publisher.

## Build

```bash
# Docker (preferred)
make builder   # first time only
make ig        # build the IG

# Local
./_updatePublisher.sh -y   # download IG publisher
./_genonce.sh              # build
```

Output goes to `output/`. Check `output/qa.html` for errors.

## Project Structure

- `sushi-config.yaml` — IG metadata, page definitions, menu, dependencies
- `ig.ini` — IG publisher configuration
- `input/fsh/` — FHIR Shorthand definitions (profiles, extensions, aliases)
- `input/pagecontent/` — Markdown pages (index, identity, authorization, data-storage, data-access, connecting-people, history)
- `input/images/` — Images for the IG
- `input/images-source/` — PlantUML diagram sources
- `Dockerfile` + `Makefile` — Docker-based build

## Key Architecture Decisions

- **Solid** pods for self-sovereign data storage
- **openEHR** as data layer within pods (FHIR is interface, not storage)
- **FHIR R4** as the interoperability interface, exposed via CapabilityStatement
- **Authorization** operates at two levels: the data owner grants **people** access (role-based or individual), then **applications** act on behalf of authorized people via SMART on FHIR
- **SMART on FHIR** for app launch (both interactive and long-lived connections)
- **Matrix** for communication (chat, messaging) and social/health networks (invite-based)
- **Verifiable Credentials** (OID4VCI/OID4VP) for identity attributes (not permissions)
- VCs are for **attributes**, not permissions — permissions change too frequently for VCs

## Conventions

- SPDX license headers on all files: `EUPL-1.2` for code, `CC-BY-SA-4.0` for content (.md)
- Dependencies: `nictiz.fhir.nl.r4.nl-core` and `nictiz.fhir.nl.r4.zib2020` (0.12.0-beta.4)
- Page template: Introduction → Problem Overview → Requirements → Solution Overview → Dutch Context
- Canonical URL: `http://gidsopenstandaarden.org/fhir/gfh`
- Package ID: `gids.nl.gfh`

## CI/CD

- GitHub Actions workflow in `.github/workflows/build_deploy.yml`
- Builds Docker image with GHA cache, builds IG, deploys to GitHub Pages (main), creates releases
- Version extracted from `sushi-config.yaml`

## Open Design Questions

- Where do person-level permissions live? (Matrix rooms, FHIR RelatedPerson/Consent, or custom authorization service)
- How does Matrix room/space membership map to data access permissions?
- Liveness of membership proofs (current vs historical)?

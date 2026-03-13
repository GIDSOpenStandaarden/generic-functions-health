<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.6.0] - 2026-03-13

### Changed

- Broadened scope from "Health (Gezondheid)" to "Wellbeing (Gezondheid en Welzijn)"
- Renamed package ID (`gids.nl.gfh` → `gids.nl.gfw`), canonical URL, and IG name
- Added terminology section to index: wellbeing, health promotion and prevention, citizen-driven, community-based, integrative
- Reframed index page around citizen-driven, community-based wellbeing context
- Updated all project docs (README, CLAUDE.md) with new naming and scope

## [0.5.0] - 2026-03-12

### Changed

- Connecting People: removed voice/video references, scope limited to text-based messaging

## [0.4.0] - 2026-03-11

### Changed

- Authorization: rewrote with three-layer model (VCs for attributes, person-level authorization with role-based and individual access, SMART on FHIR for app delegation)
- Merged Data Sharing and Module Launch into single Data Access page
- Renamed Networks to Connecting People, added communication (chat, messaging) as primary function alongside social network
- Rewrote index page: updated architecture overview, function table, and open questions to reflect current design

## [0.3.0] - 2026-03-11

### Fixed

- CI: removed build-cache volume mount that shadowed publisher.jar in Docker image
- CI: fixed artifact download paths in deploy-pages job

### Changed

- Identity: corrected PRS reference to Pseudonimiseringsdienst (pseudonymization service) with link to minvws/gfmodules-pseudoniemendienst

## [0.2.0] - 2026-03-11

### Added

- README.md, CLAUDE.md, CHANGELOG.md
- EUPL-1.2 and CC-BY-SA-4.0 license texts (REUSE-compliant)
- GitHub Actions workflow for build, GitHub Pages deployment, and releases

### Changed

- Revised architecture: Solid + openEHR (storage), FHIR R4 (interface), SMART on FHIR (app launch), Matrix (networks), VCs with OID4VCI/OID4VP (identity)
- Replaced HTI 2.0 with SMART on FHIR for module launch
- Identity: generic wallet approach (not MS Authenticator-specific), OID4VCI/OID4VP
- Authorization: three-layer model (CapabilityStatement, SMART scopes, relationship-based access)
- Data Storage: openEHR as clinical data layer, FHIR as interface (not storage)
- VCs used for attributes only, not permissions

## [0.1.0] - 2026-03-11

### Added

- Initial IG structure with build infrastructure (Docker, Makefile, IG Publisher scripts)
- SUSHI configuration with IG metadata, page definitions, and Nictiz dependencies
- Six generic function pages: Identity, Authorization, Data Storage, Data Sharing, Module Launch, Networks
- EUPL-1.2 and CC-BY-SA-4.0 licensing with SPDX headers

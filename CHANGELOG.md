<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

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

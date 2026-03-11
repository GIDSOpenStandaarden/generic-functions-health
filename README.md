<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden
SPDX-FileCopyrightText: 2026 Roland Groen

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Generic Functions for Health (Gezondheid) — FHIR Implementation Guide

This repository contains the FHIR Implementation Guide for **Generic Functions for Health** (Generieke Functies Gezondheid), published by Stichting GIDS Open Standaarden.

It defines the generic functions needed for digital health data exchange in the context of **health and prevention** — complementing the [Generic Functions for Healthcare (Zorg)](https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/) published by Stichting Nuts, which focuses on professional healthcare delivery.

## Generic Functions

| Function | Description | Building Blocks |
|---|---|---|
| Identity | Anonymous/pseudonymous identity | VCs, OID4VCI, OID4VP, personal wallet |
| Authorization | Who in my network can access what parts of my health data | VCs (attributes), person-level permissions, SMART on FHIR (app delegation) |
| Data Storage | Self-sovereign storage with clinical data layer | Solid, openEHR, FHIR interface |
| Data Access | App connectivity, data ingestion, sharing, and portability | SMART on FHIR, FHIR Observations |
| Connecting People | Communication, social networks, and community building | Matrix |

## Local Development

### Prerequisites

- Docker installed on your system

### Build with Docker

Build the Docker image (first time only):

```bash
make builder
```

Build the Implementation Guide:

```bash
make ig
```

### Build without Docker

Requirements: Java 21+, Node.js 20+, Jekyll, [SUSHI](https://fshschool.org/docs/sushi/installation/)

```bash
# Download the IG Publisher
./_updatePublisher.sh -y

# Build the IG
./_genonce.sh
```

### View the Results

After the build completes:

- Open `output/index.html` in a web browser to view the IG
- Check `output/qa.html` for validation results

## Licensing

This project uses two licenses depending on the nature of the file:

- **Code and logic** is licensed under **EUPL-1.2**. This applies to files that are executed, compiled, or processed as code, including FHIR Shorthand (`.fsh`) and PlantUML (`.plantuml`) files.
- **Content and knowledge** is licensed under **CC-BY-SA-4.0**. This applies to files that primarily carry documentation or informational content, including Markdown (`.md`) and image (`.png`) files.

Each file contains an SPDX header indicating its applicable license. When in doubt, consider whether the file contains logic (EUPL-1.2) or content (CC-BY-SA-4.0).

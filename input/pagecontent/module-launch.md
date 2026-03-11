<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Module Launch function describes how health applications and intervention modules can be launched in a privacy-aware manner. This enables a portal or platform to launch specific health tools (e.g., a questionnaire, a coaching module, a self-management app) while passing the necessary context without exposing the user's identity.

### Problem Overview

In healthcare, application launch is handled through standards like SMART on FHIR, which passes an EHR context (patient, encounter, practitioner) to the launched application. However:

- **SMART on FHIR assumes healthcare context**: It requires a FHIR server, patient context, and typically an EHR session
- **Identity exposure**: Standard launch mechanisms pass patient identifiers, which is inappropriate in anonymous prevention contexts
- **No modular architecture**: Prevention platforms need to integrate modules from different providers without tight coupling
- **Privacy risk**: Launching a mental health tool should not expose the user's identity to the module provider unless explicitly consented

#### Requirements

- Module launch MUST be privacy-aware: user identity is not exposed by default
- Module launch MUST support passing context (e.g., task identifier, session token) without civil identity
- Module launch SHOULD support launching web-based modules in an iframe or new window
- Module launch MUST support the HTI 2.0 protocol
- Module launch SHOULD allow the launched module to request additional permissions if needed

### Solution Overview

Health module launch uses the **HTI 2.0 (Health Tool Interoperability)** protocol, developed by GIDS Open Standaarden:

#### HTI 2.0 Protocol

HTI 2.0 enables a **portal** (launching application) to launch a **module** (target application) with the following properties:

1. **Privacy by design**: The launch token contains only the information needed by the module — typically a task identifier and activity definition, not a person identifier
2. **JWT-based**: The launch context is encoded as a signed JWT (JSON Web Token), ensuring integrity and authenticity
3. **Stateless**: The module does not need to call back to the portal to validate the launch; the JWT is self-contained
4. **Modular**: Any HTI-compliant module can be launched from any HTI-compliant portal

#### Launch Flow

1. The **portal** creates an HTI launch token (JWT) containing:
   - Task identifier (reference to the activity being performed)
   - Activity definition (what the module should do)
   - Optional: pseudonymous user reference
2. The portal **redirects** the user to the module's launch URL with the token
3. The **module** validates the JWT signature and extracts the context
4. The module **performs its function** (e.g., presents a questionnaire, starts a coaching session)
5. Upon completion, the module can **report results** back through the task mechanism

#### Integration with Other Functions

- **Identity**: HTI launch tokens can include Verifiable Credential references for additional context without revealing identity
- **Data Storage**: Modules can read from and write to the user's Solid pod (with appropriate authorization)
- **Networks**: Modules can be launched from within Matrix rooms for community-based activities

### Dutch Context

- **HTI standard**: HTI is a Dutch standard developed by GIDS Open Standaarden, specifically designed for the mental health and prevention domain. The [HTI 2.0 specification](https://github.com/GIDSOpenStandaarden/GIDS-HTI-Protocol/blob/main/HTI_2.0.md) is publicly available.
- **GGZ and prevention**: HTI originated in the Dutch mental health sector (GGZ) for launching e-health modules. Its privacy-preserving properties make it equally suitable for broader prevention use cases.
- **SMART on FHIR interop**: For scenarios where a person transitions to healthcare, HTI launch contexts can be mapped to SMART on FHIR launch parameters.

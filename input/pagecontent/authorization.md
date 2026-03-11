<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Authorization function describes how access to health data and services is controlled in the prevention context. Unlike healthcare authorization — which relies on organizational trust frameworks, professional roles, and treatment relationships — health authorization is driven by the individual user.

### Problem Overview

In healthcare, authorization is managed through:

- **Organizational trust**: Healthcare providers trust each other through the Nuts network, PKI certificates, and contractual agreements
- **Professional roles**: Access is granted based on UZI role codes and treatment relationships
- **Policy-based access control (PBAC)**: A custodian evaluates access requests against predefined policies

In the health/prevention context, these mechanisms are not available:

- There is no organizational trust framework between prevention coaches, community workers, and peer supporters
- There are no standardized professional roles for health/prevention workers
- The individual (not an organization) should be the primary authority over their own data
- Access decisions should be transparent and under user control

#### Requirements

- Authorization MUST be user-controlled: the individual decides who can access their data
- Authorization SHOULD support capability-based access tokens
- Authorization MUST support fine-grained access (e.g., share questionnaire responses but not wearable data)
- Authorization SHOULD be revocable at any time by the data subject
- Authorization MUST NOT depend on organizational trust frameworks

### Solution Overview

Health authorization uses a combination of:

- **User-controlled consent**: The individual explicitly grants access to specific data or services through their wallet or data pod interface
- **Capability-based tokens**: Access is represented as Verifiable Credentials that encode specific permissions (e.g., "may read questionnaire responses from Solid pod X")
- **Solid Web Access Control (WAC)**: For data stored in Solid pods, access control is managed through standard Solid ACL mechanisms, controlled by the pod owner

#### Authorization Flow

1. A service or person **requests access** to specific health data
2. The data owner **reviews the request** and decides to grant or deny access
3. If granted, an **access token or capability credential** is issued
4. The requester uses the token to **access the data** within the granted scope
5. The data owner can **revoke access** at any time

### Dutch Context

- **GDPR basis**: In prevention, the legal basis for data processing is typically consent (not treatment relationship as in healthcare). This requires explicit, informed, and revocable consent.
- **No VZVZ/Mitz equivalent**: The healthcare consent infrastructure (Mitz) does not cover prevention activities. Health authorization must be self-contained.
- **Interoperability with healthcare**: When a person transitions from prevention to care, authorization mechanisms should support handoff. For example, a person might grant their GP access to specific prevention data through a one-time consent mechanism.

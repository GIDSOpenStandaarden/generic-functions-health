<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Authorization function describes how access to health data is controlled. Each person's health data is stored in a Solid pod that exposes a FHIR interface (see [Data Storage](data-storage.html)). The central question is: **who gets access to which parts of this FHIR interface, and how are those permissions managed?**

### Problem Overview

In healthcare, authorization is managed through:

- **Organizational trust**: Healthcare providers trust each other through the Nuts network, PKI certificates, and contractual agreements
- **Professional roles**: Access is granted based on UZI role codes and treatment relationships
- **Policy-based access control (PBAC)**: A custodian evaluates access requests against predefined policies

In the health/prevention context, these mechanisms are not available:

- There is no organizational trust framework between prevention coaches, community workers, and peer supporters
- There are no standardized professional roles for health/prevention workers
- The individual (not an organization) should be the primary authority over their own data

#### Requirements

- Authorization MUST be user-controlled: the individual decides who can access their data
- Authorization MUST support fine-grained access (e.g., share wearable data but not questionnaire responses)
- Authorization SHOULD be revocable at any time by the data subject
- Authorization MUST NOT depend on organizational trust frameworks
- Verifiable Credentials SHOULD NOT be used for permissions (they are suited for attributes, not for frequently changing access rights)

### Solution Overview

Authorization operates at multiple layers:

#### Layer 1: FHIR CapabilityStatement

Each person's Solid pod exposes a FHIR interface with a [CapabilityStatement](https://www.hl7.org/fhir/capabilitystatement.html) that describes what capabilities are available. Different capabilities may have different authorization requirements. For example:

- A capability for writing wearable Observations may require a long-lived SMART on FHIR connection
- A capability for reading questionnaire responses may require explicit per-session consent

The CapabilityStatement is the **published contract** of what the pod's FHIR interface supports and under what conditions.

#### Layer 2: SMART on FHIR Scopes

Access to the FHIR interface is granted through [SMART on FHIR](https://smarthealthit.org/) app launch (see [Module Launch](module-launch.html)). SMART on FHIR uses OAuth 2.0 scopes to define what an application can do:

- `patient/Observation.read` — read observations
- `patient/Observation.write` — write observations
- `patient/QuestionnaireResponse.read` — read questionnaire responses

The pod owner approves these scopes during the SMART on FHIR authorization flow.

#### Layer 3: Relationship-Based Access

Beyond app-level authorization, person-to-person access must be managed. This is where the interaction between **Matrix membership** and **FHIR authorization** becomes relevant.

##### Open Question: Matrix Membership as Authorization Basis

A person's health-related social network is modeled in Matrix (see [Networks](networks.html)). Matrix rooms and spaces represent relationships: a peer support group, a coaching relationship, a family care circle. The question is whether Matrix membership can serve as a basis for FHIR authorization:

- Can membership in a Matrix room grant read access to specific FHIR resources on a person's pod?
- Can Matrix's cryptographic event signatures (each `m.room.member` event is ed25519-signed by the homeserver) serve as verifiable proof of a relationship?
- How do we handle the liveness problem — proving *current* membership rather than historical?

See [MSC3917](https://github.com/matrix-org/matrix-spec-proposals/pull/3917) for a proposal on user-level cryptographic proof of Matrix room membership.

##### Possible Approach: RelatedPerson

FHIR's [RelatedPerson](https://www.hl7.org/fhir/relatedperson.html) resource models relationships between a patient and another person (family member, caregiver, guardian). In the health context, this could be extended to model:

- A peer in a support group
- A prevention coach
- A family member involved in care

The RelatedPerson resource on the pod could be linked to a Matrix identity, and Solid's access control could grant permissions based on these relationships.

This is an **open design question** — the exact mechanism for translating social relationships (Matrix) into data access permissions (FHIR/Solid) is not yet defined.

### Dutch Context

- **GDPR basis**: In prevention, the legal basis for data processing is typically consent (not treatment relationship as in healthcare). This requires explicit, informed, and revocable consent.
- **No VZVZ/Mitz equivalent**: The healthcare consent infrastructure (Mitz) does not cover prevention activities. Health authorization must be self-contained.
- **Interoperability with healthcare**: When a person transitions from prevention to care, authorization mechanisms should support handoff. A person might grant their GP access to specific prevention data through the FHIR interface.

<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Authorization function describes how **people** are authorized to access another person's health data. This is distinct from how **applications** are authorized (which is handled by SMART on FHIR — see [Data Access](data-access.html)). The central question is: who in my network is allowed to see or modify what parts of my health data?

### Problem Overview

In healthcare, authorization is managed through:

- **Professional roles**: Access is granted based on UZI role codes and treatment relationships
- **Organizational trust**: Healthcare providers trust each other through PKI certificates and contractual agreements
- **Policy-based access control (PBAC)**: A custodian evaluates access requests against organizational policies

In the health/prevention context, these mechanisms are not available:

- There are no standardized professional roles for prevention coaches, community workers, or peer supporters
- There is no organizational trust framework — participants are individuals, not organizations
- The individual (not an organization) is the authority over their own data
- Authorization must work for people who may only be known through anonymous or pseudonymous identities (see [Identity](identity.html))

#### Requirements

- Authorization MUST be about authorizing **people**, not applications
- The data owner MUST be able to grant and revoke access to specific individuals or roles
- Authorization SHOULD support both role-based and individual assignment
- Authorization MUST NOT depend on organizational trust frameworks or professional registries
- The authorization model MUST work with anonymous/pseudonymous identities

### Solution Overview

Authorization in the health context operates in three layers:

#### Layer 1: Verifiable Credentials for Attributes

Before authorization decisions can be made, the system needs to know *who* is requesting access and *what attributes* they have. [Verifiable Credentials](identity.html) serve this purpose:

- A VC can attest that someone is a "certified prevention coach" or "registered volunteer"
- A VC can attest membership in a group or program
- VCs are **not used for permissions** — they answer "who are you?" not "what are you allowed to do?"

The distinction is important: attributes are relatively stable and issued by trusted parties. Permissions are personal, granular, and change frequently — they belong in an authorization system, not in a credential.

#### Layer 2: Person-Level Authorization

The core of health authorization is a **permission model that the data owner controls**. The data owner (the person whose health data is stored in a Solid pod) decides what other people can do with their data.

There are two complementary approaches:

##### Role-Based Access

Permissions are assigned to **roles** that correspond to relationship types in the person's network. For example:

| Role | Example Permissions |
|---|---|
| Family member | Read vital signs, read care plan |
| Coach | Read and write questionnaire responses, read vital signs |
| Peer (support group) | Read shared mood tracking data |
| GP | Read all health data (when transitioning to care) |

A person entering the network in a certain role (e.g., by being invited to a Matrix room designated as a "coaching" room) would receive the permissions associated with that role.

##### Individual Access

Permissions are assigned to **specific individuals** regardless of role. For example:

- "My brother can see my wearable measurements"
- "My neighbor can see my care plan"
- "This specific coach can write to my questionnaire responses"

Individual access overrides or supplements role-based access — it is the most granular form of authorization.

In practice, both approaches will likely coexist: role-based defaults that can be refined with individual grants or restrictions.

#### Layer 3: Application Delegation via SMART on FHIR

Once a **person** is authorized, they may use an **application** to exercise their permissions. This is where SMART on FHIR comes in (see [Data Access](data-access.html)):

1. An authorized person opens an application via SMART on FHIR
2. The application acts **on behalf of** that person
3. The application can only do what the person is authorized to do
4. SMART on FHIR scopes constrain what the application can do within the person's authorization

This means the authorization chain is: **data owner grants permissions to a person** → **person launches an application** → **application acts on behalf of that person within their permissions**.

### Open Question: Where Do Permissions Live?

The permission model requires some system or data structure that stores: "person X is authorized to do Y with my data." Several options are under consideration:

#### Option A: Matrix Rooms as Permission Structure

Matrix rooms and spaces already represent relationships in the person's network (see [Connecting People](connecting-people.html)). Room membership could serve as the basis for authorization:

- A "coaching" room implies coaching-level permissions
- A "family" room implies family-level permissions
- Leaving a room revokes the associated permissions

**Advantages**: permissions are inherently tied to the social structure; no separate system to maintain.
**Challenges**: Matrix room membership is binary (member or not) — it does not natively support fine-grained permissions per member. The mapping from "room type" to "permission set" must be defined somewhere.

#### Option B: FHIR-Based Relational Data

Permissions could be stored as FHIR resources on the person's Solid pod. For example, using [RelatedPerson](https://www.hl7.org/fhir/relatedperson.html) to model relationships, combined with [Consent](https://www.hl7.org/fhir/consent.html) resources to express what each related person is allowed to do.

**Advantages**: standard FHIR resources; interoperable with healthcare systems; queryable through the FHIR interface.
**Challenges**: FHIR Consent is complex and designed for healthcare consent workflows — it may be over-engineered for this use case.

#### Option C: Custom Authorization Service

A dedicated authorization service on the Solid pod that maintains a permission table: who can do what. This could be a simple data structure:

| Subject (who) | Action (what) | Resource (on what) |
|---|---|---|
| @brother:matrix.org | read | Observation (vital signs) |
| @coach:health.nl | read, write | QuestionnaireResponse |
| role:family | read | CarePlan |

**Advantages**: simple, purpose-built, easy to understand and manage.
**Challenges**: non-standard; requires a custom UI for the data owner to manage permissions.

The choice between these options (or a combination) is an **open design question**.

### Dutch Context

- **GDPR basis**: In prevention, the legal basis for data processing is typically consent (not treatment relationship as in healthcare). The authorization model must support explicit, informed, and revocable consent by the data owner.
- **No VZVZ/Mitz equivalent**: The healthcare consent infrastructure (Mitz) does not cover prevention activities. Health authorization must be self-contained.
- **Interoperability with healthcare**: When a person transitions from prevention to care, the person-level authorization model should allow granting access to a healthcare provider (e.g., GP) through the same mechanism.

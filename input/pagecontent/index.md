<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

This is the Netherlands Generic Functions for Health (Gezondheid) Implementation Guide, published by Stichting GIDS Open Standaarden. It describes the generic functions needed for digital health data exchange in the context of **health** and **prevention** — as opposed to the [Generic Functions for Healthcare (Zorg)](https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/) published by Stichting Nuts, which focuses on professional healthcare delivery.

### Health vs Healthcare

The Dutch healthcare system has established a set of Generic Functions (Generieke Functies) for data exchange between healthcare providers. These functions — covering identification, authentication, authorization, localization, and consent — assume an environment of:

- **Identified patients** with a BSN (Burgerservicenummer)
- **Professional identities** verified through UZI certificates or Dezi
- **Organizational trust** between healthcare providers
- **Legal frameworks** such as the WGBO and Wabvpz

However, when we shift focus from **healthcare** (zorg) to **health** (gezondheid) — particularly in the domain of prevention — these assumptions no longer hold. People engaging in prevention activities:

- May not yet be patients and have no reason to share their BSN
- Interact with coaches, community workers, and peers — not just healthcare professionals
- Want to control their own data without relying on organizational infrastructure
- Need both public community support and private, confidential interactions

This Implementation Guide defines the generic functions needed for this health/prevention context.

### Architecture Overview

The architecture is built on the following layers:

1. **Identity** is managed through [Verifiable Credentials](https://www.w3.org/TR/vc-data-model-2.0/) (VCs), issued and presented via [OID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) and [OID4VP](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html), held in a personal wallet. VCs attest to **attributes** (e.g., "participant in program X") — not permissions.
2. **Data storage** uses [Solid](https://solidproject.org/) pods for self-sovereign storage, with [openEHR](https://www.openehr.org/) as the clinical data layer within the pod. Data is exposed through a **FHIR R4 interface**, not stored as FHIR.
3. **Authorization** operates at two levels: **people** are authorized by the data owner to access specific health data (role-based or individually), and **applications** are then authorized via [SMART on FHIR](https://smarthealthit.org/) to act on behalf of those people.
4. **Data access** uses SMART on FHIR for application connectivity — both interactive (short-term) and persistent (long-term via refresh tokens). This covers app launch, wearable data ingestion, data sharing, and portability.
5. **Connecting people** uses the [Matrix](https://matrix.org/) protocol for communication (chat, messaging) and for building invite-based social networks around health and prevention.

### Generic Functions for Health

This IG describes the following generic functions:

| Function | Description | Building Blocks |
|---|---|---|
| [Identity](identity.html) | Anonymous/pseudonymous identity via Verifiable Credentials | VCs, OID4VCI, OID4VP, personal wallet |
| [Authorization](authorization.html) | Who in my network can access what parts of my health data | VCs (attributes), person-level permissions, SMART on FHIR (app delegation) |
| [Data Storage](data-storage.html) | Self-sovereign data storage with clinical data layer | Solid, openEHR, FHIR R4 interface |
| [Data Access](data-access.html) | App connectivity, data ingestion, sharing, and portability | SMART on FHIR, FHIR Observations |
| [Connecting People](connecting-people.html) | Communication, social networks, and community building | Matrix |

### Relationship to Healthcare Generic Functions

The healthcare Generic Functions IG defines functions for the professional healthcare domain. This health IG complements it by covering the prevention domain. Where healthcare GF relies on BSN, UZI, and organizational trust, health GF uses anonymous credentials, self-sovereign data, and community-based networks.

The two sets of generic functions can work together: when a person transitions from prevention to care (e.g., when a health concern requires medical attention), data can be handed off from the health context to the healthcare context through the FHIR interface and appropriate consent mechanisms.

### Open Questions

This IG is in **draft** status. Key open questions include:

- **Where do person-level permissions live?** Options under consideration: Matrix room membership as implicit permissions, FHIR resources (RelatedPerson/Consent), or a custom authorization service. See [Authorization](authorization.html).
- **How does Matrix membership map to data access?** Can membership in a Matrix room grant access to specific FHIR resources on a person's pod? How is leaving a room reflected in revoked access? See [Connecting People](connecting-people.html).
- **How are current memberships proven?** Proving *current* membership (not just historical) requires liveness mechanisms that are not yet standardized in Matrix.

### Dependencies

This IG depends on the following packages:

- [nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core/0.12.0-beta.4) version 0.12.0-beta.4
- [nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020/0.12.0-beta.4) version 0.12.0-beta.4

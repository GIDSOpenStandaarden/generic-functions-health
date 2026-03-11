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

The architecture is built on the following layered approach:

1. **Data storage** uses [Solid](https://solidproject.org/) pods for self-sovereign storage, with [openEHR](https://www.openehr.org/) as the clinical data layer within the pod.
2. **Data access** is exposed through a **FHIR R4 interface** on each pod, described by a FHIR CapabilityStatement. FHIR is used as the interoperability interface, not as the storage format.
3. **App connectivity** uses [SMART on FHIR](https://smarthealthit.org/) for app launch, giving applications short-term or long-term (via refresh tokens and Subscriptions) access to the FHIR API.
4. **Social networks** use the [Matrix](https://matrix.org/) protocol for invite-based public and private health communities.
5. **Identity** is managed through Verifiable Credentials with [OID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) and [OID4VP](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html), held in a personal wallet.

### Generic Functions for Health

This IG describes the following generic functions:

| Function | Description | Building Blocks |
|---|---|---|
| [Identity](identity.html) | Anonymous/pseudonymous identity via Verifiable Credentials | VCs, OID4VCI, OID4VP, personal wallet |
| [Authorization](authorization.html) | Permissions on personal FHIR interfaces | FHIR CapabilityStatement, Matrix membership |
| [Data Storage](data-storage.html) | Self-sovereign data storage with clinical data layer | Solid, openEHR, FHIR interface |
| [Data Sharing](data-sharing.html) | Sharing wearable and self-measurement data | FHIR Observations, SMART on FHIR |
| [Module Launch](module-launch.html) | App launch and API access | SMART on FHIR |
| [Networks](networks.html) | Public and private social/health networks | Matrix |

### Relationship to Healthcare Generic Functions

The healthcare Generic Functions IG defines functions for the professional healthcare domain. This health IG complements it by covering the prevention domain. Where healthcare GF relies on BSN, UZI, and organizational trust, health GF uses anonymous credentials, self-sovereign data, and community-based networks.

The two sets of generic functions can work together: when a person transitions from prevention to care (e.g., when a health concern requires medical attention), data can be handed off from the health context to the healthcare context through the FHIR interface and appropriate consent mechanisms.

### Open Questions

This IG is in **draft** status. Key open questions include:

- How does Matrix room/space membership translate into permissions on a person's FHIR interface?
- What is the role of FHIR resources like RelatedPerson in modeling access control on Solid pods?
- How do we handle the liveness problem (proving *current* membership, not just historical)?

### Dependencies

This IG depends on the following packages:

- [nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core/0.12.0-beta.4) version 0.12.0-beta.4
- [nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020/0.12.0-beta.4) version 0.12.0-beta.4

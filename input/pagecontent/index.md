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

### Generic Functions for Health

This IG describes the following generic functions:

| Function | Description | Building Block |
|---|---|---|
| [Identity](identity.html) | Anonymous identity via Verifiable Credentials | MS Authenticator |
| [Authorization](authorization.html) | User-controlled access to health data | Verifiable Credentials |
| [Data Storage](data-storage.html) | Self-sovereign data storage | Solid |
| [Data Sharing](data-sharing.html) | Sharing wearable and self-measurement data | FHIR |
| [Module Launch](module-launch.html) | Privacy-aware module/app launch | HTI 2.0 |
| [Networks](networks.html) | Public and private social networks | Matrix |

### Relationship to Healthcare Generic Functions

The healthcare Generic Functions IG defines functions for the professional healthcare domain. This health IG complements it by covering the prevention domain. Where healthcare GF relies on BSN, UZI, and organizational trust, health GF uses anonymous credentials, self-sovereign data, and community-based networks.

The two sets of generic functions can work together: when a person transitions from prevention to care (e.g., when a health concern requires medical attention), data can be handed off from the health context to the healthcare context through appropriate consent and identification mechanisms.

### Conformance Expectations

This IG is in **draft** status. The functions described are based on existing open standards and building blocks (Solid, Matrix, HTI, Verifiable Credentials) but their specific application in the Dutch health/prevention context is still being defined.

### Dependencies

This IG depends on the following packages:

- [nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core/0.12.0-beta.4) version 0.12.0-beta.4
- [nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020/0.12.0-beta.4) version 0.12.0-beta.4

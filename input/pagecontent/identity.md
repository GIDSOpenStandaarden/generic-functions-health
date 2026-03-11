<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Identity function describes how individuals can participate in health and prevention activities without revealing their civil identity. In the healthcare domain, identity is established through BSN (Burgerservicenummer) and verified via DigID or professional UZI certificates. In the health/prevention domain, this approach is neither appropriate nor legally permitted for many use cases.

People engaging in prevention — such as lifestyle coaching, community health programs, or self-management of chronic conditions — need an identity that allows them to:

- Participate anonymously or pseudonymously
- Build a persistent profile across sessions without being personally identified
- Control what information they share and with whom

### Problem Overview

The current healthcare identity infrastructure does not fit the health/prevention context:

- **BSN is restricted**: The BSN may only be used by organizations with a legal basis (healthcare providers, government). Prevention coaches, community workers, and peer supporters typically do not have this legal basis.
- **DigID requires civil identity**: DigID authentication reveals the person's identity to the service provider, which is unnecessary and undesirable in many prevention contexts.
- **No professional registry**: Unlike healthcare professionals (who are registered in BIG/UZI), health coaches and community workers have no standardized identity framework.
- **Privacy by design**: Prevention activities should minimize data collection. Requiring identification where it is not needed violates the GDPR data minimization principle.

#### Requirements

- Identity MUST be privacy-preserving and not bound to a natural person's civil identity
- Identity SHOULD allow persistent pseudonymous participation across sessions
- Identity MUST be held in a personal wallet application
- Identity SHOULD support selective disclosure of attributes
- Identity MUST NOT require BSN or DigID for participation in prevention activities
- Verifiable Credentials SHOULD be used for attributes (e.g., "participant in program X"), not for permissions

### Solution Overview

The health identity function uses **Verifiable Credentials (VCs)** following the [W3C VC Data Model](https://www.w3.org/TR/vc-data-model-2.0/), issued and presented using the OpenID4VC protocol family:

- **[OID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html)** (OpenID for Verifiable Credential Issuance): Protocol for issuing VCs to a holder's wallet
- **[OID4VP](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html)** (OpenID for Verifiable Presentations): Protocol for presenting VCs to a verifier

These credentials are:

- **Attribute-based**: VCs attest to properties (e.g., "participant in program X", "resident of municipality Y") rather than granting permissions. Permissions change frequently and are better handled through other mechanisms (see [Authorization](authorization.html)).
- **Not person-bound**: The credential can be anonymous — it does not need to link to a civil identity.
- **Self-sovereign**: The individual holds the credential in their wallet and decides when and to whom to present it.
- **Verifiable**: Service providers can cryptographically verify the credential without contacting the issuer.
- **Selective disclosure**: Only the attributes needed for a specific interaction are shared.

#### Wallet

The personal wallet holds the user's Verifiable Credentials. Currently, [Microsoft Authenticator](https://www.microsoft.com/en-us/security/mobile-authenticator-app) supports the VC standards and can serve as a wallet. However, the architecture is not bound to a specific wallet implementation — any wallet supporting OID4VCI and OID4VP can be used.

The goal is to move towards a generic, interoperable wallet ecosystem as the market matures.

#### Flow

1. An **issuer** (e.g., a municipality, health program organizer) issues a Verifiable Credential to the participant's wallet via OID4VCI
2. The participant **presents** the credential when accessing a health service or joining a community via OID4VP
3. The **verifier** (service provider) checks the credential's validity and extracts only the needed attributes
4. No civil identity (BSN, name, date of birth) needs to be exchanged

### Dutch Context

- **BSN restrictions**: The BSN can only be processed by entities with an explicit legal basis. Most health/prevention services do not have this basis.
- **Persoonlijk Regelregister Samen (PRS)**: The upcoming PRS framework may provide additional mechanisms for user-controlled identity in health contexts.
- **Non-entitled individuals**: People without a BSN (undocumented persons, refugees) should still be able to participate in prevention activities. Anonymous VCs enable this.
- **European Digital Identity Wallet (EUDIW)**: The EU is developing a standardized digital identity wallet under eIDAS 2.0. This IG's approach is aligned with that direction.

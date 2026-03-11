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
- Identity MUST be compatible with Microsoft Authenticator as a wallet
- Identity SHOULD support selective disclosure of attributes
- Identity MUST NOT require BSN or DigID for participation in prevention activities

### Solution Overview

The health identity function uses **Verifiable Credentials (VCs)** issued and verified through **Microsoft Authenticator** (acting as a digital wallet). These credentials are:

- **Not person-bound**: The credential attests to properties (e.g., "participant in program X", "resident of municipality Y") without linking to a civil identity
- **Self-sovereign**: The individual holds the credential in their wallet and decides when and to whom to present it
- **Verifiable**: Service providers can cryptographically verify the credential without contacting the issuer
- **Selective disclosure**: Only the attributes needed for a specific interaction are shared

#### Flow

1. An **issuer** (e.g., a municipality, health program organizer) issues a Verifiable Credential to the participant's wallet (Microsoft Authenticator)
2. The participant **presents** the credential when accessing a health service or joining a community
3. The **verifier** (service provider) checks the credential's validity and extracts only the needed attributes
4. No civil identity (BSN, name, date of birth) needs to be exchanged

### Dutch Context

- **BSN restrictions**: The BSN can only be processed by entities with an explicit legal basis. Most health/prevention services do not have this basis.
- **Persoonlijk Regelregister Samen (PRS)**: The upcoming PRS framework may provide additional mechanisms for user-controlled identity in health contexts.
- **Non-entitled individuals**: People without a BSN (undocumented persons, refugees) should still be able to participate in prevention activities. Anonymous VCs enable this.
- **Microsoft Authenticator**: Chosen as the wallet technology because of its widespread availability and support for the Verifiable Credentials standards (W3C VC Data Model, OpenID4VC).

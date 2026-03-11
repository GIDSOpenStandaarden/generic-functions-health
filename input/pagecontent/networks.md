<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Networks function describes how the [Matrix](https://matrix.org/) protocol provides the social layer for health and prevention. Matrix enables people to build their health-related social network organically through invites — connecting with coaches, peers, family members, and community groups.

This social network serves a dual purpose: it provides **communication infrastructure** (chat, group discussions) and it represents the **social graph** of health relationships that can inform authorization decisions (see [Authorization](authorization.html)).

### Problem Overview

Current digital health solutions often treat health as an individual concern, but prevention is inherently social:

- **Isolation**: People dealing with health challenges often feel isolated. Digital tools that only offer individual tracking miss the social dimension.
- **Fragmented communication**: Health communities are scattered across WhatsApp groups, Facebook groups, and proprietary app chats — none of which offer adequate privacy, federation, or integration with health tools.
- **No privacy gradient**: Existing social platforms are either fully public or fully private. Prevention needs a gradient: public community spaces alongside private support groups and one-on-one conversations.
- **Platform dependency**: Communities built on commercial platforms are subject to those platforms' terms, algorithms, and business models.

#### Requirements

- Networks MUST support both public and private (invite-only) spaces
- Networks MUST support federated operation (no single point of control)
- Networks MUST support end-to-end encryption for private conversations
- Networks MUST be based on the invite model — relationships grow naturally
- Networks SHOULD support integration with other health functions (module launch, data sharing)
- Networks MUST be based on open standards

### Solution Overview

#### Matrix Architecture

- **Homeservers**: Each organization or community runs (or uses) a Matrix homeserver. Homeservers federate with each other, so users on different servers can communicate.
- **Spaces**: Matrix Spaces provide hierarchical organization — a municipality can have a health space containing rooms for different programs.
- **Rooms**: Individual chat rooms within spaces. Rooms can be:
  - **Public**: Discoverable and joinable by anyone (e.g., "Community Walking Group")
  - **Private**: Invite-only, for support groups or coaching sessions
  - **Encrypted**: End-to-end encrypted for sensitive conversations
- **Users**: Users join with their Matrix account, which can be pseudonymous (aligned with the [Identity](identity.html) function)

#### Invite-Based Growth

The Matrix model is fundamentally invite-based. A person's health network grows naturally:

1. A municipality **invites** residents to a public health space
2. A coach **invites** a participant to a private coaching room
3. A peer **invites** another peer to a support group
4. A family member is **invited** to a care circle

This organic growth creates a social graph that reflects real health relationships. Because invites require mutual consent, the network can be considered secure in a social sense.

#### Use Cases

| Scenario | Matrix Feature | Privacy Level |
|---|---|---|
| Municipal health program | Public space with topic rooms | Public |
| Peer support group | Private, invite-only room | Private |
| Coaching session | 1-on-1 encrypted room | Confidential |
| Community events | Public room with announcements | Public |
| Family care circle | Private room with shared data access | Private |
| Group intervention | Private room with SMART on FHIR app launch | Private |

#### Cryptographic Properties of Membership

Every Matrix event — including membership events (`m.room.member`) — is cryptographically signed by the originating homeserver using ed25519. This means:

- A membership event (join, invite, leave) is a **signed statement** by the homeserver
- Homeserver public keys are discoverable at `/_matrix/key/v2/server`
- Third parties can **verify signatures** against these public keys

However, current signatures only prove the **homeserver** signed the event, not that the **user** consented. [MSC3917](https://github.com/matrix-org/matrix-spec-proposals/pull/3917) proposes user-level cryptographic proof of membership through a Room Signing Key.

##### Open Question: Membership as Authorization

The relationship between Matrix membership and FHIR interface authorization is an open design question:

- Can membership in a specific Matrix room grant access to specific FHIR resources on a person's pod?
- How is this mapping configured and maintained?
- How do we ensure that leaving a room immediately revokes access?

See [Authorization](authorization.html) for further discussion.

#### Integration with Other Functions

- **Identity**: Matrix accounts are linked to anonymous/pseudonymous identities via Verifiable Credentials
- **Module Launch**: SMART on FHIR apps can be launched from within Matrix rooms
- **Data Sharing**: Participants can share health data through the FHIR interface, with Matrix membership informing access decisions
- **Authorization**: Room/space membership represents relationships that may translate into data access permissions

### Dutch Context

- **Municipal health programs**: Dutch municipalities (gemeenten) are responsible for prevention under the Wmo and public health legislation. Matrix spaces can support these programs digitally.
- **Federation**: Different municipalities and organizations can run their own Matrix homeservers while still enabling cross-organizational communication.
- **Privacy legislation**: Matrix's end-to-end encryption and federation model align with GDPR requirements for data protection and data minimization.
- **Existing infrastructure**: Several Dutch organizations already use Matrix (Element) for secure communication.

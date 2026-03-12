<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Connecting People function describes how the [Matrix](https://matrix.org/) protocol provides both **communication** and the **social layer** for health and prevention. Matrix enables people to chat, exchange messages, and build their health-related social network through invites — connecting with coaches, peers, family members, and community groups.

Matrix serves a dual purpose:

1. **Communication**: Real-time messaging, group chat, file sharing, and encrypted conversations between people in someone's health network.
2. **Social graph**: The network of rooms, spaces, and memberships represents the social relationships that can inform authorization decisions (see [Authorization](authorization.html)).

### Problem Overview

Prevention is inherently social — yet current digital health tools treat it as an individual concern:

- **Isolation**: People dealing with health challenges often feel isolated. Digital tools that only offer individual tracking miss the social dimension.
- **Fragmented communication**: Health communities communicate through WhatsApp groups, Facebook groups, and proprietary app chats — none of which offer adequate privacy, federation, or integration with health tools.
- **No privacy gradient**: Existing platforms are either fully public or fully private. Prevention needs a gradient: public community spaces alongside private support groups and confidential one-on-one conversations.
- **Platform dependency**: Communities built on commercial platforms are subject to those platforms' terms, algorithms, and business models.
- **No integration with health data**: Chat platforms are disconnected from health tools — a coach cannot launch a questionnaire or view shared health data from within the conversation.

#### Requirements

- Communication MUST support real-time messaging, group chat, and file sharing
- Communication MUST support end-to-end encryption for private and confidential conversations
- Networks MUST support both public and private (invite-only) spaces
- Networks MUST support federated operation (no single point of control)
- Networks MUST be based on the invite model — relationships grow naturally
- Networks SHOULD support integration with health tools (app launch, data access)
- Networks MUST be based on open standards

### Solution Overview

#### Matrix as Communication Platform

Matrix is a federated, open-standard communication protocol. At its core, it provides:

- **Real-time messaging**: One-on-one and group chat with rich text, images, and file attachments
- **Threads and topics**: Organized discussions within rooms
- **End-to-end encryption**: Confidential conversations that even the homeserver cannot read
- **Message history**: Persistent chat history so participants can catch up at their own pace
- **Notifications**: Configurable alerts for new messages and updates

This makes Matrix suitable for the full range of health communication: a peer asking how someone is doing, a coach scheduling a session, a community organizer posting an event, or a family member coordinating care.

#### Matrix as Social Network

Beyond communication, the structure of Matrix rooms and spaces represents the person's health-related social network:

- **Homeservers**: Each organization or community runs (or uses) a Matrix homeserver. Homeservers federate with each other, so users on different servers can communicate.
- **Spaces**: Matrix Spaces provide hierarchical organization — a municipality can have a health space containing rooms for different programs.
- **Rooms**: Individual rooms within spaces. Rooms can be:
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

| Scenario | Communication | Network | Privacy Level |
|---|---|---|---|
| Municipal health program | Community announcements, Q&A | Public space with topic rooms | Public |
| Peer support group | Group chat, shared experiences | Private, invite-only room | Private |
| Coaching session | 1-on-1 encrypted chat | Encrypted room | Confidential |
| Community events | Event announcements, RSVPs | Public room | Public |
| Family care circle | Coordinating care, sharing updates | Private room with shared data access | Private |
| Group intervention | Discussion, launching health apps | Private room with SMART on FHIR integration | Private |

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
- **Data Access**: SMART on FHIR apps can be launched from within Matrix rooms; participants can share health data through the FHIR interface, with Matrix membership informing access decisions
- **Authorization**: Room/space membership represents relationships that may translate into data access permissions

### Dutch Context

- **Municipal health programs**: Dutch municipalities (gemeenten) are responsible for prevention under the Wmo and public health legislation. Matrix spaces can support these programs digitally with both communication and community building.
- **Federation**: Different municipalities and organizations can run their own Matrix homeservers while still enabling cross-organizational communication.
- **Privacy legislation**: Matrix's end-to-end encryption and federation model align with GDPR requirements for data protection and data minimization.
- **Existing infrastructure**: Several Dutch organizations already use Matrix (Element) for secure communication.

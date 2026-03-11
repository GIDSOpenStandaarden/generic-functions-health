<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Networks function describes how public and private social networks support health and prevention activities. Social connection and community support are essential for prevention — whether it's a peer support group for chronic condition self-management, a community walking group, or a municipality-organized health program.

### Problem Overview

Current digital health solutions often treat health as an individual concern, but prevention is inherently social:

- **Isolation**: People dealing with health challenges (obesity, mental health, chronic conditions) often feel isolated. Digital tools that only offer individual tracking miss the social dimension.
- **Fragmented communication**: Health communities are scattered across WhatsApp groups, Facebook groups, and proprietary app chats — none of which offer adequate privacy, federation, or integration with health tools.
- **No privacy gradient**: Existing social platforms are either fully public (social media) or fully private (messaging). Prevention needs a gradient: public community spaces alongside private support groups and one-on-one conversations.
- **Platform dependency**: Communities built on commercial platforms are subject to those platforms' terms, algorithms, and business models.

#### Requirements

- Networks MUST support both public and private (invite-only) spaces
- Networks MUST support federated operation (no single point of control)
- Networks MUST support end-to-end encryption for private conversations
- Networks SHOULD support integration with other health functions (module launch, data sharing)
- Networks MUST be based on open standards

### Solution Overview

Health networking uses the **Matrix** protocol (matrix.org) — an open, federated communication protocol:

#### Matrix Architecture

- **Homeservers**: Each organization or community runs (or uses) a Matrix homeserver. Homeservers federate with each other, so users on different servers can communicate.
- **Spaces**: Matrix Spaces provide hierarchical organization — a municipality can have a health space containing rooms for different programs.
- **Rooms**: Individual chat rooms within spaces. Rooms can be:
  - **Public**: Discoverable and joinable by anyone (e.g., "Community Walking Group")
  - **Private**: Invite-only, for support groups or coaching sessions
  - **Encrypted**: End-to-end encrypted for sensitive conversations
- **Users**: Users join with their Matrix account, which can be pseudonymous (aligned with the Identity function)

#### Use Cases

| Scenario | Matrix Feature | Privacy Level |
|---|---|---|
| Municipal health program | Public space with topic rooms | Public |
| Peer support group | Private, invite-only room | Private |
| Coaching session | 1-on-1 encrypted room | Confidential |
| Community events | Public room with announcements | Public |
| Group intervention | Private room with module launch integration | Private |

#### Integration with Other Functions

- **Identity**: Matrix accounts are linked to anonymous Verifiable Credentials, not civil identities
- **Module Launch**: HTI modules can be launched from within Matrix rooms (e.g., a group questionnaire during a peer support session)
- **Data Sharing**: Participants can share health observations in rooms (with appropriate consent)
- **Authorization**: Room membership and roles provide basic authorization; fine-grained data access uses the Authorization function

### Dutch Context

- **Municipal health programs**: Dutch municipalities (gemeenten) are responsible for prevention under the Wmo and public health legislation. Matrix spaces can support these programs digitally.
- **Federation**: Different municipalities and organizations can run their own Matrix homeservers while still enabling cross-organizational communication.
- **Privacy legislation**: Matrix's end-to-end encryption and federation model align with GDPR requirements for data protection and data minimization.
- **Existing infrastructure**: Several Dutch organizations already use Matrix (Element) for secure communication. This IG builds on existing adoption.

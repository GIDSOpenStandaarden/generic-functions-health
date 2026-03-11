<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Data Access function describes how health applications and services connect to a person's FHIR interface to read and write health data. This covers how **applications connect** (via SMART on FHIR), how **data flows in** (ingestion from wearables and self-measurements), how **data flows out** (sharing with coaches, peers, and healthcare providers), and how **data moves** between systems (portability).

### Problem Overview

Health and prevention platforms need to integrate modules from different providers — questionnaire tools, coaching apps, wearable connectors, data visualization dashboards. At the same time, wearable devices and health apps generate valuable data that is typically siloed in vendor ecosystems.

Key challenges:

- **Application integration**: Launched apps need to know which FHIR server to connect to and what they are allowed to do
- **Short vs long-term access**: An interactive questionnaire needs access for minutes; a wearable connector needs access for months
- **Data silos**: Garmin, Apple Health, and Fitbit data stays locked in vendor ecosystems with proprietary formats
- **No standard sharing**: Even when a person wants to share wearable data with their coach or GP, there is no standard mechanism
- **Data portability**: Switching platforms or wearable brands means losing historical data

#### Requirements

- Application access MUST use the SMART on FHIR app launch framework
- Application access MUST support both standalone and EHR launch patterns
- Short-term access MUST use standard OAuth 2.0 authorization code flow
- Long-term access MUST use refresh tokens (offline_access scope)
- The FHIR server MUST publish a CapabilityStatement and SMART configuration
- Data ingestion MUST use the FHIR interface on the person's Solid pod
- Data sharing MUST be user-initiated and user-controlled
- Data sharing MUST support both real-time (Subscriptions) and batch transfer
- Data portability MUST be supported through standard FHIR Bundles

### Solution Overview

#### SMART on FHIR

[SMART on FHIR](https://smarthealthit.org/) (Substitutable Medical Applications, Reusable Technologies) provides a standardized way for apps to:

1. **Discover** the FHIR server's capabilities and authorization endpoints
2. **Request access** with specific OAuth 2.0 scopes
3. **Obtain tokens** after user approval
4. **Access FHIR resources** within the granted scope

The person's Solid pod acts as both the FHIR server and the OAuth 2.0 authorization server.

#### Launch Patterns

##### Interactive Launch (Short-Term)

For apps that need temporary access (e.g., filling out a questionnaire, viewing a dashboard):

1. User clicks to launch an app from a portal or Matrix room
2. The app discovers the pod's SMART configuration at `.well-known/smart-configuration`
3. The app redirects to the pod's authorization endpoint
4. The user reviews and approves the requested scopes
5. The app receives an access token (short-lived, e.g., 1 hour)
6. The app interacts with the FHIR interface until the token expires

##### Persistent Connection (Long-Term)

For apps that need ongoing access (e.g., wearable data connectors, monitoring dashboards):

1. User launches the connector app via SMART on FHIR
2. The app requests the `offline_access` scope
3. The user approves, granting long-term access
4. The app receives an access token and a **refresh token**
5. The app uses the refresh token to obtain new access tokens as needed
6. The connection persists until the user revokes it

#### Wearable Data Ingestion

Wearable data flows into the pod through the FHIR interface using a persistent SMART on FHIR connection:

1. The user **launches** a wearable connector app via SMART on FHIR
2. The app requests **long-term access** (offline_access scope) with a refresh token
3. The connector app periodically **pulls data** from the wearable vendor's API (e.g., Garmin Health API)
4. The connector **transforms** vendor-specific data into FHIR Observation resources
5. The connector **writes** Observations to the pod's FHIR interface

##### Supported Data Types

| Wearable Metric | FHIR Observation Code (LOINC) | Description |
|---|---|---|
| Heart Rate | 8867-4 | Instantaneous heart rate |
| Steps | 55423-8 | Number of steps per day |
| Body Weight | 29463-7 | Body weight measurement |
| Blood Pressure | 85354-9 | Systolic and diastolic |
| Sleep Duration | 93832-4 | Total sleep time |
| Stress Level | 96895-8 | Perceived stress score |

#### Sharing Data with Others

Once data is in the pod, sharing with coaches, peers, or healthcare providers is managed through:

1. **Authorization**: The data owner grants access to specific people (see [Authorization](authorization.html))
2. **SMART on FHIR delegation**: Authorized people use apps that act on their behalf within their permissions
3. **Subscriptions**: Connected parties can subscribe to updates (e.g., a coach receives new vital signs as they arrive)
4. **FHIR Bundles**: For bulk sharing or data portability, data can be exported as FHIR Bundles

#### FHIR Subscriptions

For real-time data flows, apps can use FHIR [Subscriptions](https://www.hl7.org/fhir/subscription.html) to receive notifications when data changes:

- A coaching app subscribes to new Observations on a client's pod
- A dashboard subscribes to CarePlan updates
- A peer support tool subscribes to shared mood tracking data

Subscriptions combined with long-term access tokens enable continuous, event-driven data flows.

#### Data Portability

Users can export their data from one platform and import it into another:

- **Export**: All data accessible through the FHIR interface can be exported as FHIR Bundles (JSON)
- **Import**: FHIR Bundles can be imported into any compliant system
- **Migration**: The Solid pod itself can be migrated to a new hosting provider

### Dutch Context

- **SMART on FHIR adoption**: SMART on FHIR is gaining adoption in the Netherlands through MedMij and Koppeltaal (which previously used HTI). Using SMART on FHIR aligns with this trajectory.
- **MedMij PGO**: SMART on FHIR is the standard launch mechanism for MedMij personal health environments (PGO), making the pod compatible with the existing PGO ecosystem.
- **FHIR R4 with nl-core**: Observations use the nl-core profiles where applicable, ensuring compatibility with Dutch healthcare systems.
- **MedMij information standards**: Where existing MedMij information standards cover the data types (e.g., vital signs), these are followed.
- **GDPR data portability**: The right to data portability (Article 20 GDPR) is directly supported through FHIR Bundle export.

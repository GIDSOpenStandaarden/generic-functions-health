<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Data Sharing function describes how health data — particularly data from wearable devices and self-measurements — flows into and out of a person's Solid pod through the FHIR interface. This covers both **ingestion** (getting data in) and **sharing** (giving others access).

### Problem Overview

Wearable devices and health apps generate large amounts of valuable health data (activity, heart rate, sleep, stress levels). However, this data is typically:

- **Siloed in vendor ecosystems**: Garmin data stays in Garmin Connect, Apple Health data stays on iPhone, Fitbit data stays in Google's ecosystem
- **Not in standard formats**: Each vendor uses proprietary data formats and APIs
- **Not shareable**: Even when a person wants to share wearable data with their GP or coach, there is no standard mechanism to do so
- **Not portable**: Switching from one wearable brand to another means losing historical data

#### Requirements

- Data ingestion MUST use the FHIR interface on the person's Solid pod
- Data sharing MUST be user-initiated and user-controlled
- Wearable connections SHOULD use long-lived access via SMART on FHIR refresh tokens
- Data sharing MUST support both real-time (Subscriptions) and batch transfer
- Data portability MUST be supported through standard FHIR Bundles

### Solution Overview

#### Wearable Data Ingestion

Wearable data flows into the pod through the FHIR interface using SMART on FHIR (see [Module Launch](module-launch.html)):

1. The user **launches** a wearable connector app via SMART on FHIR
2. The app requests **long-term access** (offline_access scope) with a refresh token
3. The connector app periodically **pulls data** from the wearable vendor's API (e.g., Garmin Health API)
4. The connector **transforms** vendor-specific data into FHIR Observation resources
5. The connector **writes** Observations to the pod's FHIR interface

For continuous data flows, FHIR [Subscriptions](https://www.hl7.org/fhir/subscription.html) can be used to notify connected apps of new data.

#### Supported Data Types

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

1. **SMART on FHIR scopes**: The data owner grants read access to specific resource types
2. **Subscriptions**: Connected parties can subscribe to updates (e.g., a coach receives new vital signs as they arrive)
3. **FHIR Bundles**: For bulk sharing or data portability, data can be exported as FHIR Bundles

See [Authorization](authorization.html) for how access decisions are made and how Matrix membership relates to sharing permissions.

#### Data Portability

Users can export their data from one platform and import it into another:

- **Export**: All data accessible through the FHIR interface can be exported as FHIR Bundles (JSON)
- **Import**: FHIR Bundles can be imported into any compliant system
- **Migration**: The Solid pod itself can be migrated to a new hosting provider

### Dutch Context

- **FHIR R4 with nl-core**: Observations use the nl-core profiles where applicable, ensuring compatibility with Dutch healthcare systems
- **MedMij information standards**: Where existing MedMij information standards cover the data types (e.g., vital signs), these are followed
- **GDPR data portability**: The right to data portability (Article 20 GDPR) is directly supported through FHIR Bundle export

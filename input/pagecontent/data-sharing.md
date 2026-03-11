<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Data Sharing function describes how health data — particularly data from wearable devices and self-measurements — can be shared between individuals, services, and healthcare providers. This includes data portability, interoperability, and user-controlled sharing.

### Problem Overview

Wearable devices and health apps generate large amounts of valuable health data (activity, heart rate, sleep, stress levels). However, this data is typically:

- **Siloed in vendor ecosystems**: Garmin data stays in Garmin Connect, Apple Health data stays on iPhone, Fitbit data stays in Google's ecosystem
- **Not in standard formats**: Each vendor uses proprietary data formats and APIs
- **Not shareable with healthcare**: Even when a person wants to share wearable data with their GP or coach, there is no standard mechanism to do so
- **Not portable**: Switching from one wearable brand to another means losing historical data or dealing with incompatible export formats

#### Requirements

- Data sharing MUST use standard formats (FHIR Observation resources)
- Data sharing MUST be user-initiated and user-controlled
- Data sharing SHOULD support common wearable data sources (Garmin, Apple Health, Fitbit, etc.)
- Data sharing MUST support both real-time and batch data transfer
- Data portability MUST be supported: users should be able to export and import their data

### Solution Overview

Health data sharing uses **FHIR Observations** as the common data format, with connectors for popular wearable platforms:

#### Wearable Data Integration

1. **Data collection**: Wearable devices collect health metrics (heart rate, steps, sleep, stress)
2. **API access**: The user authorizes access to their wearable data via the vendor's API (e.g., Garmin Health API)
3. **FHIR transformation**: A connector service transforms vendor-specific data into FHIR Observation resources
4. **Storage**: Transformed data is stored in the user's Solid pod
5. **Sharing**: The user can share specific observations with coaches, peers, or healthcare providers

#### Supported Data Types

| Wearable Metric | FHIR Observation Code (LOINC) | Description |
|---|---|---|
| Heart Rate | 8867-4 | Instantaneous heart rate |
| Steps | 55423-8 | Number of steps per day |
| Body Weight | 29463-7 | Body weight measurement |
| Blood Pressure | 85354-9 | Systolic and diastolic |
| Sleep Duration | 93832-4 | Total sleep time |
| Stress Level | 96895-8 | Perceived stress score |

#### Data Portability

Users can export their data from one platform and import it into another:

- **Export**: All data in the Solid pod can be exported as FHIR Bundles (JSON)
- **Import**: FHIR Bundles can be imported into any compliant system
- **Migration**: When switching services, the Solid pod itself can be migrated to a new host

### Dutch Context

- **FHIR R4 with nl-core**: Observations use the nl-core profiles where applicable, ensuring compatibility with Dutch healthcare systems
- **MedMij information standards**: Where existing MedMij information standards cover the data types (e.g., vital signs), these are followed
- **GDPR data portability**: The right to data portability (Article 20 GDPR) is directly supported through FHIR Bundle export

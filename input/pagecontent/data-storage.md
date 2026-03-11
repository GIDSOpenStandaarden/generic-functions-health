<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Data Storage function describes how health data is stored in a self-sovereign manner, giving individuals full control over their own health information. This covers questionnaire responses, self-assessments, care plans, and other health-related data generated in prevention contexts.

### Problem Overview

In healthcare, data is stored in Electronic Health Records (EHRs) managed by healthcare providers. The "data at the source" principle means each provider maintains their own data, and localization services (like the Nationale Verwijs Index) help find where data is stored.

In the health/prevention context, this model does not work:

- **No central registry**: There is no equivalent of an EHR for prevention data. Data is fragmented across apps, wearables, and paper records.
- **Vendor lock-in**: Health apps typically store data in proprietary cloud services, making it difficult for users to switch providers or aggregate their data.
- **No data portability**: Users cannot easily take their prevention data from one service to another.
- **User needs control**: Unlike healthcare data (which is legally managed by the provider), prevention data should be owned and controlled by the individual.

#### Requirements

- Data MUST be stored under the control of the individual ("data at the source" = the person)
- Data storage MUST support standard formats (FHIR R4 resources)
- Data MUST be portable between providers and services
- Data storage MUST support fine-grained access control
- Data storage SHOULD support FHIR Questionnaire and QuestionnaireResponse resources for structured data collection

### Solution Overview

Health data storage is based on **Solid** (Social Linked Data), a W3C standard for decentralized data storage:

- **Solid Pods**: Each individual has a personal data pod where their health data is stored. The pod can be hosted by a provider of their choice or self-hosted.
- **Linked Data**: Data is stored as Linked Data (RDF), enabling interoperability between different applications and services.
- **Standard protocols**: Solid uses standard web protocols (HTTP, LDP) for data access, making it accessible to any compliant application.
- **Access control**: Pod owners control who can read and write data through Solid's Web Access Control (WAC) or Access Control Policy (ACP) mechanisms.

#### Data Types

The following types of health data are stored in Solid pods:

| Data Type | FHIR Resource | Description |
|---|---|---|
| Questionnaire responses | QuestionnaireResponse | Answers to health assessments and screening tools |
| Self-measurements | Observation | Blood pressure, weight, mood scores, etc. |
| Care plans | CarePlan | Personal health goals and action plans |
| Appointments | Appointment | Scheduled sessions with coaches or peers |

#### FHIR Integration

While Solid uses Linked Data (RDF) as its native format, FHIR resources can be stored in and retrieved from Solid pods:

1. FHIR resources are serialized as JSON-LD (which is valid RDF)
2. Applications read and write FHIR resources using standard Solid protocols
3. The FHIR resource types provide a common data model understood by both health and healthcare applications

### Dutch Context

- **Data at the source**: The Dutch healthcare principle of "data at the source" is extended to mean data at the *person* rather than data at the *provider*.
- **FHIR R4**: The Netherlands has standardized on FHIR R4 with nl-core profiles. This IG reuses these profiles where applicable for questionnaires and observations.
- **MedMij**: The MedMij framework defines standards for personal health environments (PGO). Solid pods can function as a PGO-compatible data store.

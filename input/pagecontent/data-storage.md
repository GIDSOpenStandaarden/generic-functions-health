<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Data Storage function describes the layered approach to self-sovereign health data storage. The architecture separates concerns:

- **Solid** provides self-sovereign, decentralized storage
- **openEHR** provides the clinical data layer (archetypes, templates, structured health data)
- **FHIR** provides the interoperability interface for applications to read and write data

FHIR is used as an **interface standard**, not as a storage format. Health data is stored in openEHR's clinical models within a Solid pod and exposed through a FHIR R4 API.

### Problem Overview

In healthcare, data is stored in Electronic Health Records (EHRs) managed by healthcare providers. The "data at the source" principle means each provider maintains their own data.

In the health/prevention context, this model does not work:

- **No central registry**: There is no equivalent of an EHR for prevention data. Data is fragmented across apps, wearables, and paper records.
- **Vendor lock-in**: Health apps typically store data in proprietary cloud services, making it difficult for users to switch providers or aggregate their data.
- **FHIR is not a storage standard**: While FHIR excels at interoperability and data exchange, it is not designed as a data storage format. Its resource model does not capture the full clinical semantics needed for longitudinal health data.
- **User needs control**: Unlike healthcare data (which is legally managed by the provider), prevention data should be owned and controlled by the individual.

#### Requirements

- Data MUST be stored under the control of the individual ("data at the source" = the person)
- Data storage MUST use a clinically sound data model (openEHR)
- Data MUST be accessible through a standard FHIR R4 interface
- Data MUST be portable between providers and services
- The FHIR interface MUST publish a CapabilityStatement describing available interactions

### Solution Overview

#### Solid Pods

Each individual has a personal [Solid](https://solidproject.org/) pod where their health data is stored. The pod can be hosted by a provider of their choice or self-hosted. Solid provides:

- **Decentralized storage**: No single point of control or failure
- **Standard protocols**: Solid uses standard web protocols (HTTP, LDP) for data access
- **Access control**: Pod owners control who can read and write data through Solid's access control mechanisms
- **Data portability**: Pods can be migrated between hosting providers

#### openEHR Data Layer

Within the Solid pod, health data is structured using [openEHR](https://www.openehr.org/):

- **Archetypes**: Reusable clinical data models that capture the semantics of health concepts (blood pressure, body weight, questionnaire responses)
- **Templates**: Compositions of archetypes for specific use cases
- **Two-level modeling**: Separation of reference model (stable) from clinical knowledge (evolving), enabling the data layer to evolve without breaking storage

openEHR is well-suited as a storage layer because it was designed for longitudinal health records with full clinical context, versioning, and audit trails.

#### FHIR Interface

The Solid pod exposes a **FHIR R4 API** that translates between the openEHR data layer and FHIR resources. This interface:

- Publishes a **CapabilityStatement** describing what FHIR interactions are available
- Supports standard FHIR operations (read, search, create, update)
- Can support different capability profiles for different use cases

#### CapabilityStatement as Contract

The FHIR CapabilityStatement on each pod serves as the **published contract** of what the pod offers. Different pods may expose different capabilities depending on the user's needs. Examples:

| Capability | FHIR Resources | Use Case |
|---|---|---|
| Wearable data ingestion | Observation (write) | Receiving data from connected wearables |
| Questionnaire responses | Questionnaire, QuestionnaireResponse (read/write) | Health assessments and screening tools |
| Care plans | CarePlan (read/write) | Personal health goals and action plans |
| Vital signs sharing | Observation (read) | Sharing vital signs with a coach or GP |

An IG can define FHIR profiles and a CapabilityStatement for a specific capability, with its own authentication and authorization logic. This makes the system modular: new capabilities can be added by publishing new IGs.

### Dutch Context

- **Data at the source**: The Dutch healthcare principle of "data at the source" is extended to mean data at the *person* rather than data at the *provider*.
- **FHIR R4**: The Netherlands has standardized on FHIR R4 with nl-core profiles. The FHIR interface reuses these profiles where applicable.
- **openEHR in NL**: openEHR is gaining adoption in the Netherlands, particularly for longitudinal health records and clinical data repositories.
- **MedMij**: The MedMij framework defines standards for personal health environments (PGO). A Solid pod with a FHIR interface can function as a PGO-compatible data store.

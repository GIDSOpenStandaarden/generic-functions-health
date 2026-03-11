<!--
SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden

SPDX-License-Identifier: CC-BY-SA-4.0
-->

### Introduction

The Module Launch function describes how health applications connect to a person's FHIR interface using **SMART on FHIR**. This covers both interactive app launches (e.g., opening a questionnaire tool) and long-lived connections (e.g., a wearable data connector that syncs data over weeks or months).

### Problem Overview

Health and prevention platforms need to integrate modules from different providers: questionnaire tools, coaching apps, wearable connectors, data visualization dashboards. These modules need access to the person's health data through the FHIR interface on their Solid pod.

Key challenges:

- **Context passing**: The launched app needs to know which FHIR server to connect to and what it is allowed to do
- **Short vs long-term access**: An interactive questionnaire needs access for minutes; a wearable connector needs access for months
- **User consent**: The person must approve what data each app can access
- **Modularity**: Any SMART-compliant app should be able to connect, without tight coupling

#### Requirements

- Module launch MUST use the SMART on FHIR app launch framework
- Module launch MUST support both standalone and EHR launch patterns
- Short-term access MUST use standard OAuth 2.0 authorization code flow
- Long-term access MUST use refresh tokens (offline_access scope)
- The FHIR server MUST publish a CapabilityStatement and SMART configuration

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

This pattern is particularly useful for wearable data ingestion (see [Data Sharing](data-sharing.html)), where a connector app needs to periodically write Observations to the pod.

#### FHIR Subscriptions

For real-time data flows, apps can use FHIR [Subscriptions](https://www.hl7.org/fhir/subscription.html) to receive notifications when data changes:

- A coaching app subscribes to new Observations on a client's pod
- A dashboard subscribes to CarePlan updates
- A peer support tool subscribes to shared mood tracking data

Subscriptions combined with long-term access tokens enable continuous, event-driven data flows.

#### Integration with Other Functions

- **Data Storage**: SMART on FHIR is the access mechanism for the pod's FHIR interface
- **Authorization**: SMART scopes define what an app can do; the pod owner approves scopes during launch
- **Networks**: Apps can be launched from within Matrix rooms, with the Matrix context helping determine which pod to connect to
- **Identity**: The user authenticates to their pod using their identity credentials (see [Identity](identity.html))

### Dutch Context

- **SMART on FHIR adoption**: SMART on FHIR is gaining adoption in the Netherlands through MedMij and Koppeltaal (which previously used HTI). Using SMART on FHIR aligns with this trajectory.
- **OAuth 2.0**: The Dutch healthcare sector is converging on OAuth 2.0 for authorization. SMART on FHIR builds on this foundation.
- **MedMij PGO**: SMART on FHIR is the standard launch mechanism for MedMij personal health environments (PGO), making the pod compatible with the existing PGO ecosystem.

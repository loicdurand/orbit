# Feature Specification: Initial Project Setup for Orbit

**Feature Branch**: `001-initial-project-setup`  
**Created**: 2025-11-23
**Status**: Draft  
**Input**: User description: "Définition du projet Orbit, un CRM personnel mobile."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Quick Capture of Interaction (Priority: P1)

After meeting a contact, a user wants to quickly save a note about the interaction, including key details discussed, so they don't forget important information and can be more thoughtful in the future.

**Why this priority**: This is the core data-entry mechanism for the entire application. Without it, no other feature has value.

**Independent Test**: Can be tested by opening the app, entering a text or voice note, and verifying it is saved and associated with a contact. This delivers the primary value of a "second brain" for social interactions.

**Acceptance Scenarios**:

1. **Given** the user is on the main screen, **When** they tap the "Quick Capture" button, **Then** a minimalist interface for text or voice input is presented immediately.
2. **Given** the user has entered a note (e.g., "J'ai vu Marc, sa fille Léa rentre au CP demain, il aime le Whisky japonais."), **When** they save the note, **Then** the note is stored and linked to the contact "Marc".

---

### User Story 2 - Automatic Information Extraction (Priority: P2)

A user wants the app to automatically analyze their saved notes to update contact profiles and create smart reminders, reducing their manual organizational workload.

**Why this priority**: This feature provides the "magic" of the application, turning raw data into structured, actionable information. It directly supports the mission of reducing mental load.

**Independent Test**: Can be tested by creating a note with new, specific information. The system's output (updated contact fields, new reminders) can be checked for accuracy.

**Acceptance Scenarios**:

1. **Given** a note is saved containing "sa fille Léa rentre au CP demain", **When** the note is processed, **Then** a reminder is created for the next day to "Demander comment s'est passée la rentrée de Léa".
2. **Given** a note is saved containing "il aime le Whisky japonais", **When** the note is processed, **Then** the "Interests" field for that contact is updated to include "Whisky japonais".

---

### User Story 3 - Relationship Health Dashboard (Priority: P3)

A user wants to see a dashboard that visually prioritizes contacts who they haven't interacted with in a while, helping them decide who to reconnect with.

**Why this priority**: This feature drives proactive relationship management, which is a key differentiator from a standard address book. It helps users focus their social energy effectively.

**Independent Test**: Can be tested by having several contacts with different last-interaction dates. The dashboard should visually distinguish the contacts needing attention from those recently contacted.

**Acceptance Scenarios**:

1. **Given** the user has several contacts with last-interaction dates spanning from yesterday to three months ago, **When** they view the "Jardinier" dashboard, **Then** the contact from three months ago is highlighted more prominently than the one from yesterday.

### Edge Cases

- What happens if a voice note cannot be transcribed accurately?
- How does the system handle a note that contains information about multiple contacts?
- What happens if the user enters a note for a person who is not yet a contact?
- How are conflicts handled if a note contains information that contradicts existing contact data?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide an interface for capturing text or voice notes.
- **FR-002**: System MUST allow users to associate notes with specific contacts.
- **FR-003**: System MUST analyze saved notes to extract key information, such as names, events, and interests.
- **FR-004**: System MUST create contextual reminders based on information extracted from notes.
- **FR-005**: System MUST update contact profiles with structured data (e.g., family members, interests) extracted from notes.
- **FR-006**: System MUST provide a dashboard that visualizes relationship strength or time since last contact.
- **FR-007**: Users MUST be able to manage a list of their contacts.
- **FR-008**: The system's data processing for notes MUST handle personal information securely. On-device processing is the default. If a device cannot perform local processing, the system MUST ask the user to explicitly opt-in to use a cloud-based service with anonymized data.

### Key Entities *(include if feature involves data)*

- **Contact**: Represents a person in the user's network. Key attributes include name, relationship, and last interaction date.
- **Note**: A text or voice recording of an interaction with a Contact.
- **Reminder**: A scheduled notification for a future action related to a Contact.
- **Interest**: A topic or hobby associated with a Contact, extracted from a Note.

### Assumptions

- Users will have a consistent internet connection for any cloud-based AI processing, although the core app will be offline-first.
- For the MVP, voice-to-text transcription will be handled by the capabilities of the native operating system.
- The initial user base will be comfortable with an English or French interface, as localization is not part of the MVP.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can open the app and save a quick note in under 3 seconds.
- **SC-002**: The system correctly extracts at least 80% of explicitly stated entities (names, dates, interests) from test notes.
- **SC-003**: The free version of the application MUST support up to 15 contacts.
- **SC-004**: All primary features MUST be available and fully functional when the device is offline.

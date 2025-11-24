# Tasks: Initial Project Setup for Orbit

**Input**: Design documents from `/specs/001-initial-project-setup/`
**Prerequisites**: plan.md, spec.md, data-model.md

**Tests**: Not included as not explicitly requested.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions. `lib/` is the root for Dart/Flutter code.

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Initialize the Flutter project and configure basic tools.

- [x] T001 Initialize Flutter project using `flutter create orbit`
- [x] T002 Add dependencies to `pubspec.yaml`: `isar`, `isar_flutter_libs`, `flutter_secure_storage`, `riverpod`, `flutter_riverpod`, `freezed_annotation`, `dio`, `go_router`, `lucide_icons`
- [x] T003 Add dev dependencies to `pubspec.yaml`: `build_runner`, `isar_generator`, `freezed`, `riverpod_generator`
- [x] T004 [P] Configure linting rules in `analysis_options.yaml` for strict analysis.
- [x] T005 [P] Create basic directory structure: `lib/src/core`, `lib/src/features`, `lib/src/models`, `lib/src/services`.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented.

- [x] T006 [P] Implement Isar database service in `lib/src/core/database.dart` to initialize the database.
- [x] T007 [P] Implement GoRouter configuration in `lib/src/core/router.dart` with initial routes.
- [x] T008 [P] Configure Riverpod `ProviderScope` at the root of the application in `lib/main.dart`.
- [x] T009 Implement the data models from `data-model.md` in `lib/src/models/`.
    - [x] T009a [P] Create `contact.dart` for the Contact entity.
    - [x] T009b [P] Create `note.dart` for the Note entity.
    - [x] T009c [P] Create `reminder.dart` for the Reminder entity.
- [x] T010 Run build_runner to generate Isar and Riverpod code: `flutter pub run build_runner build --delete-conflicting-outputs`

**Checkpoint**: Foundation ready - user story implementation can now begin.

---

## Phase 3: User Story 1 - Quick Capture of Interaction (Priority: P1) 🎯 MVP

**Goal**: Allow a user to quickly save a text or voice note about an interaction with a contact.

**Independent Test**: Open the app, enter a note for a contact, save it, and verify it appears in the contact's details.

### Implementation for User Story 1

- [x] T011 [US1] Create the "Quick Capture" UI screen in `lib/src/features/capture/capture_screen.dart`.
- [x] T012 [US1] Create a Riverpod provider in `lib/src/features/capture/capture_provider.dart` to manage the state of the capture screen.
- [x] T013 [US1] Implement logic to save a new `Note` to the Isar database and associate it with a `Contact`.
- [x] T014 [US1] Create a basic contact list screen in `lib/src/features/contacts/contact_list_screen.dart` to select a contact.
- [x] T015 [US1] Create a contact detail screen in `lib/src/features/contacts/contact_detail_screen.dart` to display saved notes.
- [x] T016 [US1] Add navigation logic in `lib/src/core/router.dart` to connect the contact list, detail, and capture screens.

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Automatic Information Extraction (Priority: P2)

**Goal**: Automatically analyze saved notes to update contact profiles and create smart reminders.

**Independent Test**: Create a note with a date-related event. Verify that a reminder is created and the contact's AI-profile is updated.

### Implementation for User Story 2

- [ ] T017 [P] [US2] Implement the `AiService` in `lib/src/services/ai_service.dart` to call the OpenAI API using `dio`.
- [ ] T018 [P] [US2] Implement secure storage logic using `flutter_secure_storage` for the OpenAI API key.
- [ ] T019 [US2] Create a background process or a trigger that sends a new `Note` to the `AiService`.
- [ ] T020 [US2] Implement logic to parse the JSON response from the AI.
- [ ] T021 [US2] Implement logic to create a new `Reminder` in the database based on the AI response.
- [ ] T022 [US2] Implement logic to update the `aiProfileData` field of a `Contact` with data from the AI response.
- [ ] T023 [US2] Add UI elements to the contact detail screen to display the extracted AI data.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work.

---

## Phase 5: User Story 3 - Relationship Health Dashboard (Priority: P3)

**Goal**: Display a dashboard that visually prioritizes contacts who need attention.

**Independent Test**: With several contacts having different last-interaction dates, verify the dashboard correctly sorts and highlights the most neglected contacts.

### Implementation for User Story 3

- [ ] T024 [US3] Create the "Jardinier" dashboard UI in `lib/src/features/dashboard/dashboard_screen.dart`.
- [ ] T025 [US3] Implement a Riverpod provider in `lib/src/features/dashboard/dashboard_provider.dart` to fetch contacts.
- [ ] T026 [US3] Implement the query logic to fetch contacts from Isar and sort them by `lastInteractionDate` or `relationshipScore`.
- [ ] T027 [US3] Implement the visual indicators (e.g., color-coding, ordering) on the dashboard to represent relationship health.
- [ ] T028 [US3] Update the main navigation in `lib/src/core/router.dart` to include the dashboard screen.

**Checkpoint**: All user stories should now be independently functional.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories.

- [ ] T029 [P] Implement the final Material 3 custom theme and apply it across all screens.
- [ ] T030 [P] Replace placeholder icons with `lucide_icons`.
- [ ] T031 Review and add error handling for all user flows (e.g., network errors, database errors).
- [ ] T032 [P] Add documentation to public methods and classes.
- [x] T033 Run `quickstart.md` validation to ensure the app runs and tests pass.

---

## Dependencies & Execution Order

- **Foundational (Phase 2)** must be completed before any User Story phase.
- **User Story 1 (P1)** is the MVP and has no dependencies on other stories.
- **User Story 2 (P2)** depends on US1 (to have notes to process).
- **User Story 3 (P3)** depends on US1 (to have contacts and interaction dates).
- User Stories can be worked on in parallel after the Foundational phase, but the dependency order (US1 -> US2/US3) is logical.

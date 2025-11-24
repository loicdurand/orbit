# Quickstart Guide: Orbit Development

This guide provides essential setup instructions to get the Orbit application running locally.

## Prerequisites

- **Flutter SDK**: Ensure you have the latest stable version of Flutter installed.
- **IDE**: Android Studio or Visual Studio Code with the Flutter and Dart plugins.
- **Isar Generator**: Isar requires a code generator to be run.

## Setup Instructions

1.  **Clone the Repository**:
    ```bash
    git clone <repository-url>
    cd orbit
    ```

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation**:
    The project uses code generation for Riverpod state management and the Isar database models. Run the following command to generate the necessary files. This command should be re-run whenever you change a model or a provider.
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the Application**:
    Connect a device or start an emulator, and then run the app:
    ```bash
    flutter run
    ```

## Testing Scenarios

This section outlines test cases for the core user stories.

### User Story 1: Quick Capture

1.  Launch the app.
2.  Tap the "Quick Capture" button.
3.  Enter a note for a new or existing contact.
4.  Save the note.
5.  **Verification**: Navigate to the contact's detail page and confirm the new note is present and timestamped correctly.

### User Story 2: Automatic Information Extraction

1.  Ensure you have a valid OpenAI API key configured in the app's settings (secure storage).
2.  Create a note for a contact with a clear, actionable detail (e.g., "Met with Sarah, her anniversary is next Tuesday").
3.  Save the note.
4.  **Verification**:
    - Check the contact's profile to see if the `aiProfileData` has been updated with the new information.
    - Check the reminders list to confirm that a new reminder has been scheduled for next Tuesday.
    - Check the note's status to see `isProcessedByAi` is marked as true.

### User Story 3: Relationship Health Dashboard

1.  Create several contacts.
2.  Add notes with different dates for each contact to simulate a history of interactions.
3.  Navigate to the "Jardinier" (Gardener) dashboard.
4.  **Verification**: Confirm that the contacts you haven't interacted with for the longest time appear more prominently (e.g., at the top of the list, with a different color).

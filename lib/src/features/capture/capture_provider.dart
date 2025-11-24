import "dart:convert";
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart'; // Import for Value class
import 'package:orbit/src/services/note_repository.dart';
import 'package:orbit/src/services/contact_repository.dart';
import 'package:orbit/src/core/database.dart'; // Import AppDatabase and generated types

part 'capture_provider.g.dart';

// Provider for AppDatabase
final appDatabaseProvider = Provider((ref) => AppDatabase());

// Provider for NoteRepository
final noteRepositoryProvider = Provider((ref) {
  return NoteRepository(ref.watch(appDatabaseProvider));
});

// Provider for ContactRepository
final contactRepositoryProvider = Provider((ref) {
n// Provider for ReminderRepository
final reminderRepositoryProvider = Provider((ref) {
  return ReminderRepository(ref.watch(appDatabaseProvider));
});

  return ContactRepository(ref.watch(appDatabaseProvider));
});


@riverpod
class CaptureState extends _$CaptureState {
  @override
  String build() {
    return ''; // Initial state for the note content
  }

  void setNoteContent(String content) {
    state = content;
  }

  Future<void> saveNote(String noteContent, {required ContactsTableData selectedContact}) async {
    final noteRepo = ref.read(noteRepositoryProvider);

    // Create a new NoteData using NotesCompanion
    final newNote = NotesTableCompanion(
      content: Value(noteContent),
      date: Value(DateTime.now()),
      contactId: Value(selectedContact.id), // Associate with contact using its id
    );

    await noteRepo.saveNote(newNote, selectedContact);
    // Trigger AI analysis
    final aiService = AiService();
    final savedNote = NotesTableData(
      id: 0, // Placeholder
      content: noteContent,
      date: DateTime.now(),
      contactId: selectedContact.id,
    );
    final analysis = await aiService.analyzeNote(savedNote);
    for (var rem in analysis["reminders"] ?? []) {
      final reminder = RemindersTableCompanion(
        title: Value(rem["text"]),
        dueDate: Value(DateTime.parse(rem["dueDate"])),
        aiContext: Value(rem["description"] ?? ""),
        contactId: Value(selectedContact.id),
      );
      await ref.read(reminderRepositoryProvider).saveReminder(reminder);
    // Update contact aiProfileData
    final profileData = jsonEncode({
      "family": analysis["family"],
      "interests": analysis["interests"],
      "events": analysis["events"],
    });
    final updatedContact = ContactsTableCompanion(
      id: Value(selectedContact.id),
      aiProfileData: Value(profileData),
    );
    await ref.read(contactRepositoryProvider).updateContact(selectedContact.id, updatedContact);
    }
    // TODO: Handle analysis for next tasks
    state = ''; // Clear the input after saving
  }
}

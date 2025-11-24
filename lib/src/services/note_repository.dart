import 'package:orbit/src/core/database.dart';

class NoteRepository {
  final AppDatabase _db;

  NoteRepository(this._db);

  Future<void> saveNote(NotesTableCompanion entry, ContactsTableData contact) async {
    await _db.into(_db.notesTable).insert(entry);
  }

  Future<List<NotesTableData>> getNotesForContact(int contactId) async {
    return (_db.select(_db.notesTable)..where((tbl) => tbl.contactId.equals(contactId))).get();
  }
}

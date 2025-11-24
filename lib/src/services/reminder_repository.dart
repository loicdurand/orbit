import 'package:orbit/src/core/database.dart';

class ReminderRepository {
  final AppDatabase _db;

  ReminderRepository(this._db);

  Future<void> saveReminder(RemindersTableCompanion entry) async {
    await _db.into(_db.remindersTable).insert(entry);
  }

  Future<List<RemindersTableData>> getRemindersForContact(int contactId) async {
    return (_db.select(_db.remindersTable)..where((tbl) => tbl.contactId.equals(contactId))).get();
  }
}

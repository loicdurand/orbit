import 'package:orbit/src/core/database.dart';

class ContactRepository {
  final AppDatabase _db;

  ContactRepository(this._db);

  Future<ContactsTableData?> getContactById(int id) async {
    return (_db.select(_db.contactsTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<ContactsTableData>> getAllContacts() async {
    return _db.select(_db.contactsTable).get();
  }

  Future<ContactsTableData> saveContact(ContactsTableCompanion entry) async {
    final id = await _db.into(_db.contactsTable).insert(entry);
    return (await getContactById(id))!; // Retrieve the inserted contact
  }
}

  Future<void> updateContact(int id, ContactsTableCompanion updated) async {
    await (_db.update(_db.contactsTable)..where((tbl) => tbl.id.equals(id))).replace(updated);
  }


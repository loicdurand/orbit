import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart'; // Drift will generate this file

class ContactsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get avatarPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastInteractionDate => dateTime().nullable()();
  RealColumn get relationshipScore => real().withDefault(const Constant(50.0))();
  TextColumn get aiProfileData => text().nullable()();
}

class NotesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 1)();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isProcessedByAi => boolean().withDefault(const Constant(false))();
  IntColumn get contactId => integer().references(ContactsTable, #id)(); // Foreign key
}

class RemindersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1)();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get aiContext => text().nullable()();
  IntColumn get contactId => integer().references(ContactsTable, #id)(); // Foreign key
}

@DriftDatabase(tables: [ContactsTable, NotesTable, RemindersTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; // Increment this when you change your schema

  // Add methods for querying and manipulating data here
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
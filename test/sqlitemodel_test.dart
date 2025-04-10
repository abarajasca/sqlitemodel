import 'package:flutter_test/flutter_test.dart';
import 'package:sqlitemodel/test_sqlite_database.dart';

import 'config/mydatabase_config.dart';
import 'models/note.dart';
import 'store/store.dart';


Future main() async {
  group('Test SQLiteTest Provider' , () {
    test("Insert a note", () async {
      Store.databaseProvider = TestSqLiteDatabase(MyDatabaseConfig());
      //Store.databaseProvider = SqLiteDatabase(MyDatabaseConfig());    // real sqlite database

      await Store.notes.insert(Note(
          title: 'Note 1',
          body: 'Body 1',
          idCategory: 1,
          created_at: 'now',
          updated_at: 'now'));

      var note = (await Store.notes.getAll()).first;

      expect(note.title,'Note 1');
      expect(note.body,'Body 1');
      expect(note.created_at,'now');
      expect(note.updated_at,'now');

    });

    test("Update a note", () async {

      Store.databaseProvider = TestSqLiteDatabase(MyDatabaseConfig());
      //Store.databaseProvider = SqLiteDatabase(MyDatabaseConfig());    // real sqlite database

      var noteId = await Store.notes.insert(Note(
          title: 'Note 2',
          body: 'Body 2',
          idCategory: 1,
          created_at: 'now',
          updated_at: 'now'));

      var note = (await Store.notes.getAll(where: 'id == $noteId' )).first;

      note.title = "Note 2 updated";
      await Store.notes.update(note);
      note = (await Store.notes.getAll(where: 'id == $noteId' )).first;

      expect(note.title,'Note 2 updated');

    });

    test("Raw query note", () async {
      Store.databaseProvider = TestSqLiteDatabase(MyDatabaseConfig());

      int? noteId = await Store.notes.insert(Note(
          title: 'Note query 1',
          body: 'Body 2',
          idCategory: 1,
          created_at: 'now',
          updated_at: 'now'));

      var note = (await Store.notes.rawQuery('select title from notes where id == ?', [noteId!])).first;
      expect(note['title'],'Note query 1');

    });

    test("Delete a note", () async {
      Store.databaseProvider = TestSqLiteDatabase(MyDatabaseConfig());

      var noteId = await Store.notes.insert(Note(
          title: 'Note delete 1',
          body: 'Body 2',
          idCategory: 1,
          created_at: 'now',
          updated_at: 'now'));

      var note = (await Store.notes.getAll(where: 'id == $noteId' )).first;
      expect(note.title,'Note delete 1');

      await Store.notes.delete(note);

      var notes = (await Store.notes.getAll(where: 'id == $noteId' ));
      expect(notes.length,0);

    });

    test("Delete raw a note", () async {
      Store.databaseProvider = TestSqLiteDatabase(MyDatabaseConfig());

      int? noteId = await Store.notes.insert(Note(
          title: 'Note delete 1',
          body: 'Body 2',
          idCategory: 1,
          created_at: 'now',
          updated_at: 'now'));

      var note = (await Store.notes.getAll(where: 'id == $noteId' )).first;
      expect(note.title,'Note delete 1');

      await Store.notes.deleteRaw(tableName: Note.TABLE_NAME, where:'id == ?', whereArgs: [noteId!]);

      var notes = (await Store.notes.getAll(where: 'id == $noteId' ));
      expect(notes.length,0);

    });

  });

}

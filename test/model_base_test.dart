import 'package:flutter_test/flutter_test.dart';
import 'models/note.dart';

Future main() async {
    test("Model base test", () async {
      var note = Note(
        title: 'Note 1',
        body: 'Body 1',
        idCategory: 1,
        created_at: 'now',
        updated_at: 'now'
      );

      expect(note.title,'Note 1');
      expect(note.body,'Body 1');
      expect(note.created_at,'now');
      expect(note.updated_at,'now');

      expect(note.getTableName(),"notes");
      expect(note.getId(),isNull);

      });

}

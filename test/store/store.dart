import 'package:sqlitemodel/providers/database_provider.dart';
import 'package:sqlitemodel/providers/model_provider.dart';

import '../models/note.dart';

class Store {
  static late ModelProvider<Note> notes;

  static void set databaseProvider(DatabaseProvider? databaseProvider) {
    notes = ModelProvider<Note>(databaseProvider:databaseProvider, model: Note.getDummyReference());
  }
}
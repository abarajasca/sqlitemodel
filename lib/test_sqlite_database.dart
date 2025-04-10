import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_config.dart';
import 'providers/database_provider.dart';

// Provides a on memory sqlite database for testing purpose.

class TestSqLiteDatabase extends DatabaseProvider {
  late final DatabaseConfig databaseConfig;

  TestSqLiteDatabase(DatabaseConfig databaseConfig){
    this.databaseConfig = databaseConfig;
  }

  Future<Database> getDatabaseInstance() async {
    // Init ffi loader if needed.
    sqfliteFfiInit();

    // Open the database and store the reference.
    return await  databaseFactoryFfi.openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        onCreate: databaseConfig.onCreate,
        onUpgrade: databaseConfig.onUpgrade,
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: databaseConfig.getInitialDatabaseVersion() ,
    ));
  }

}

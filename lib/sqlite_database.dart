import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlitemodel/database_config.dart';

import 'providers/database_provider.dart';

class SqLiteDatabase extends DatabaseProvider {
  late final DatabaseConfig databaseConfig;

  SqLiteDatabase(DatabaseConfig databaseConfig){
    this.databaseConfig = databaseConfig;
  }

  @override
  Future<Database> getDatabaseInstance() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), databaseConfig.getDatabaseFilename()),
      // When the database is first created, create a table to store dogs.
      onCreate: databaseConfig.onCreate,
      onUpgrade: databaseConfig.onUpgrade,
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: databaseConfig.getInitialDatabaseVersion(),
    );
  }
}

import 'dart:async';

// Provides details about the database implemented

abstract class DatabaseConfig {

  FutureOr<void> onCreate(db, version) {
    throw UnimplementedError('String onCreate() not implemented.');
  }

  FutureOr<void> onUpgrade(db,oldVersion,newVersion){
    throw UnimplementedError('String onUpgrade() not implemented.');
  }

  String getDatabaseFilename() {
    throw UnimplementedError('String getDatabaseFilename() not implemented.');
  }

  int? getInitialDatabaseVersion() {
    throw UnimplementedError('int? getInitialDatabaseVersion() not implemented.');
  }

}

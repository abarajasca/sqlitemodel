import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    throw UnimplementedError('database getDatabaseInstance not implemented.');
  }

}

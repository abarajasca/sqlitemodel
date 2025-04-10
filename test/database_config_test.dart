import 'package:flutter_test/flutter_test.dart';
import 'package:sqlitemodel/database_config.dart';
import 'config/mydatabase_config.dart';

Future main() async {
  test("Database config test", () async {
    DatabaseConfig myDatabaseConfig = MyDatabaseConfig();

    expect(myDatabaseConfig.getDatabaseFilename(),"lib_notes.db");
    expect(myDatabaseConfig.getInitialDatabaseVersion(),1);

  });

}

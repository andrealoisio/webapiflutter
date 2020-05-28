import 'package:path/path.dart';
import 'package:persistenciaflutter/database/dao/contact_dao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'butebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete
  );
}
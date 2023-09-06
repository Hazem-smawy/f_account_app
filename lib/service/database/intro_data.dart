import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:sqflite/sqflite.dart';

class IntroData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS intro (
        id ${FieldType.idType},
        isShow ${FieldType.boolType});


        
    ''');
  }

  Future<void> create() async {
    try {
      final db = await DatabaseService().database;
      await db.insert('intro', {"id": 1, "isShow": 0});
    } catch (e) {
      print("error for creatting");
    }
  }

  Future<bool> read() async {
    try {
      final db = await DatabaseService().database;
      final result = await db.query('intro');
      final value = result.first['isShow'];
      print(value);
      return value == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> update() async {
    try {
      final db = await DatabaseService().database;
      final result = await db.update('intro', {"id": 1, "isShow": 1});
      print("updated: $result");
      return result;
    } catch (e) {
      print("error for update");
      return 0;
    }
  }
}

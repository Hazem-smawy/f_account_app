import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:sqflite/sqflite.dart';

class DetailData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS detail (
        id ${FieldType.idType},
        body ${FieldType.boolType} UNIQUE );


        
    ''');
  }

  Future<void> create(String details) async {
    try {
      final db = await DatabaseService().database;
      await db.insert('detail', {"body": details.trim()});
    } catch (e) {
      // CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
    }
  }

  Future<List<Map<String, Object?>>?> readAll() async {
    try {
      final db = await DatabaseService().database;
      final results = await db.query(
        'detail',
      );

      return results;
    } catch (e) {
      return null;
    }
  }
}

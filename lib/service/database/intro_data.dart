import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../widget/custom_dialog.dart';

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
      // CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
    }
  }

  Future<bool> read() async {
    try {
      final db = await DatabaseService().database;
      final result = await db.query('intro');
      final value = result.first['isShow'];

      return value == 1;
    } catch (e) {
      CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<int> update() async {
    try {
      final db = await DatabaseService().database;
      final result = await db.update('intro', {"id": 1, "isShow": 1});

      return result;
    } catch (e) {
      CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
      return 0;
    }
  }
}

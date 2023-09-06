import 'package:account_app/models/curency_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CurencyData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS ${TableName.curencyTbl} (
          ${CurencyField.id} ${FieldType.idType},
          ${CurencyField.name} ${FieldType.textType} UNIQUE,
          ${CurencyField.symbol} ${FieldType.textType},
          ${CurencyField.status} ${FieldType.boolType},
          ${CurencyField.createdAt} ${FieldType.timeType},
          ${CurencyField.modifiedAt} ${FieldType.timeType}


        );
    ''');
  }

  Future<Curency?> create(Curency curency) async {
    try {
      final db = await DatabaseService().database;
      final id = await db.insert(TableName.curencyTbl, curency.toMap());
      Get.back();
      return curency.copyWith(id: id);
    } catch (e) {
      CustomDialog.customSnackBar('هذا الاسم موجود من قبل', SnackPosition.TOP);
    }
    return null;
  }

  Future<Curency?> readCurency(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      TableName.curencyTbl,
      columns: CurencyField.values,
      where: '${CurencyField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Curency.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Curency>> readAllCurencies() async {
    final db = await DatabaseService().database;

    final result = await db.query(TableName.curencyTbl);
    return result.map((e) => Curency.fromMap(e)).toList();
  }

  Future<int?> updateCurency(Curency curency) async {
    final db = await DatabaseService().database;

    try {
      final updatedObject = await db.update(
          TableName.curencyTbl, curency.toMap(),
          where: '${CurencyField.id} = ?', whereArgs: [curency.id]);
      Get.back();
      return updatedObject;
    } catch (e) {
      CustomDialog.customSnackBar('هذا الاسم موجود من قبل', SnackPosition.TOP);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(TableName.curencyTbl,
        where: '${CurencyField.id} = ?', whereArgs: [id]);
  }
}

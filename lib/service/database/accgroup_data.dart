import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AccGroupData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${TableName.accGroupTbl} (
          ${AccGroupField.id} ${FieldType.idType},
          ${AccGroupField.name} ${FieldType.textType} UNIQUE,
          ${AccGroupField.status} ${FieldType.boolType},
          ${AccGroupField.createdAt} ${FieldType.timeType},
          ${AccGroupField.modifiedAt} ${FieldType.timeType}


        );
    ''');
  }

  Future<AccGroup?> create(AccGroup accGroup) async {
    try {
      final db = await DatabaseService().database;
      final id = await db.insert(TableName.accGroupTbl, accGroup.toMap());
      Get.back();
      return accGroup.copyWith(id: id);
    } catch (e) {
      CustomDialog.customSnackBar(
          'هذا الاسم موجود من قبل', SnackPosition.TOP, true);
    }
    return null;
  }

  Future<AccGroup?> readAccGroup(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      TableName.accGroupTbl,
      columns: AccGroupField.values,
      where: '${AccGroupField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AccGroup.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<AccGroup>> readAllAccGroups() async {
    final db = await DatabaseService().database;

    final result = await db.query(TableName.accGroupTbl);

    return result.map((e) => AccGroup.fromMap(e)).toList();
  }

  Future<int?> updateAccGroup(AccGroup accGroup) async {
    final db = await DatabaseService().database;
    try {
      final upOb = await db.update(TableName.accGroupTbl, accGroup.toMap(),
          where: '${AccGroupField.id} = ?', whereArgs: [accGroup.id]);
      Get.back();
      return upOb;
    } catch (e) {
      CustomDialog.customSnackBar(
          'هذا الاسم موجود من قبل', SnackPosition.TOP, true);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;

    return await db.delete(TableName.accGroupTbl,
        where: '${AccGroupField.id} = ?', whereArgs: [id]);
  }
}

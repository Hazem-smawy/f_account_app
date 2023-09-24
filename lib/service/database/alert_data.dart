import 'package:account_app/models/alert_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:sqflite/sqflite.dart';

class AlertData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${TableName.alert} (
          ${AlertModelFiled.id} ${FieldType.idType},
          ${AlertModelFiled.date} ${FieldType.timeType} ,
          ${AlertModelFiled.name} ${FieldType.textType},
          ${AlertModelFiled.note} ${FieldType.textType},
          ${AlertModelFiled.createdAt} ${FieldType.timeType},
          ${AlertModelFiled.isDone} ${FieldType.boolType}


        );
    ''');
  }

  Future<AlertModel?> create(AlertModel alertModel) async {
    try {
      final db = await DatabaseService().database;
      final id = await db.insert(TableName.alert, alertModel.toMap());

      return alertModel.copyWith(id: id);
    } catch (e) {
      // CustomDialog.customSnackBar(
      //     'هذا الاسم موجود من قبل', SnackPosition.TOP, true);
      print("error for crreate alert");
    }
    return null;
  }

  Future<AlertModel?> readAlert(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      TableName.alert,
      columns: AlertModelFiled.values,
      where: '${AlertModelFiled.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AlertModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<AlertModel>> readAllAlerts() async {
    final db = await DatabaseService().database;

    final result = await db.query(TableName.alert);

    return result.map((e) => AlertModel.fromMap(e)).toList();
  }

  Future<int?> updateAlert(AlertModel alertModel) async {
    final db = await DatabaseService().database;
    try {
      final upOb = await db.update(TableName.alert, alertModel.toMap(),
          where: '${AlertModelFiled.id} = ?', whereArgs: [alertModel.id]);

      return upOb;
    } catch (e) {
      // CustomDialog.customSnackBar(
      //     'هذا الاسم موجود من قبل', SnackPosition.TOP, true);
      print("error for update alert");
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;

    return await db.delete(TableName.alert,
        where: '${AlertModelFiled.id} = ?', whereArgs: [id]);
  }
}

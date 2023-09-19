import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CustomerData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS ${TableName.customerTbl} (
        ${CustomerField.id} ${FieldType.idType},
          ${CustomerField.name} ${FieldType.textType} UNIQUE,
          ${CustomerField.phone} ${FieldType.textType},
          ${CustomerField.address} ${FieldType.textType},
          ${CustomerField.status} ${FieldType.boolType},
          ${CustomerField.createdAt} ${FieldType.timeType},
          ${CustomerField.modifiedAt} ${FieldType.timeType}



        );
    ''');
  }

  Future<Customer?> create(Customer customer) async {
    try {
      final db = await DatabaseService().database;
      final id = await db.insert(TableName.customerTbl, customer.toMap());
      Get.back();
      return customer.copyWith(id: id);
    } catch (e) {
      CustomDialog.customSnackBar(
          'هذا الاسم موجود من قبل', SnackPosition.TOP, true);
    }
    return null;
  }

  Future<Customer?> readCustomer(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      TableName.customerTbl,
      columns: CustomerField.values,
      where: '${CustomerField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Customer>> readAllCustomers() async {
    final db = await DatabaseService().database;

    final result = await db.query(TableName.customerTbl);
    return result.map((e) => Customer.fromMap(e)).toList();
  }

  Future<int?> updateCustomer(Customer customer) async {
    final db = await DatabaseService().database;

    try {
      final updatedObject = await db.update(
          TableName.customerTbl, customer.toMap(),
          where: '${CustomerField.id} = ?', whereArgs: [customer.id]);
      Get.back();
      return updatedObject;
    } catch (e) {
      CustomDialog.customSnackBar(
          'هذا الاسم موجود من قبل', SnackPosition.TOP, true);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(TableName.customerTbl,
        where: '${CustomerField.id} = ?', whereArgs: [id]);
  }
}

import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:sqflite/sqflite.dart';

class CustomerAccountData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS ${TableName.customerAccountTbl} (
        
          ${CustomerAccountField.id} ${FieldType.idType},
          ${CustomerAccountField.customerId} ${FieldType.integerType},
          ${CustomerAccountField.curencyId} ${FieldType.integerType},
          ${CustomerAccountField.accgroupId} ${FieldType.integerType},
          ${CustomerAccountField.totalCredit} ${FieldType.doubleType},
          ${CustomerAccountField.totalDebit} ${FieldType.doubleType},
          ${CustomerAccountField.createdAt} ${FieldType.timeType},
          ${CustomerAccountField.operation} ${FieldType.integerType},
          ${CustomerAccountField.status} ${FieldType.boolType}


        );
    ''');
  }

  Future<CustomerAccount> create(CustomerAccount customerAccount) async {
    final db = await DatabaseService().database;
    final id =
        await db.insert(TableName.customerAccountTbl, customerAccount.toMap());

    return customerAccount.copyWith(id: id);
  }

  Future<CustomerAccount?> readCustomerAccount(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      TableName.customerAccountTbl,
      columns: CustomerAccountField.values,
      where: '${CustomerAccountField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CustomerAccount.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<CustomerAccount>> readAllCustomerAccounts() async {
    final db = await DatabaseService().database;

    final result = await db.query(TableName.customerAccountTbl,
        orderBy:
            " ${CustomerAccountField.customerId}, ${CustomerAccountField.accgroupId}");
    return result.map((e) => CustomerAccount.fromMap(e)).toList();
  }

  Future<int> updateCustomerAccount(CustomerAccount customerAccount) async {
    final db = await DatabaseService().database;
    return db.update(TableName.customerAccountTbl, customerAccount.toMap(),
        where: '${CustomerField.id} = ?', whereArgs: [customerAccount.id]);
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(TableName.customerAccountTbl,
        where: '${CustomerAccountField.id} = ?', whereArgs: [id]);
  }

  Future<CustomerAccount?> isCustomerAccountExist(
      {required int customerId,
      required int accGroupId,
      required int curencyId}) async {
    final db = await DatabaseService().database;
    var maps = await db.query(TableName.customerAccountTbl,
        columns: CustomerAccountField.values,
        where:
            "${CustomerAccountField.customerId} = ? AND ${CustomerAccountField.accgroupId} = ? AND ${CustomerAccountField.curencyId} = ?",
        whereArgs: [customerId, accGroupId, curencyId]);
    // var maps = await db.rawQuery(
    //     "SELECT id FROM ${TableName.customerAccountTbl}  WHERE ${CustomerAccountField.customerId} = ? AND ${CustomerAccountField.accgroupId} = ? AND ${CustomerAccountField.curencyId} = ?",
    //     ['$customerId', '$accGroupId', '$curencyId']);
    //int? count = Sqflite.firstIntValue(row);
    if (maps.isNotEmpty) {
      return CustomerAccount.fromMap(maps.first);
    } else {
      return null;
    }
  }
}

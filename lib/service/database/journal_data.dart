import 'package:account_app/models/customer_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class JournalData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS ${TableName.journalTbl} (
          ${JournalField.id} ${FieldType.idType},
          ${JournalField.customerAccountId} ${FieldType.integerType},
          ${JournalField.details} ${FieldType.textType},
          ${JournalField.registeredAt} ${FieldType.timeType},
          ${JournalField.credit} ${FieldType.doubleType},
          ${JournalField.debit} ${FieldType.doubleType},
          ${JournalField.createdAt} ${FieldType.timeType},
          ${JournalField.modifiedAt} ${FieldType.timeType}


        );
    ''');
  }

  Future<Journal?> create(Journal journal) async {
    try {
      final db = await DatabaseService().database;
      final id = await db.insert(TableName.journalTbl, journal.toMap());
      Get.back();
      return journal.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Journal>> readAllJournalForCustomerAccount(cacId) async {
    final db = await DatabaseService().database;
    final results = await db.query(
      TableName.journalTbl,
      columns: JournalField.values,
      where: '${JournalField.customerAccountId} = ?',
      whereArgs: [cacId],
    );

    return results.map((e) => Journal.fromMap(e)).toList();
  }

  Future<Journal?> readJournal(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      TableName.journalTbl,
      columns: JournalField.values,
      where: '${JournalField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Journal.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Journal>> readAllJournal() async {
    final db = await DatabaseService().database;

    final result = await db.query(TableName.journalTbl);
    return result.map((e) => Journal.fromMap(e)).toList();
  }

  Future<int?> updateJournal(Journal journal) async {
    final db = await DatabaseService().database;

    try {
      final updatedObject = await db.update(
          TableName.journalTbl, journal.toMap(),
          where: '${CustomerField.id} = ?', whereArgs: [journal.id]);
      Get.back();
      return updatedObject;
    } catch (e) {}
    return null;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(TableName.journalTbl,
        where: '${CustomerField.id} = ?', whereArgs: [id]);
  }
}

import 'package:account_app/service/database/accgroup_data.dart';
import 'package:account_app/service/database/curency_data.dart';
import 'package:account_app/service/database/customer_account_data.dart';
import 'package:account_app/service/database/customer_data.dart';
import 'package:account_app/service/database/details_data.dart';

import 'package:account_app/service/database/intro_data.dart';
import 'package:account_app/service/database/journal_data.dart';
import 'package:account_app/service/database/personal_data.dart';
import 'package:account_app/service/database/sitting_data.dart';
import 'package:account_app/service/database/image_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    String path = await getDatabasesPath();
    String databasePath = p.join(path, "account_app_databse.db");

    return databasePath;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async {
    await database.transaction((txn) async {
      await SittingData().createTable(txn.database);
      await IntroData().createTable(txn.database);
      await CurencyData().createTable(txn.database);
      await CustomerData().createTable(txn.database);
      await AccGroupData().createTable(txn.database);
      await CustomerAccountData().createTable(txn.database);
      await JournalData().createTable(txn.database);
      await PersonalData().createTable(txn.database);
      await DetailData().createTable(txn.database);
      await ImageData().createTable(txn.database);
    });
  }
}

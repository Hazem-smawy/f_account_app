import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:sqflite/sqflite.dart';

class ImageData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS images (
        id ${FieldType.idType},
        image BLOB

  );
        
    ''');
  }

  Future<void> create({required final image}) async {
    try {
      if (image != null) {
        final bytes = await image.readAsBytes();

        final db = await DatabaseService().database;
        await db.database.transaction((txn) async {
          await txn.insert('images', {'image': bytes});
        });
        print("image inseted");
      }
    } catch (e) {
      print("error for creatting");
    }
  }

  Future<Map<String, dynamic>?> read() async {
    try {
      final db = await DatabaseService().database;
      final result = await db.query('images');
      final value = result.first;
      return value;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> update({required final image, required int id}) async {
    try {
      if (image != null) {
        final bytes = await image.readAsBytes();

        final db = await DatabaseService().database;
        await db.transaction((txn) async {
          final res = await txn.update('images', {'image': bytes},
              where: 'id = ?', whereArgs: [id]);
          return res;
        });
      } else {
        print("image is null");
      }
    } catch (e) {
      print("error for update image");
    }
  }
}
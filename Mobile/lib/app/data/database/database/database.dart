import 'dart:io';

import 'package:dating_app/app/data/database/database/room_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/constants/constants.dart';
import 'file_download_table.dart';

//db name
const String dbName = 'tcgPortal.db';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, dbName);
    final database = await openDatabase(
      path,
      version: ConstantsUtils.dbVersion,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  Future<void> onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    try {
      // example
      // if (Constants.dbVersion < 2) {
      //   await database.execute(RoomTable.alterRoomTable1);
      // }
      // if (Constants.dbVersion < 2) {
      //   await database.execute(RoomTable.alterRoomTable2);
      // }
      //alter
    } catch (e) {
      await database.execute('DROP TABLE ${RoomTable.tableName}');
      await database.execute(RoomTable.initRoomTable);
      await database.execute('DROP TABLE ${FileDownloadTable.tableName}');
      await database.execute(FileDownloadTable.initRoomTable);
    }
  }

  Future initDB(Database database, int version) async {
    await database.execute(RoomTable.initRoomTable);
    await database.execute(FileDownloadTable.initRoomTable);
  }
}

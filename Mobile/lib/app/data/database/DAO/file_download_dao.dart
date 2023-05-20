import 'package:sqflite/sqflite.dart';

import '../../models/file_download/file_download.dart';
import '../database/database.dart';
import '../database/file_download_table.dart';

class FileDownloadDAO {
  FileDownloadDAO._();

  static final instance = FileDownloadDAO._();

  final _dbProvider = DatabaseProvider.dbProvider;

  Future<int> clear() async {
    final db = await _dbProvider.database;
    final re = await db.delete(FileDownloadTable.tableName);
    return re;
  }

  Future<int> insert(FileDownload file) async {
    final db = await _dbProvider.database;

    final re = await db.insert(
      FileDownloadTable.tableName,
      {
        FileDownloadTable.taskId: file.taskId,
        FileDownloadTable.urlDownload: file.urlDownload,
        FileDownloadTable.urlLocal: file.urlLocal,
        FileDownloadTable.fileName: file.fileName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return re;
  }

  Future<FileDownload?> getFile(String url) async {
    final db = await _dbProvider.database;
    final res = await db.query(
      FileDownloadTable.tableName,
      where: '${FileDownloadTable.urlDownload} = ?',
      whereArgs: [url],
    );

    final List<FileDownload> rs = res.isNotEmpty
        ? res
            .map(
              (item) => FileDownload.fromJson(item),
            )
            .toList()
        : [];
    return rs.isNotEmpty ? rs.first : null;
  }

  Future<int> delete(FileDownload file) async {
    final db = await _dbProvider.database;

    final re = await db.delete(
      FileDownloadTable.tableName,
      where: '${FileDownloadTable.taskId} = ?',
      whereArgs: [file.taskId],
    );
    return re;
  }
}

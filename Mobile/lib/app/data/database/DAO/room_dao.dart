import '../database/database.dart';
import '../database/room_table.dart';

class RoomDAO {
  //db command return 0 = error
  final _dbProvider = DatabaseProvider.dbProvider;

  Future<int> clear() async {
    final db = await _dbProvider.database;
    final re = await db.delete(RoomTable.tableName);
    return re;
  }

  Future<int> deleteMultiple(List<String> roomIds) async {
    if (roomIds.isEmpty) return 0;
    final db = await _dbProvider.database;
    final rIds = roomIds.map((e) => '?').toString();
    final sql = '''
    DELETE FROM ${RoomTable.tableName} WHERE id IN $rIds;
    ''';
    try {
      final re = await db.rawDelete(sql, roomIds);
      return re;
    } catch (e) {
      // print('-- ${e.toString()}');
      return 0;
    }
  }
}

class RoomTable {
  static const String initRoomTable =
      "CREATE TABLE $tableName ($id TEXT PRIMARY KEY, $fName TEXT, $name TEXT, $roomType TEXT, $avatarOrigin TEXT, $lastMessage TEXT)";

//add column 1
  static const String alterRoomTable1 =
      "ALTER TABLE $tableName ADD COLUMN ($id TEXT PRIMARY KEY)"; //replace column name to add
//add column 2
  static const String alterRoomTable2 =
      "ALTER TABLE $tableName ADD COLUMN ($id TEXT PRIMARY KEY)"; //replace column name to add

  static const String tableName = "room";
  static const String id = "id";
  static const String fName = "fname";
  static const String name = "name";
  static const String roomType = "t";
  static const String lastMessage = "lastMessage";
  static const String avatarOrigin = "avatarOrigin";
}

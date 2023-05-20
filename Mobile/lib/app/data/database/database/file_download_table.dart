class FileDownloadTable {
  static const String initRoomTable =
      "CREATE TABLE $tableName ($taskId TEXT, $tableName TEXT, $fileName TEXT, $urlDownload TEXT PRIMARY KEY, $urlLocal TEXT)";

  static const String tableName = "fileDownload";
  static const String taskId = "taskId";
  static const String fileName = "fileName";
  static const String urlDownload = "urlDownload";
  static const String urlLocal = "urlLocal";
}

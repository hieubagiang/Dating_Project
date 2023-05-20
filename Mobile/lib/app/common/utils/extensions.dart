import 'dart:io';
import 'dart:math';

extension MapExtension on Map {
  Map removeNulls() => removeNullsFromMap(this);
}

extension ListExtension on List {
  List removeNulls() => removeNullsFromList(this);
}

Map<dynamic, dynamic> removeNullsFromMap(Map<dynamic, dynamic> json) => json
  ..removeWhere((dynamic key, dynamic value) => value == null)
  ..map<dynamic, dynamic>((key, value) => MapEntry(key, removeNulls(value)));

List removeNullsFromList(List list) => list
  ..removeWhere((value) => value == null)
  ..map((e) => removeNulls(e)).toList();

removeNulls(e) => (e is List)
    ? removeNullsFromList(e)
    : (e is Map ? removeNullsFromMap(e) : e);

extension Typing<T> on List<T> {
  /// Provide access to the generic type at runtime.
  Type get genericType => T;
}

extension DateTimeExtension on DateTime {
  int get age {
    var now = DateTime.now();
    var age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }
}

extension ConvertNumber on int {
  String get toSize {
    if (this == null) return "0 B";
    if (this <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (log(this) / log(1000)).floor();
    return '${(this / pow(1000, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  double get getMBSize {
    if (Platform.isAndroid) {
      return (this / 1024) / 1024;
    } else if (Platform.isIOS) {
      return (this / 1000) / 1000;
    } else {
      return (this / 1000) / 1000;
    }
  }
}

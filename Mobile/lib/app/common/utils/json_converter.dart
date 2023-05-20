import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

class Converter<T> implements JsonConverter<T, Object> {
  const Converter();

  @override
  T fromJson(Object json) {
    if (T == Position) {
      return Position.fromMap(json as Map<String, dynamic>) as T;
    }
    throw ('Converter<$T> null data on fromJson');
  }

  @override
  Object toJson(T object) {
    if (T == Position) {
      return (T as Position).toJson();
    }
    return object.toString();
  }
}

import 'dart:convert';

class ApiResponse {
  final bool? success;
  final Object? data;
  final String? error;

  ApiResponse({
    this.success,
    this.data,
    this.error,
  });

  ApiResponse copyWith({
    bool? success,
    String? error,
    Object? data,
  }) =>
      ApiResponse(
        success: success ?? this.success,
        error: error ?? this.error,
        data: data ?? this.data,
      );

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        error: json["error"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": data,
      };

  @override
  String toString() {
    return 'ApiResponse{success: $success, data: $data, error: $error}';
  }
}

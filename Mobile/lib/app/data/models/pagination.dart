import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(explicitToJson: true)
class Pagination {
  Pagination({
    this.limit = 10,
    this.page = 1,
    this.total,
  });

  final int limit;
  final int page;
  final int? total;

  Pagination copyWith({
    int? limit,
    int? page,
    int? total,
  }) =>
      Pagination(
        limit: limit ?? this.limit,
        page: page ?? this.page,
        total: total ?? this.total,
      );

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this)..removeNulls();

  Pagination first({int limit = 10}) {
    return Pagination(
      limit: limit,
      page: 1,
      total: total,
    );
  }

  Pagination previous() {
    return Pagination(
      limit: limit,
      page: page - 1,
      total: total,
    );
  }

  Pagination next() {
    return Pagination(
      limit: limit,
      page: page + 1,
      total: total,
    );
  }

  bool get isLastPage => total != null && page * limit >= total!;
  bool canLoadMore() => !isLastPage;
}

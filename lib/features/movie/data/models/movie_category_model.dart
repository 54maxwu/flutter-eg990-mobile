import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_category_model.freezed.dart';

@freezed
abstract class MovieCategoryModel with _$MovieCategoryModel {
  const factory MovieCategoryModel({
    int tid,
    String name,
    String status,
    int sort,
    int count,
  }) = _MovieCategoryModel;

  static MovieCategoryModel jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_MovieCategoryModel(
        tid: jsonMap['tid'] as int,
        name: jsonMap['name'] as String,
        status: jsonMap['status'] as String,
        sort: jsonMap['sort'] as int,
        count: jsonMap['count'] as int,
      );
}

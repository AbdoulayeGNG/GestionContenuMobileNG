import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_model.freezed.dart';
part 'content_model.g.dart';

@freezed
abstract class ContentModel with _$ContentModel {
  const factory ContentModel({
    required int id,
    required String title,
    required String? description,
    required String? image,
    required String authorId,
    required String tags,
    required String category,
  }) = _ContentModel;
  factory ContentModel.fromJson(Map<String, Object?> json) => _$ContentModelFromJson(json);
}

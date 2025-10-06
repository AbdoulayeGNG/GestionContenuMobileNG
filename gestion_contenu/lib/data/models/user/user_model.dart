import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';  // Généré par Freezed
part 'user_model.g.dart';        // Généré par json_serializable

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    @JsonKey(name: 'created_at') DateTime? createdAt,   // Assurez-vous d'utiliser @JsonKey si les noms diffèrent
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

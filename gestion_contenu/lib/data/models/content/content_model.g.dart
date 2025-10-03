// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentModel _$ContentModelFromJson(Map<String, dynamic> json) =>
    _ContentModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      authorId: json['authorId'] as String,
      tags: json['tags'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$ContentModelToJson(_ContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'authorId': instance.authorId,
      'tags': instance.tags,
      'category': instance.category,
    };

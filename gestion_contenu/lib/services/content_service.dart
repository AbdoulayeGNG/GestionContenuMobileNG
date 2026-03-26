import 'package:dio/dio.dart';
import 'package:gestioncontenu/models/content.dart';
import 'package:gestioncontenu/services/api_client.dart';

class ContentService {
  final ApiClient _client;
  ContentService(this._client);

  Future<List<ContentItem>> getContents({String? category, String? tag}) async {
    final query = <String, dynamic>{};
    if (category != null && category.isNotEmpty) query['category'] = category;
    if (tag != null && tag.isNotEmpty) query['tag'] = tag;
    final res = await _client.dio.get('/contents', queryParameters: query);
    final list = (res.data as List).cast<dynamic>();
    return list.map((e) => ContentItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ContentItem> getContentById(String id) async {
    final res = await _client.dio.get('/contents/$id');
    return ContentItem.fromJson(res.data as Map<String, dynamic>);
    }

  Future<ContentItem> createContent({
    required String title,
    required String description,
    required String image,
    required List<String> tags,
    required String category,
  }) async {
    final res = await _client.dio.post('/contents', data: {
      'title': title,
      'description': description,
      'image': image,
      'tags': tags,
      'category': category,
    });
    return ContentItem.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ContentItem> updateContent({
    required String id,
    required String title,
    required String description,
    required String image,
    required List<String> tags,
    required String category,
  }) async {
    final res = await _client.dio.put('/contents/$id', data: {
      'title': title,
      'description': description,
      'image': image,
      'tags': tags,
      'category': category,
    });
    return ContentItem.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteContent(String id) async {
    await _client.dio.delete('/contents/$id');
  }
}

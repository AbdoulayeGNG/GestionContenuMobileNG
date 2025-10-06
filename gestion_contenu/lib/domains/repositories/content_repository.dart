import 'package:gestioncontenu/domains/entities/content.dart';

abstract class ContentRepository {
  Future<List<Content>> getContents();
  Future<Content> getContent(int id);
  Future<Content> createContent(Map<String, dynamic> formData);
  Future<Content> editContent(Map<String, dynamic> formData, int id);
  Future<void> deleteContent(int id);
}

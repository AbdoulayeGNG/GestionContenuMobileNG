import 'package:gestioncontenu/data/datasources/content_remote_data_source.dart';
import 'package:gestioncontenu/data/mapper/content_mapper.dart';
import 'package:gestioncontenu/domains/entities/content.dart';
import 'package:gestioncontenu/domains/repositories/content_repository.dart';

class ContentRepositoryImpl extends ContentRepository {
  final ContentRemoteDataSource contentRemoteDataSource;

  ContentRepositoryImpl({required this.contentRemoteDataSource});
  @override
  Future<List<Content>> getContents() async {
    try {
      final contents = await contentRemoteDataSource.getContents();
      return contents
          .map((content) => ContentMapper.toEntity(content))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Content> getContent(int id) async {
    try {
      final content = await contentRemoteDataSource.getContent(id);
      return ContentMapper.toEntity(content);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Content> createContent(Map<String, dynamic> formData) async {
    try {
      final model = await contentRemoteDataSource.createContent(formData);
      return ContentMapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Content> editContent(Map<String, dynamic> formData, int id) async {
    try {
      final model = await contentRemoteDataSource.editContent(formData, id);
      return ContentMapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteContent(int id) async {
    try {contentRemoteDataSource.deleteContent(id);
    } catch (e) {
      rethrow;
    }
  }
}

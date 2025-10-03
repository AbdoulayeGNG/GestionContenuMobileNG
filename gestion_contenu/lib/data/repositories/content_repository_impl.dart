import 'package:gestioncontenu/data/datasources/content_remote_data_source.dart';
import 'package:gestioncontenu/data/models/content/content_model.dart';
import 'package:gestioncontenu/domains/entities/content.dart';
import 'package:gestioncontenu/domains/repositories/content_repository.dart';

class ContentRepositoryImpl extends ContentRepository {
  final ContentRemoteDataSource contentRemoteDataSource;

  ContentRepositoryImpl({required this.contentRemoteDataSource});
  @override
  Future<List<Content>> getContents() async {
    try {
      final contents = await contentRemoteDataSource.getContents();
      return contents.map((content) => _toEntity(content)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Content _toEntity(ContentModel model) {
    return Content(
        id: model.id,
        title: model.title,
        description: model.description,
        image: model.image,
        authorId: model.authorId,
        tags: model.tags,
        category: model.category);
  }
}

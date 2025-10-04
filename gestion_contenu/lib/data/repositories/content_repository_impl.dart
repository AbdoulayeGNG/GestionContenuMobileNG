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
      return contents.map((content) => ContentMapper.toEntity(content)).toList();
    } catch (e) {
      rethrow;
    }
  }

}

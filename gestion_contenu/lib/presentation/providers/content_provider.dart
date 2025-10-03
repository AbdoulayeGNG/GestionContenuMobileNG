import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestioncontenu/data/datasources/content_remote_data_source.dart';
import 'package:gestioncontenu/data/repositories/content_repository_impl.dart';
import 'package:gestioncontenu/presentation/providers/base_url_provider.dart';

final contentRemoteDataSourceProvider = Provider((ref){
  final dio = ref.watch(dioProvider);
  return ContentRemoteDataSource(dio);
});

final contentRepositoryProvider = Provider((ref){
  final repository = ref.watch(contentRemoteDataSourceProvider);
  return ContentRepositoryImpl(contentRemoteDataSource:repository);
});

final allContent = Provider((ref){
  final repo = ref.watch(contentRepositoryProvider);
  return repo.getContents();
});

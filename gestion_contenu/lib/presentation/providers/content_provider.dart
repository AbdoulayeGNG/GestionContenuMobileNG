import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestioncontenu/data/datasources/content_remote_data_source.dart';
import 'package:gestioncontenu/data/repositories/content_repository_impl.dart';
import 'package:gestioncontenu/domains/entities/content.dart';
import 'package:gestioncontenu/presentation/providers/base_url_provider.dart';

final contentRemoteDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ContentRemoteDataSource(dio);
});

final contentRepositoryProvider = Provider((ref) {
  final repository = ref.watch(contentRemoteDataSourceProvider);
  return ContentRepositoryImpl(contentRemoteDataSource: repository);
});

final allContentProvider = FutureProvider((ref) {});

class ContentNotifier extends AsyncNotifier<List<Content>> {
  String _filterCategory = '';
  @override
  FutureOr<List<Content>> build() {
    final repo = ref.watch(contentRepositoryProvider);
    return repo.getContents();
  }

  FutureOr<void> _rebuild() async {
    final repo = ref.watch(contentRepositoryProvider);
    final data = await repo.getContents();
    state = AsyncData(_applyFilters(data));
  }

  void setFilterCategory(String filter) {
    _filterCategory = filter;
    _rebuild();
  }

  List<Content> _applyFilters(List<Content> contents) {
    contents.map((content) {
      final filterCategory = _filterCategory.isEmpty ||
          content.category
              .toLowerCase()
              .contains(_filterCategory.toLowerCase());
      return filterCategory;
    }).toList();
    return contents;
  }

  Future<Content> createContent(Map<String, dynamic> data) async {
    try {
      final repo = ref.watch(contentRepositoryProvider);
      final content = await repo.createContent(data);
      return content;
    } catch (e) {
      rethrow;
    }
  }
  Future<Content> editContent(Map<String, dynamic> data, int id) async {
    try {
      final repo = ref.watch(contentRepositoryProvider);
      final content = await repo.createContent(data);
      return content;
    } catch (e) {
      rethrow;
    }
  }
}

final contentNotifierProvider =
    AsyncNotifierProvider<ContentNotifier, List<Content>>(ContentNotifier.new);

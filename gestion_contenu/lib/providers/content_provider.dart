import 'package:flutter/material.dart';
import 'package:gestioncontenu/models/content.dart';
import 'package:gestioncontenu/providers/auth_provider.dart';
import 'package:gestioncontenu/services/content_service.dart';

class ContentProvider extends ChangeNotifier {
  final ContentService _service;
  final AuthProvider _authProvider;

  ContentProvider(this._service, this._authProvider);

  List<ContentItem> _items = [];
  String _categoryFilter = '';
  String _tagFilter = '';
  bool _loading = false;

  List<ContentItem> get items => _items;
  bool get isLoading => _loading;
  String get categoryFilter => _categoryFilter;
  String get tagFilter => _tagFilter;

  bool canEdit(ContentItem item) => _authProvider.user?.role == 'editor' && _authProvider.user?.id == item.authorId;

  Future<void> fetch() async {
    _loading = true;
    notifyListeners();
    try {
      _items = await _service.getContents(
        category: _categoryFilter.isEmpty ? null : _categoryFilter,
        tag: _tagFilter.isEmpty ? null : _tagFilter,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void setCategoryFilter(String value) {
    _categoryFilter = value;
    fetch();
  }

  void setTagFilter(String value) {
    _tagFilter = value;
    fetch();
  }

  Future<void> create(ContentItem draft) async {
    final created = await _service.createContent(
      title: draft.title,
      description: draft.description,
      image: draft.image,
      tags: draft.tags,
      category: draft.category,
    );
    _items = [created, ..._items];
    notifyListeners();
  }

  Future<void> update(ContentItem draft) async {
    final updated = await _service.updateContent(
      id: draft.id,
      title: draft.title,
      description: draft.description,
      image: draft.image,
      tags: draft.tags,
      category: draft.category,
    );
    final idx = _items.indexWhere((e) => e.id == updated.id);
    if (idx != -1) {
      _items[idx] = updated;
      notifyListeners();
    }
  }

  Future<void> remove(String id) async {
    await _service.deleteContent(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}

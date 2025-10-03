import 'dart:convert';

class ContentItem {
  final String id;
  final String title;
  final String description;
  final String image; // URL or file path per backend
  final String authorId;
  final List<String> tags; // enum values as strings
  final String category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.authorId,
    required this.tags,
    required this.category,
    this.createdAt,
    this.updatedAt,
  });

  ContentItem copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? authorId,
    List<String>? tags,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ContentItem(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        authorId: authorId ?? this.authorId,
        tags: tags ?? this.tags,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'authorId': authorId,
        'tags': tags,
        'category': category,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    DateTime? parseDT(dynamic v) {
      if (v == null) return null;
      if (v is int) {
        return DateTime.fromMillisecondsSinceEpoch(
            v > 1000000000000 ? v : v * 1000,
            isUtc: true);
      }
      if (v is String) return DateTime.tryParse(v);
      return null;
    }

    return ContentItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      authorId: json['authorId']?.toString() ?? '',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      category: json['category']?.toString() ?? '',
      createdAt: parseDT(json['createdAt']),
      updatedAt: parseDT(json['updatedAt']),
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}

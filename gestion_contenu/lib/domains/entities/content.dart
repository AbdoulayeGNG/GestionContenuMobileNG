class Content {
  final int id;
  final String title;
  final String? description;
  final String? image; // URL or file path per backend
  final String authorId;
  final String? tags; // enum values as strings
  final String category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Content({
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
}
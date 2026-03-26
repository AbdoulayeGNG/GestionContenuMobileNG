import 'dart:convert';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role; // 'viewer' | 'editor'
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '${firstName.trim()} ${lastName.trim()}'.trim();

  AppUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': role,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    DateTime? parseDT(dynamic v) {
      if (v == null) return null;
      if (v is int) {
        // unix seconds or ms
        return DateTime.fromMillisecondsSinceEpoch(
            v > 1000000000000 ? v : v * 1000,
            isUtc: true);
      }
      if (v is String) return DateTime.tryParse(v);
      return null;
    }

    return AppUser(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? 'viewer',
      createdAt: parseDT(json['createdAt']),
      updatedAt: parseDT(json['updatedAt']),
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}

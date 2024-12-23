// /models/user_model.dart

class User {
  final String id; // Unique user ID
  final String name; // User's full name
  final String email; // User's email address
  final String? profileImageUrl; // Optional profile picture
  final DateTime createdAt; // When the user was created

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.createdAt,
  });

  // Convert User object to Map (useful for storage or APIs)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImageUrl: map['profileImageUrl'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

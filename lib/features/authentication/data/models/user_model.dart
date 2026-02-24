class UserModel {
  final String email;
  final String name;
  final String avatarInitial;
  final DateTime createdAt;

  UserModel({
    required this.email,
    required this.name,
    required this.avatarInitial,
    required this.createdAt,
  });

  factory UserModel.fromSignUp({
    required String email,
    required String name,
  }) {
    return UserModel(
      email: email,
      name: name,
      avatarInitial: name.isNotEmpty ? name[0].toUpperCase() : '?',
      createdAt: DateTime.now(),
    );
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? avatarInitial,
    DateTime? createdAt,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      avatarInitial: avatarInitial ?? this.avatarInitial,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
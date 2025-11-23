class UserDetailsModel {
  final int id;
  final String userName;
  final String email;
  final String name;
  final String photoUrl;
  final String createdAt;
  final String lastActive;
  late bool isFollowing;
  late int following;
  late int followers;
  final int streak;
  final int totalXp;
  final int weekXp;
  final bool streakActive;

  UserDetailsModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.createdAt,
    required this.lastActive,
    required this.isFollowing,
    required this.following,
    required this.followers,
    required this.streak,
    required this.totalXp,
    required this.weekXp,
    required this.streakActive,
  });

  factory UserDetailsModel.toModel(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] ?? 0,
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      lastActive: json['lastActive'] ?? '',
      following: json['following'] ?? 0,
      followers: json['followers'] ?? 0,
      streak: json['streak'] ?? 0,
      totalXp: json['totalXp'] ?? 0,
      weekXp: json['weekXp'] ?? 0,
      streakActive: json['streakActive'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
    );
  }
}

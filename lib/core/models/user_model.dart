class UserModel {
  final String name;
  final String userId;
  final String gender;
  final String? image;
  final String? badge;

  UserModel({
    required this.name,
    required this.userId,
    required this.gender,
    required this.image,
    required this.badge,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      userId: json['userId'],
      gender: json['gender'],
      image: json['image'] ?? '',
      badge: json['badge'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userId': userId,
      'gender': gender,
      'image': image,
      'badge': badge
    };
  }
}

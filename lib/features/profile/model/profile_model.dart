class ProfileModel {
  String name;
  String id;
  String image;
  String gender;
  int? achievements;

  ProfileModel({
    required this.name,
    required this.id,
    required this.image,
    required this.gender,
    required this.achievements,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      id: json['userId'],
      image: json['image'] ?? '',
      gender: json['gender'],
      achievements: json['achievements'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'image': image,
      'gender': gender,
      'achievements': achievements,
    };
  }
}

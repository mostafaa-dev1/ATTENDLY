class HomeStudentModel {
  String name;
  final String id;
  final String gender;
  String? image;
  final String? badge;
  final String level;
  final String department;
  String? token;
  String? bio;
  bool isAdmin;
  bool isSuperAdmin;
  bool isBlocked;
  bool? hideScore;
  int? score;

  HomeStudentModel(
      {required this.name,
      required this.id,
      required this.gender,
      required this.image,
      this.badge,
      required this.isAdmin,
      required this.isBlocked,
      required this.level,
      required this.department,
      required this.isSuperAdmin,
      required this.token,
      this.bio,
      this.hideScore,
      this.score});

  factory HomeStudentModel.fromJson(Map<String, dynamic> json) {
    return HomeStudentModel(
      name: json['name'],
      id: json['id'],
      gender: json['gender'],
      image: json['image'],
      badge: json['badge'],
      isAdmin: json['isAdmin'],
      isBlocked: json['isBlocked'],
      level: json['level'],
      department: json['department'],
      isSuperAdmin: json['isSuperAdmin'],
      token: json['token'],
      bio: json['bio'],
      hideScore: json['hideScore'] ?? false,
      score: json['score'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'gender': gender,
      'image': image,
      'badge': badge,
      'isAdmin': isAdmin,
      'isBlocked': isBlocked,
      'level': level,
      'department': department,
      'isSuperAdmin': isSuperAdmin,
      'token': token,
      'bio': bio,
      'hideScore': hideScore,
      'score': score
    };
  }
}

class StudentModel {
  String? name;
  String? id;
  String? gender;
  int? attendance;
  List<dynamic>? dates = [];
  String? date;

  StudentModel(
      {this.gender,
      this.name,
      this.id,
      this.attendance,
      this.dates,
      this.date});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        name: json['name'],
        id: json['id'],
        attendance: json['attendance'] ?? 0,
        gender: json['gender'],
        dates: json['dates'] ?? [],
        date: json['date'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'attendance': attendance,
      'gender': gender,
      'dates': dates,
    };
  }
}

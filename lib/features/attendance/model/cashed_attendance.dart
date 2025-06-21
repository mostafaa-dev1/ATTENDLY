class CashedAttendance {
  String name;
  String id;
  String date;
  String gender;
  CashedAttendance({
    required this.name,
    required this.id,
    required this.date,
    required this.gender,
  });

  factory CashedAttendance.fromJson(Map<String, dynamic> json) {
    return CashedAttendance(
      name: json['name'],
      id: json['id'],
      date: json['date'],
      gender: json['gender'],
    );
  }
}

class ListCashedAttendance {
  List<CashedAttendance> students;
  ListCashedAttendance({required this.students});

  factory ListCashedAttendance.fromJson(List<Map<String, dynamic>> json) {
    return ListCashedAttendance(
      students: json.map((e) => CashedAttendance.fromJson(e)).toList(),
    );
  }
}

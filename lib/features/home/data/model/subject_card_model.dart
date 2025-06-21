class SubjectCardModel {
  final String name;
  final String doctor;
  final String level;
  int open;
  final String day;
  final String start;
  final String end;
  final String passcode;
  bool isActive = false;

  SubjectCardModel(
      {required this.name,
      required this.doctor,
      required this.level,
      required this.open,
      required this.day,
      required this.passcode,
      required this.start,
      required this.end});

  factory SubjectCardModel.fromJson(Map<String, dynamic> json) {
    return SubjectCardModel(
      name: json['name'],
      doctor: json['doctor'],
      level: json['level'],
      open: json['open'],
      day: json['day'],
      passcode: json['passcode'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'doctor': doctor,
      'level': level,
    };
  }
}

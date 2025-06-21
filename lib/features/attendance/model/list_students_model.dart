import 'package:academe_mobile_new/features/attendance/model/student_model.dart';

class ListStudentsModel {
  List<StudentModel> students;
  ListStudentsModel({required this.students});

  factory ListStudentsModel.fromJson(List<Map<String, dynamic>> json) {
    return ListStudentsModel(
      students: json.map((e) => StudentModel.fromJson(e)).toList(),
    );
  }
}

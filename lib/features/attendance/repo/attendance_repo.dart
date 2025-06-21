import 'package:academe_mobile_new/core/helpers/error_handler.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:dartz/dartz.dart';

abstract class AttendanceRepostory {
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudents({
    SubjectCardModel? subjectCardModel,
  });
}

import 'package:academe_mobile_new/core/helpers/error_handler.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:academe_mobile_new/features/attendance/repo/attendance_repo.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:dartz/dartz.dart';

class AttendanceData extends AttendanceRepostory {
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudents(
      {SubjectCardModel? subjectCardModel}) async {
    try {
      final response = await FirebaseServices.readDataByCollection(
          subjectCardModel!.level, subjectCardModel.passcode, 'Students');
      if (response.isNotEmpty) {
        return Right(response);
      }
      return Left(Failure('No Students Available'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // static Future<List<Map<String, dynamic>>> getStudents({
  //   required String subjectiId,
  //   required String level,
  // }) async {
  //   var response = await FirebaseServices.readDataByCollection(
  //       level, subjectiId, 'Students');
  //   return response;
  // }
}

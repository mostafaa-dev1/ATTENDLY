import 'package:academe_mobile_new/core/helpers/error_handler.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepostory {
  Future<Either<Failure, List<Map<String, dynamic>>>> getSubjects({
    required String level,
  });
  // Future<Either<Failure, List<Map<String, dynamic>>>> getTops();
  Future<Either<Failure, List<Map<String, dynamic>>>> getCashedSubjects();
  Future<Either<Failure, Map<String, dynamic>>> getPersonalData({
    required String id,
  });
}

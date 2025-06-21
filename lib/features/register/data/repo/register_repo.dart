import 'package:academe_mobile_new/core/helpers/error_handler.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<Either<Failure, void>> isFoundUser({required String id});

  Future<Either<Failure, void>> register(
      {required Map<String, dynamic> firebaseData,
      required Map<String, dynamic> supabaseData});
}

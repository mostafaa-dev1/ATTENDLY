import 'dart:developer';

import 'package:academe_mobile_new/core/helpers/connectivity.dart';
import 'package:academe_mobile_new/core/helpers/error_handler.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:academe_mobile_new/features/register/data/repo/register_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterData extends RegisterRepository {
  @override
  Future<Either<Failure, void>> isFoundUser({required String id}) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      return Left(Failure('No internet connection'));
    } else {
      try {
        var response = await FirebaseServices.readDataById('AppUsers', id);
        if (response.exists) {
          return Left(Failure('User is exist try to login'));
        } else {
          return const Right(null);
        }
      } catch (e) {
        return Left(Failure('Something went wrong exist'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> register(
      {required Map<String, dynamic> firebaseData,
      required Map<String, dynamic> supabaseData}) async {
    try {
      await _setFirebaseData('AppUsers', firebaseData);
      // await setData('Users', supabaseData);
      // await setData('Profile', supabaseData['userId']);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // Future<Either<Failure, Map<String, dynamic>>> setData(
  //     String table, var data) async {
  //   try {
  //     var response = await SupabaseServices.setData(table, data);
  //     return Right(response);
  //   } catch (e) {
  //     return Left(Failure(e.toString()));
  //   }
  // }

  Future<Either<Failure, void>> _setFirebaseData(
      String collection, Map<String, dynamic> data) async {
    log('response1');
    try {
      var response =
          await FirebaseServices.addData(data, collection, data['userId']);
      log('response1');
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

import 'package:academe_mobile_new/core/helpers/connectivity.dart';
import 'package:academe_mobile_new/core/helpers/error_handler.dart';
import 'package:academe_mobile_new/core/networking/local_database/sql.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:academe_mobile_new/features/home/data/repo/home_repostory.dart';
import 'package:dartz/dartz.dart';

class HomeData extends HomeRepostory {
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getSubjects(
      {required String level}) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      return Left(Failure('No Internet Connection'));
    } else {
      try {
        final response = await FirebaseServices.readData(level);
        if (response.isNotEmpty) {
          return Right(response);
        } else {
          return Left(Failure('No Subjects Available'));
        }
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    }
  }

  @override
  // Future<Either<Failure, List<Map<String, dynamic>>>> getTops() async {
  //   if (!await ConnectivityHelper.checkConnctivity()) {
  //     return Left(Failure('No Internet Connection'));
  //   } else {
  //     try {
  //       final response =
  //           await SupabaseServices.getDataWithLimit('Tops', '*,Users(*)');
  //       if (response.isNotEmpty) {
  //         response.sort((a, b) => b['points'].compareTo(a['points']));
  //         return Right(response);
  //       } else {
  //         return Left(Failure('No Tops Available'));
  //       }
  //     } catch (e) {
  //       return Left(Failure(e.toString()));
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
      getCashedSubjects() async {
    try {
      final response = await Sqldb().readData('SELECT * FROM subjects');
      if (response.isNotEmpty && response != null) {
        return Right(response);
      } else {
        return Left(Failure('No Subjects Available'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPersonalData({
    required String id,
  }) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      return Left(Failure('No Internet Connection'));
    } else {
      try {
        final respons = await FirebaseServices.readDataById('AppUsers', id);
        if (respons.exists) {
          return Right(respons.data()!);
        } else {
          return Left(Failure('No Data Available'));
        }
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    }
  }

  Future<Either<String, String>> getVersion() async {
    try {
      final response = await FirebaseServices.readDataById('AppVersion', 'v2');
      return Right(response.data()!['version']);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

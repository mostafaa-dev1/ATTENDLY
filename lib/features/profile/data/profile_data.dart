import 'dart:io';

import 'package:academe_mobile_new/core/helpers/connectivity.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileData {
  static Future<Either<String, DocumentSnapshot<Map<String, dynamic>>>>
      getProfileData(String id, String table) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      return const Left("No internet connection");
    } else {
      try {
        var profile = await FirebaseServices.readDataById(table, id);
        if (profile.data() == null) {
          return const Left("Something went wrong");
        }
        return right(profile);
      } catch (e) {
        return const Left("Something went wrong");
      }
    }
  }

  static Future<Either<String, String>> uploadProfileImage(XFile image) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      return const Left("No internet connection");
    } else {
      try {
        final storageRef = FirebaseStorage.instance.ref();
        Reference ref =
            storageRef.child('ProfileImages/${image.path.split('/').last}');
        await ref.putFile(File(image.path));
        String url = await ref.getDownloadURL();
        return right(url);
      } catch (e) {
        return const Left("Something went wrong");
      }
    }
  }

  static Future<Either<String, void>> updateProfileData({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      return const Left("No internet connection");
    } else {
      try {
        await FirebaseServices.updateData(data, 'AppUsers', id);
        return const Right(null);
      } catch (e) {
        return const Left("Something went wrong");
      }
    }
  }
}

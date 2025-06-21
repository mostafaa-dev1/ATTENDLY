import 'dart:developer';

import 'package:academe_mobile_new/core/models/student_model.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/networking/local_database/sql.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:academe_mobile_new/core/notifications/notifications_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController idController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> login(
      String id, bool isUpdateToken, Map<String, dynamic> data) async {
    emit(LoginLoading());
    await getData(idController.text).then((v) async {
      if (isUpdateToken) {
        await updateToken(idController.text);
      }
      CashHelper.putString(key: 'id', value: idController.text);
      await subscribe();
      emit(LoginSuccess());
    });
  }

  Future<void> subscribe() async {
    await subscribeToTopic('all');
    await subscribeToTopic(student.department);
  }

  Future<void> subscribeToTopic(String topic) async {
    await NotificationsHelper().subscribeToTopic(topic);
  }

  // void caculateLevel(String id) {
  //   if (department == 'CS' || department == 'IS') {
  //     level = id[1] == '1'
  //         ? 'Level4'
  //         : id[1] == '2'
  //             ? 'Level3'
  //             : id[1] == '3'
  //                 ? 'Level2'
  //                 : 'Level1';
  //   } else {
  //     return;
  //   }
  // }
  HomeStudentModel student = HomeStudentModel(
    id: '',
    name: '',
    gender: '',
    image: '',
    department: '',
    level: '',
    isAdmin: false,
    isBlocked: false,
    isSuperAdmin: false,
    token: '',
  );
  Future<void> getData(String id) async {
    await FirebaseServices.readDataById('AppUsers', id).then((value) {
      student = HomeStudentModel.fromJson(value.data()!);
      saveCashedData(student);
    }).catchError((onError) {
      log(onError);
      emit(GetDataErorrState(
        error: 'Something went wrong, please try again',
      ));
    });
  }

  void saveCashedData(HomeStudentModel data) {
    CashHelper.putBool(key: 'logged', value: true);
    CashHelper.putString(key: 'id', value: data.id);
    CashHelper.putString(key: 'level', value: data.level);
    CashHelper.putString(key: 'name', value: data.name);
    CashHelper.putString(key: 'gender', value: data.gender);
    CashHelper.putString(key: 'image', value: data.image!);
    CashHelper.putString(key: 'department', value: data.department);
    CashHelper.putBool(key: 'isAdmin', value: data.isAdmin);
    CashHelper.putBool(key: 'isBlocked', value: data.isBlocked);
    CashHelper.putBool(key: 'isSuperAdmin', value: data.isSuperAdmin);
    CashHelper.putString(key: 'today', value: '');
    Sqldb().deleteAllRows('subjects');
  }

  Future<void> updateToken(String id) async {
    emit(UpdateLoading());
    String? token = await NotificationsHelper().getToken();
    await FirebaseServices.updateData({
      'token': token,
    }, 'AppUsers', id)
        .then((value) {
      emit(UpdateSuccess());
    }).catchError((onError) {
      emit(UpdateErorr(error: 'Update failed, please try again'));
    });
  }

  void isThisdeviceSignedIn() async {
    emit(SignedInLoading());
    String? token = await NotificationsHelper().getToken();

    await FirebaseServices.readDataById('AppUsers', idController.text)
        .then((value) async {
      if (value.exists) {
        if (value['isBlocked'] == true) {
          emit(LoginErorr(error: 'Your account is blocked'));
        } else {
          if (value['token'] != token) {
            login(idController.text, true, value.data()!);
          } else {
            login(idController.text, false, value.data()!);
          }
        }
      } else {
        emit(LoginErorr(error: 'User not found, please try again'));
      }
    }).catchError((onError) {
      emit(GetDataErorrState(
        error: 'Your ID or Username is not correct, please try again',
      ));
    });
  }

  String diffrence(DateTime date) {
    Duration duration =
        date.add(const Duration(hours: 1)).difference(DateTime.now());

    int minutes = duration.inMinutes;

    return 'You can login after ${minutes != 0 ? '$minutes minutes' : ''}';
  }
}

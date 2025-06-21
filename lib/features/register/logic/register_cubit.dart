import 'package:academe_mobile_new/core/models/student_model.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/networking/local_database/sql.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:academe_mobile_new/core/notifications/notifications_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  String gender = '';
  String department = '';
  String level = '';
  var formKey = GlobalKey<FormState>();

  void isIdfound() async {
    emit(IsIdFoundLoading());
    FirebaseServices.readDataById('AppUsers', idController.text)
        .then((value) async {
      if (value.exists) {
        emit(RegisterErorr(error: 'User is already exist, try to login'));
      } else {
        await register();
      }
    });
  }

  HomeStudentModel student = HomeStudentModel(
    name: '',
    id: '',
    gender: '',
    image: '',
    badge: '',
    department: '',
    level: '',
    isAdmin: false,
    isSuperAdmin: false,
    isBlocked: false,
    token: '',
  );
  Future<void> register() async {
    emit(RegisterLoading());
    String? token = await NotificationsHelper().getToken();
    await setFirebaseData(
      'AppUsers',
      idController.text,
      HomeStudentModel(
        name: nameController.text,
        id: idController.text,
        gender: gender,
        image: '',
        badge: '',
        isAdmin: false,
        isBlocked: false,
        level: level,
        department: department + level,
        isSuperAdmin: false,
        token: token ?? '',
        bio: '',
        score: 0,
        hideScore: false,
      ).toJson(),
    );

    student = HomeStudentModel(
      name: nameController.text,
      id: idController.text,
      gender: gender,
      image: '',
      badge: '',
      department: department + level,
      level: level,
      isAdmin: false,
      isSuperAdmin: false,
      isBlocked: false,
      token: token ?? '',
      bio: '',
      score: 0,
      hideScore: false,
    );

    // await setData('Users', {
    //   'name': name,
    //   'userId': id,
    //   'gender': gender,
    //   'department': department,
    // });
    // await setData('Profile', {
    //   'userId': id,
    // });
    saveCashedData();
    await subscribeToTopic(['all', department + level]);
    emit(RegisterSuccess());
  }

  void saveCashedData() {
    CashHelper.putBool(key: 'logged', value: true);
    CashHelper.putString(key: 'id', value: idController.text);
    CashHelper.putString(key: 'name', value: nameController.text);
    CashHelper.putString(key: 'gender', value: gender);
    CashHelper.putString(key: 'department', value: department + level);
    CashHelper.putString(key: 'level', value: level);
    CashHelper.putBool(key: 'isAdmin', value: false);
    CashHelper.putBool(key: 'isSuperAdmin', value: false);
    CashHelper.putBool(key: 'isBlocked', value: false);
    CashHelper.putString(key: 'today', value: '');
    Sqldb().deleteAllRows('subjects');
  }

  // String formatLevel(String level) {
  //   String formatedlevel = level == 'Level 1'
  //       ? 'Level1'
  //       : level == 'Level 2'
  //           ? 'Level2'
  //           : level == 'Level 3'
  //               ? 'Level3'
  //               : 'Level4';
  //   return formatedlevel;
  // }

  Future<void> subscribeToTopic(List<String> topic) async {
    for (int i = 0; i < topic.length; i++) {
      await NotificationsHelper().subscribeToTopic(topic[i]);
    }
  }

  // Future<void> setData(String table, Map<String, dynamic> data) async {
  //   await SupabaseServices.setData(table, data).catchError((onError) {
  //     emit(RegisterErorr(
  //         error: 'Something went wrong in your information, please try again'));
  //   });
  // }

  Future<void> setFirebaseData(
      String collection, String id, Map<String, dynamic> data) async {
    await FirebaseServices.addData(data, collection, id).catchError((onError) {
      emit(RegisterErorr(
          error: 'Something went wrong in your information, please try again'));
    });
  }

  String diffrence(DateTime date) {
    Duration duration =
        date.add(const Duration(hours: 1)).difference(DateTime.now());

    int minutes = duration.inMinutes;

    return 'You can login after ${minutes != 0 ? '$minutes minutes' : ''}';
  }
}

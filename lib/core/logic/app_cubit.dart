import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:academe_mobile_new/core/Constants/data.dart';
import 'package:academe_mobile_new/core/helpers/connectivity.dart';
import 'package:academe_mobile_new/core/helpers/excel_funcs.dart';
import 'package:academe_mobile_new/core/helpers/shared_functions.dart';
import 'package:academe_mobile_new/core/models/student_model.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/networking/local_database/sql.dart';
import 'package:academe_mobile_new/core/networking/remote_database/firebase/firebase_services.dart';
import 'package:academe_mobile_new/core/notifications/local_notifications.dart';
import 'package:academe_mobile_new/core/notifications/notifications_helper.dart';
import 'package:academe_mobile_new/features/attendance/data/attendance_data.dart';
import 'package:academe_mobile_new/features/attendance/model/list_students_model.dart';
import 'package:academe_mobile_new/features/attendance/model/student_model.dart';
import 'package:academe_mobile_new/features/home/data/home_data/data.dart';
import 'package:academe_mobile_new/features/home/data/model/card_model.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:academe_mobile_new/features/profile/data/profile_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';
import 'package:permission_handler/permission_handler.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(HomeInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  Sqldb sqldb = Sqldb();
  //////////// Home \\\\\\\\\\\\
  HomeStudentModel? student;
  String version = 'V2';

  Future<void> init() async {
    student = HomeStudentModel(
      id: CashHelper.getString(key: 'id') ?? '',
      name: CashHelper.getString(key: 'name') ?? '',
      image: CashHelper.getString(key: 'image') ?? '',
      badge: CashHelper.getString(key: 'badge') ?? '',
      gender: CashHelper.getString(key: 'gender') ?? '',
      isAdmin: CashHelper.getBool(key: 'isAdmin') ?? false,
      isBlocked: CashHelper.getBool(key: 'isBlocked') ?? false,
      level: CashHelper.getString(key: 'level') ?? '',
      department: CashHelper.getString(key: 'department') ?? '',
      isSuperAdmin: CashHelper.getBool(key: 'isSuperAdmin') ?? false,
      token: CashHelper.getString(key: 'token') ?? '',
    );
  }

  Future<void> getHomeData(bool isOnline) async {
    if (student!.department == 'Lecturer') {
      await getLecturerData(
        student!.id,
      );
    } else {
      await getSubjects(student!.department, student!.id, isOnline);
    }
  }

  CardModel cardModel = CardModel(cards: []);
  Future<void> getSubjects(String level, String id, bool ignoreOffline) async {
    String currentDate = DateTime.now().toString().split(' ')[0];
    String? lastFetchDate = CashHelper.getString(key: 'today');
    if (lastFetchDate == currentDate && !ignoreOffline) {
      debugPrint('Cashed');
      getCashedSubjects();
    } else {
      emit(GetDataLoadingState());
      final response = await HomeData().getSubjects(level: level);
      response.fold((l) {
        emit(GetDataErrorState(
          l.message,
        ));
        getCashedSubjects();
      }, (r) async {
        cardModel = CardModel.fromJson(r);

        for (var data in r) {
          await Sqldb().insertORReplaceData(data);
        }
        CashHelper.putString(key: 'today', value: currentDate);
        emit(GetDataSuccessState());
        await secheduleNotification(cardModel.cards);
        getPersonalData(id);
      });
    }
  }

  Future<void> getLecturerData(String id) async {
    if (!await ConnectivityHelper.checkConnctivity()) {
      emit(GetDataErrorState('No Internet Connection'));
      getCashedSubjects();
      return;
    }
    emit(GetDataLoadingState());
    cardModel = CardModel(cards: []);
    await FirebaseServices.readDataById('Lecturers', id).then((value) async {
      if (value.exists) {
        student = HomeStudentModel.fromJson({
          'id': value.data()!['id'],
          'name': value.data()!['name'],
          'image': '',
          'gender': value.data()!['gender'],
          'isAdmin': false,
          'isBlocked': false,
          'level': '',
          'department': 'Lecturer',
          'isSuperAdmin': true,
          'token': '',
          'bio': '',
          'badge': '',
          'hideScore': false
        });
        saveCashedData(student!);
        for (var subject in value.data()!['subjects']) {
          await getLecturerSubjects(subject['level'], subject['passcode']);
        }
        emit(GetDataSuccessState());
      } else {
        getCashedSubjects();
        emit(GetDataErrorState(
          'Passcode is incorrect, please try again',
        ));
      }
    });
  }

  Future<void> getLecturerSubjects(String level, String passcode) async {
    await FirebaseServices.readDataById(level, passcode).then((value) async {
      cardModel.cards.add(SubjectCardModel.fromJson(value.data()!));
      await Sqldb().insertORReplaceData(value.data()!);
    }).catchError((error) {
      emit(GetDataErrorState(error.toString()));
    });
  }

  Future<void> secheduleNotification(List<SubjectCardModel> cards) async {
    String sechedule = CashHelper.getString(key: 'schedule') ?? '';
    if (sechedule == '' ||
        DateTime.now().difference(DateTime.parse(sechedule)).inDays >= 7) {
      String message = randomMessage(SharedFunctions.split(student!.name));
      for (int i = 0; i < cards.length; i++) {
        await LocalNotifications.notification(
          DateTime.now(),
          cards[i].start,
          cards[i].end,
          cards[i].day,
          i,
          cards[i].name,
          message,
        );
      }
      CashHelper.putString(key: 'schedule', value: DateTime.now().toString());
    }
  }

  String randomMessage(String name) {
    Random random = Random();
    List<String> randomMessages = ConstantsData.randomMessages(name);
    return randomMessages[random.nextInt(5)];
  }

  Future<void> getCashedSubjects() async {
    emit(GetDataLoadingState());
    final response = await HomeData().getCashedSubjects();
    response.fold((l) {
      emit(GetDataErrorState(
        l.message,
      ));
    }, (r) {
      cardModel = CardModel.fromJson(r);
      emit(GetDataSuccessState());
    });
  }

  Future<void> getPersonalData(String id) async {
    emit(GetPersonalDataLoadingState());
    final response = await HomeData().getPersonalData(id: id);
    response.fold((l) {
      emit(GetPersonalDataErrorState(
        l.message,
      ));
    }, (r) {
      student = HomeStudentModel.fromJson(r);
      saveCashedData(student!);
      getVersion();
      emit(GetPersonalDataSuccessState());
    });
  }

  void saveCashedData(HomeStudentModel data) {
    CashHelper.putString(key: 'level', value: data.level);
    CashHelper.putString(key: 'name', value: data.name);
    CashHelper.putString(key: 'gender', value: data.gender);
    CashHelper.putString(key: 'image', value: data.image!);
    CashHelper.putString(key: 'department', value: data.department);
    CashHelper.putBool(key: 'isAdmin', value: data.isAdmin);
    CashHelper.putBool(key: 'isBlocked', value: data.isBlocked);
    CashHelper.putBool(key: 'isSuperAdmin', value: data.isSuperAdmin);
  }

  void getVersion() async {
    final response = await HomeData().getVersion();
    response.fold((l) {
      emit(GetVersionErrorState(
        l,
      ));
    }, (r) {
      version = r;
      CashHelper.putString(key: 'version', value: r);
      emit(GetVersionSuccessState(r));
    });
  }

  DateTime? realTime;
  Future<DateTime> getRealTime() async {
    DateTime realTime = await NTP.now();
    return realTime;
  }

  bool isNowLecturer({required SubjectCardModel card}) {
    DateTime now = DateTime.now();

    final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(card.start.split(':')[0]),
        int.parse(card.start.split(':')[1]));
    final endDateTime = DateTime(now.year, now.month, now.day,
        int.parse(card.end.split(':')[0]), int.parse(card.end.split(':')[1]));

    return now.isAfter(startDateTime) &&
        now.isBefore(endDateTime.add(const Duration(minutes: 20)));
  }

  bool isCurrentTimeBetween(SubjectCardModel card, DateTime realTime) {
    final now = realTime;

    final daysOfWeek = {
      "MON": 1,
      "TUE": 2,
      "WED": 3,
      "THU": 4,
      "FRI": 5,
      "SAT": 6,
      "SUN": 7
    };

    if (daysOfWeek[card.day] != now.weekday) {
      return false;
    }

    final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(card.start.split(':')[0]),
        int.parse(card.start.split(':')[1]));
    final endDateTime = DateTime(now.year, now.month, now.day,
        int.parse(card.end.split(':')[0]), int.parse(card.end.split(':')[1]));

    return now.isAfter(startDateTime) &&
        now.isBefore(endDateTime.add(const Duration(minutes: 20)));
  }

  Map<String, dynamic> studnetAttendance = {};

  void getStudentsAttendance(String level, String pass, String id) {
    emit(GetStudentsAttendanceLoadingState());
    studnetAttendance = {};
    FirebaseServices.readDataByCollectionandSubCollection(
            level, pass, 'Students', id)
        .then((value) {
      if (value!.exists) {
        studnetAttendance = value.data()!;
      } else {
        emit(GetStudentsAttendanceErrorState(
          'No data found',
        ));
      }
      emit(GetStudentsAttendanceSuccessState());
    }).catchError((onError) {
      emit(GetStudentsAttendanceErrorState(
        'No data found',
      ));
    });
  }

  Map<String, dynamic> attendanceLength = {};
  void addAttendanceLength(int size, String passcode) {
    attendanceLength.addAll({passcode: size});
    CashHelper.putInt(key: '${passcode}Length', value: size);
    emit(AddAttendanceLengthSuccessState());
  }

  void openSubjects(String level, String pass, bool value, int index) {
    emit(OpenSubjectsLoadingState());
    FirebaseServices.updateData({'open': value == true ? 1 : 0}, level, pass)
        .then((value2) {
      cardModel.cards[index].open = value ? 1 : 0;
      sqldb
          .updateData(
              'subjects', pass, {'open': value == true ? 1 : 0}, 'passcode')
          .then((value) {
        getCashedSubjects();
      });
    });
    emit(OpenSubjectsSuccessState());
  }

  HomeStudentModel profileData = HomeStudentModel(
    name: '',
    id: '',
    image: '',
    gender: '',
    badge: '',
    level: '',
    department: '',
    isAdmin: false,
    isBlocked: false,
    isSuperAdmin: false,
    token: '',
    bio: '',
  );
  Future<void> getProfileData(String id, bool lecturer) async {
    emit(GetProfileDataLoadingState());
    if (lecturer) {
      profileData = student!;
      emit(GetProfileDataSuccessState());
    } else {
      var data = await ProfileData.getProfileData(id, 'AppUsers');
      data.fold((error) {
        emit(GetProfileDataErrorState(error));
      }, (value) {
        if (id == student!.id) {
          profileData = HomeStudentModel.fromJson(value.data()!);
          student = HomeStudentModel.fromJson(value.data()!);
          emit(GetProfileDataSuccessState());
          CashHelper.putString(key: 'name', value: value['name']);
          CashHelper.putString(key: 'id', value: value['id']);
          CashHelper.putString(key: 'image', value: value['image'] ?? '');
          CashHelper.putString(key: 'gender', value: value['gender']);
          CashHelper.putString(key: 'badge', value: value['badge'] ?? '');
          CashHelper.putString(key: 'level', value: value['level'] ?? '');
          CashHelper.putString(
              key: 'department', value: value['department'] ?? '');
          CashHelper.putBool(key: 'isAdmin', value: value['isAdmin'] ?? false);
          CashHelper.putBool(
              key: 'isSuperAdmin', value: value['isSuperAdmin'] ?? false);
          CashHelper.putBool(
              key: 'isBlocked', value: value['isBlocked'] ?? false);
          CashHelper.putString(key: 'bio', value: value['bio'] ?? '');
        } else {
          profileData = HomeStudentModel.fromJson(value.data()!);
        }
        emit(GetProfileDataSuccessState());
      });
    }
  }

  Future<void> updateProfileData(
      Map<String, dynamic> data, bool isImage, String id) async {
    emit(UpdateProfileDataLoadingState());

    var result =
        await ProfileData.updateProfileData(data: data, id: id.toString());
    result.fold((error) {
      emit(UpdateProfileDataErrorState(error));
    }, (value) {
      CashHelper.putString(key: 'image', value: data['image'] ?? '');
      student!.image = data['image'] ?? '';
      if (id == student!.id) {
        profileData.image = data['image'] ?? '';
      }
      emit(UpdateProfileDataSuccessState());
    });
  }

  Future<void> uploadProfileImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(UpdateProfileImageLoadingState());
      // selectedImage = File(image.path);
      var result = await ProfileData.uploadProfileImage(image);
      result.fold((error) {
        emit(UpdateProfileImageErrorState(error));
      }, (value) async {
        await updateProfileData({'image': value}, true, student!.id);
        student!.image = value;
        emit(UpdateProfileImageSuccessState());
      });
    }
  }

  //////////// Attendance \\\\\\\\\\\\

  ListStudentsModel? studentsModel = ListStudentsModel(students: []);
  Future<void> getStudents(SubjectCardModel subjectCardModel) async {
    emit(GetStudentsLoadingState());
    final data =
        await AttendanceData().getStudents(subjectCardModel: subjectCardModel);
    data.fold((l) {
      emit(GetStudentsErrorState(
        l.message,
      ));
    }, (r) {
      studentsModel = ListStudentsModel.fromJson(r);
      studentsModel!.students.sort((a, b) => a.name!.compareTo(b.name!));
      addAttendanceLength(
          studentsModel!.students.length, subjectCardModel.passcode);

      emit(GetStudentsSuccessState());
    });
  }

  // Future<void> exportToExcel(
  //     {required String subjectName,
  //     required ListStudentsModel students}) async {
  //   ExcelHelper.exportExcel(students: students).then((v) async {
  //     if (await ExcelHelper.isDeviceLessThan10()) {
  //       try {
  //         var status = await Permission.storage.request();
  //         if (status.isGranted) {
  //           Directory? downloadsDirectory =
  //               Directory('/storage/emulated/0/Download');
  //
  //           String filePath =
  //               '${downloadsDirectory.path}/$subjectName-attendance.xlsx';
  //
  //           File file = File(filePath)
  //             ..createSync(recursive: true)
  //             ..writeAsBytesSync(v!);
  //
  //           if (await file.exists()) {
  //             emit(ExportToExcelSuccessState());
  //           } else {
  //             emit(ExportToExcelErrorState(
  //               'File was not saved. Please try again.',
  //             ));
  //           }
  //         } else {
  //           emit(ExportToExcelErrorState(
  //             'Permission denied,try to grant storage permission',
  //           ));
  //         }
  //       } catch (e) {
  //         emit(ExportToExcelErrorState(
  //           'Something went wrong, please try again',
  //         ));
  //       }
  //     } else {
  //       try {
  //         // Request storage permission
  //         var status = await Permission.manageExternalStorage.request();
  //         if (status.isGranted) {
  //           final result = await FilePicker.platform.getDirectoryPath();
  //           if (result != null) {
  //             String filePath = '$result/$subjectName-attendance.xlsx';
  //             File file = File(filePath)
  //               ..createSync(recursive: true)
  //               ..writeAsBytesSync(v!);
  //
  //             if (await file.exists()) {
  //               emit(ExportToExcelSuccessState());
  //             } else {
  //               emit(ExportToExcelErrorState(
  //                   'Something went wrong, File was not saved'));
  //             }
  //           } else {
  //             emit(ExportToExcelErrorState('No directory selected'));
  //           }
  //         } else {
  //           emit(ExportToExcelErrorState(
  //             'Permission denied,try to grant storage permission',
  //           ));
  //         }
  //       } catch (e) {
  //         emit(ExportToExcelErrorState(
  //           'Something went wrong, please try again',
  //         ));
  //       }
  //     }
  //   });
  // }

  var searchModel = StudentModel(
    name: '',
  );

  void search(String id, String level, String subjectPass) {
    emit(SearchLoadingState());
    bool found = false;
    for (var i = 0; i < studentsModel!.students.length; i++) {
      if (studentsModel!.students[i].id == id) {
        searchModel = studentsModel!.students[i];
        found = true;
        emit(SearchSuccessState());
        break;
      }
    }
    if (!found) {
      FirebaseServices.readDataByCollectionandSubCollection(
              level, subjectPass, 'Students', id)
          .then((value) {
        if (value!.exists) {
          searchModel = StudentModel.fromJson(value.data()!);
          emit(SearchSuccessState());
        } else {
          emit(SearchErrorState(
            'Not found',
          ));
        }
      }).catchError((onError) {
        emit(SearchErrorState(
          'Something went wrong, please try again',
        ));
      });
    }
  }

  dynamic result;
  String myDate = '';
  void scanner(String code, SubjectCardModel subject) {
    String decodedValue = decodeQRCode(code);
    if (decodedValue.isNotEmpty) {
      result = parseDecodedValue(decodedValue);

      if (result['date'] != null && result['date'] != '') {
        DateTime? qrDate = parseQRDate(result['date']);

        if (qrDate != null && isQRCodeValid(qrDate)) {
          processStudent(result, subject);
        } else {
          emit(SetStudentErrorState('QR code expired or too old'));
        }
      } else {
        emit(SetStudentErrorState('QR code missing date'));
      }
    } else {
      emit(SetStudentErrorState('Invalid QR code data'));
    }
  }

  String key = 'fuQvHp/e4cA9-ywoB1sXxzLiO#@%Unm5!7.0?q_^R&+=';
  String characters = 'abcdefghijklmnopqrstuvwxyz0123456789\'":{},-.';
  String decodeQRCode(String code) {
    String value = '';

    for (int i = 0; i < code.length; i++) {
      for (int j = 0; j < characters.length; j++) {
        if (code[i] == key[j]) {
          value = value + characters[j];
          break;
        } else if (code[i] == '*') {
          value = '$value ';
          break;
        }
      }
    }

    return value;
  }

  dynamic parseDecodedValue(String value) {
    try {
      return jsonDecode(value);
    } catch (e) {
      emit(SetStudentErrorState('Error parsing decoded QR code data'));
      return null;
    }
  }

  DateTime? parseQRDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      emit(SetStudentErrorState('Invalid date format in QR code'));
      return null;
    }
  }

  bool isQRCodeValid(DateTime qrDate) {
    DateTime now = DateTime.now();
    myDate = now.toString();
    calculateDefference(qrDate);
    return qrDate.isAfter(now.add(const Duration(minutes: -2))) &&
        qrDate.isBefore(now.add(const Duration(minutes: 2)));
  }

  int defference = 0;
  void calculateDefference(DateTime qrDate) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(qrDate);
    defference = difference.inSeconds;
  }

  Future<void> processStudent(dynamic result, SubjectCardModel subject) async {
    String formattedName = result['name'];
    String formattedGender = result['gender'];

    // String date =
    //     '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} '
    //'${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    await setAttendace(
        StudentModel(
          name: formattedName,
          id: result['id'],
          gender: formattedGender,
          attendance: 1,
          dates: [],
        ),
        subject);
  }

  int successRegistration = 0;
  List<String> successRegistrationIDs = [];
  ListStudentsModel? lastAttendance = ListStudentsModel(students: []);
  int progress = 0;

  Future<void> setAttendace(
      StudentModel student, SubjectCardModel subject) async {
    if (successRegistrationIDs.contains(student.id)) {
      if (successRegistrationIDs.last != student.id) {
        emit(SetStudentErrorState('Already registered'));
      }
      return;
    }

    progress += 1;
    successRegistrationIDs.add(student.id!);

    emit(SetStudentLoadingState());

    DateTime now = DateTime.now();
    String todayDate = now.toIso8601String();

    try {
      var studentDoc =
          await FirebaseServices.readDataByCollectionandSubCollection(
              subject.level, subject.passcode, 'Students', student.id!);

      if (studentDoc!.exists) {
        var studentData = studentDoc.data();
        List<dynamic> attendanceDates = studentData?['dates'] ?? [];

        if (attendanceDates.isNotEmpty) {
          DateTime lastAttendanceDate = DateTime.parse(attendanceDates.last);

          if (lastAttendanceDate.day == now.day &&
              lastAttendanceDate.month == now.month &&
              lastAttendanceDate.year == now.year) {
            progress -= 1;
            emit(SetStudentErrorState('Student already attended today'));
            return;
          }
        }

        // Update existing student attendance

        attendanceDates.add(todayDate);
        await FirebaseServices.updateDatabyCollectionandSubCollection(
          collection: subject.level,
          id: subject.passcode,
          subCollection: 'Students',
          id2: student.id!,
          data: {
            'attendance': (studentData?['attendance'] ?? 0) + 1,
            'dates': attendanceDates,
          },
        );
        lastAttendance!.students.add(
          StudentModel(
            name: student.name,
            id: student.id,
            gender: student.gender,
            attendance: 1,
            dates: [DateTime.now().toIso8601String()],
          ),
        );
      } else {
        // Add new student with attendance 1

        await FirebaseServices.addDataByCollection(
          {
            'name': student.name,
            'gender': student.gender,
            'id': student.id!,
            'attendance': 1,
            'dates': [todayDate],
          },
          subject.level,
          subject.passcode,
          'Students',
          student.id!,
        );
        lastAttendance!.students.add(
          StudentModel(
            name: student.name,
            id: student.id,
            gender: student.gender,
            attendance: 1,
            dates: [DateTime.now().toIso8601String()],
          ),
        );
      }

      successRegistration += 1;
      emit(SetStudentSuccessState());
    } catch (error) {
      emit(SetStudentErrorState('Error registering student: $error'));
    }
  }

  String? startDate;
  void addStartDate(SubjectCardModel model) {
    DateTime now = DateTime.now();
    startDate =
        '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
  }

  Future<void> setAttendanceOnlineInfo(
      String level, String passcode, bool start) async {
    DateTime now = DateTime.now();
    String date = '${now.year}-${now.month}-${now.day}';
    String time =
        '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
    await FirebaseServices.updateDatabyCollectionandSubCollection(
        collection: level,
        id: passcode,
        subCollection: 'AttendanceInfo',
        id2: date,
        data: {
          'date': date,
          'info': FieldValue.arrayUnion([
            {
              'end': time,
              'length': successRegistration,
              'name': student!.name.split(' ')[0],
              'start': startDate
            }
          ])
        }).catchError((onError) async {
      await FirebaseServices.setDataByCollectionandSubCollection(
          level, passcode, 'AttendanceInfo', date, {
        'date': date,
        'info': [
          {
            'start': startDate,
            'length': successRegistration,
            'name': student!.name.split(' ')[0],
            'end': time
          }
        ]
      });
    });

    progress = 0;
    successRegistrationIDs = [];
    successRegistration = 0;
  }

  //

  String code = '';
  void createCode(String name, String id, String gender) {
    code = '';
    String now = DateTime.now().toString();
    String encoded =
        '{"name":"${name.toLowerCase()}", "gender": "${gender.toLowerCase()}", "id": "$id","date":"$now"}';
    for (int i = 0; i < encoded.length; i++) {
      for (int j = 0; j < characters.length; j++) {
        if (encoded[i] == characters[j]) {
          code = code + key[j];
          break;
        }
        if (encoded[i] == ' ') {
          code = '$code*';
          break;
        }
      }
    }
    emit(CreateCodeState());
  }

  ////////// Settings \\\\\\\\\\\\\

  Future<void> changeNameID(
    String name,
    String id,
    String? newId,
  ) async {
    emit(ChangeNameIDLoading());
    await FirebaseServices.updateData(
      {'name': name},
      'AppUsers',
      id,
    ).then((value) async {
      //profile['name'] = name;
      student!.name = name;
      CashHelper.putString(key: 'name', value: name);
      emit(ChangeNameIDSuccess());
    }).catchError((onError) {
      emit(ChangeNameIDError('Something went wrong, please try again'));
    });
  }

  void requestTochangeID(String id, String newId) {
    emit(RequestLoadingState());
    FirebaseServices.addData({
      'id': id,
      'newId': newId,
      'type': 'changeID',
    }, 'Requests', id)
        .then((value) {
      emit(RequestSuccessState());
    }).catchError((onError) {
      emit(RequestErrorState('Something went wrong, please try again'));
    });
  }

  void requestToDeleteAccount(String id, String name) {
    emit(RequestLoadingState());
    FirebaseServices.addData({
      'id': id,
      'name': name,
      'type': 'deleteAccount',
    }, 'Requests', id)
        .then((value) {
      CashHelper.putString(key: 'uid', value: '');
      emit(RequestSuccessState());
    }).catchError((onError) {
      emit(RequestErrorState('Something went wrong, please try again'));
    });
  }

  void logout() async {
    CashHelper.putBool(key: 'logged', value: false);
    CashHelper.putString(key: 'id', value: '');
    CashHelper.putString(key: 'date', value: DateTime.now().toString());
    CashHelper.putString(key: 'today', value: '');
    sqldb.deleteAllRows('subjects');
    await NotificationsHelper().unsubscribeFromTopic('all');
    await NotificationsHelper().unsubscribeFromTopic(student!.department);
    await LocalNotifications.cancelNotification();
    emit(Logout());
  }

  void deleteAccount() {
    emit(DeleteAccountLoadingState());
    FirebaseServices.deleteData('AppUsers', student!.id).then((value) {
      logout();
      emit(DeleteAccountSuccessState());
    }).catchError((onError) {
      emit(DeleteAccountErrorState('Something went wrong, please try again'));
    });
  }

  void deleteImage() {
    emit(UpdateProfileDataLoadingState());
    FirebaseServices.updateData({'image': ''}, 'AppUsers', student!.id)
        .then((value) {
      student!.image = '';
      emit(UpdateProfileDataSuccessState());
    }).catchError((onError) {
      emit(UpdateProfileDataErrorState(
          'Something went wrong, please try again'));
    });
  }
}

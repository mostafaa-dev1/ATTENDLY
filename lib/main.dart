import 'package:academe_mobile_new/academe.dart';
import 'package:academe_mobile_new/core/bloc_observer/bloc_observer.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/notifications/local_notifications.dart';
import 'package:academe_mobile_new/core/routing/router.dart';
import 'package:academe_mobile_new/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LocalNotifications.initialize();

  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  NotificationsHelper().getAccessToken();
  runApp(AcademeApp(
    appRouter: AppRouter(),
  ));
}

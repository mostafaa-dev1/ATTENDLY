// import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsHelper {
  // creat instance of fbm
  final _messaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  Future<void> requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String>? getToken() async {
    await requestPermission();
    String? token = await _messaging.getToken();
    return token!;
  }

  // handle notifications when received
  // void handleMessages(RemoteMessage? message) {
  //   if (message != null) {
  //     // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
  //     showToast(
  //         text: 'on Background Message notification',
  //         state: ToastStates.SUCCESS);
  //   }
  // }

  // handel notifications in case app is terminated
  // void handleBackgroundNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  // }

  // Future<String?> getAccessToken() async {
  //   final serviceAccountJson = {
  //     "type": "service_account",
  //     "project_id": "academe-35669",
  //     "private_key_id": "ed71ddd2f9fabd943f6378dd331e5c47221e991f",
  //     "private_key":
  //         "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCaLOnjDsYFYLm+\nbV3Nb78kGmf7rmWOOy5uXSWpbxBFKI7l1duW2ThM+WEeWkaxzjetvcXBHamEmoBc\nQXiI3rKsvDNxbuvZNnxRqWX+6mRBbP//kAkKSYBWpGQgz9hs+G+Volgw/anva7VE\nBtDwOyhNlnExgdW3T5ap9DwApBEh1yC/X+dbiW8Kkqo7t1MiqonX1VS5lrdzOZg3\nSWOuajodok4jTP9ckhLfOBYDJAPAsBPHawudhbDoQxCVWQmHpviRdbVL8GZ9tfk9\nvki+L349p4h2KXdMZEAIp/PekoNGEaqIDzT8Z2rsMwdbc0Ah1kgbbTxwpWMW+tNq\n52dfN/JTAgMBAAECggEABlzBICIdcN5fe+jGfLJWWHaQgPXe8gImNd65LadMLBZy\n4zAymiSHqsGFzPtbvH2ulYhlz0TamILJtkTrZPaPuAoiM1Wo/PM/KR2M/HqOvZZy\ncAjxHpAO8ERjb2k0XLbZ3/ptmkP1jdBLkC2Z1LgUPzNso2bgu2pY5NWT3lDm9hb6\ntg8qONbOccb3JOcsjH1QqxUPF2+oiiRZm9C3PrdHlBu0rwIsuL2hBrnoucYEiTYD\ndnuuJJD+4W713NwJSnKBuU2yNEpFoJzszp64waF/VBrxSU+Usn8C38d7q9D5iN8U\n3B4cG7eIRLAyqio+aT2UKXYrchwj3eqfX5GwwHqMbQKBgQDOCmbPdIIVPP1i04Fd\nzXn+Niomi5Jtm92/cP4dqrENsSHdtF0MsHoPPTBUcQaXARSE7f1BoRC6y0ck6cZL\nsy5SJcNPOfsWfi7rq79QqYH3GlN/43dAamHzaDTEyf7oK8Eq5vElRZzbaRytU5LR\nbgjk0eqoLLRqcjdRRiJiqHsKBQKBgQC/jxMY8XxR8EiRHCvJidTzJhKHiVZPolx8\nU4n6Y9hh6mp/mwN5C8JG5oVSweTKY9U8Kq2rrCyyG9z8rZ4uSLq0Wm31/1xChTnF\n6SAEHb2rtpbG54V8+Bd3qxCmjnsmsG32W5g+BInpRf1IDxRMG0+M7rPbX6rtX8J8\nrsYHfX1CdwKBgQCEo/GXr/tmTMMaceqgRn04iAoOkl+LrIHOkqEk3BPrKpMQtOIK\nHzoUwWFxmumRIKLjCIq3S0cH2YFNZCnB5fH19FWNlVftHQJ7uS8KcHU4bHxAomDM\n2S+BkR4XaapuMGzEf7PSOMRIA5zwgBLOPDYBiJm19kGXHTw7WBkexjOfOQKBgGYD\n9jG0eXbRtnPBQviD9OrA/eE8nMCwQPzdKIA2qEgNJUZr8X+HaaGEpsAaDpRScn8m\nY3MnsG3yNNBEThdsGDJwblsx8ZpjhQ8HRkuq4xYNmWK4bfjNzwGmEqoA+0jxcL5g\nrUVp+WBIK8kybqbRbJ4riZFs84STGOp50XCvvgOlAoGBAIbZrh8Z+dfFx3Yz4Hiu\n3RbiLgDimbjU5r3GuLsvVz8V76MF3QWWED09akR/uUnDG43DjM/XpaYWNnt5VMQd\n28aqGxdhI4uCY03lp0aPyyflB55cV7BEaab5ofip2J49rKs8AaWx3OdNmO6c0Cqa\nHweyA/GIxw+hgxqej35BOor8\n-----END PRIVATE KEY-----\n",
  //     "client_email":
  //         "firebase-adminsdk-tpd8g@academe-35669.iam.gserviceaccount.com",
  //     "client_id": "113626023387782960845",
  //     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  //     "token_uri": "https://oauth2.googleapis.com/token",
  //     "auth_provider_x509_cert_url":
  //         "https://www.googleapis.com/oauth2/v1/certs",
  //     "client_x509_cert_url":
  //         "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-tpd8g%40academe-35669.iam.gserviceaccount.com",
  //     "universe_domain": "googleapis.com"
  //   };

  //   List<String> scopes = [
  //     "https://www.googleapis.com/auth/userinfo.email",
  //     "https://www.googleapis.com/auth/firebase.database",
  //     "https://www.googleapis.com/auth/firebase.messaging"
  //   ];

  //   try {
  //     http.Client client = await auth.clientViaServiceAccount(
  //         auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

  //     auth.AccessCredentials credentials =
  //         await auth.obtainAccessCredentialsViaServiceAccount(
  //             auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
  //             scopes,
  //             client);

  //     client.close();
  //     print(
  //         "Access Token: ${credentials.accessToken.data}"); // Print Access Token
  //     return credentials.accessToken.data;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Map<String, dynamic> getBody({
  //   required String fcmToken,
  //   required String title,
  //   required String body,
  //   required String userId,
  //   String? type,
  // }) {
  //   return {
  //     "message": {
  //       "token": fcmToken,
  //       "notification": {"title": title, "body": body},
  //       "android": {
  //         "notification": {
  //           "notification_priority": "PRIORITY_MAX",
  //           "sound": "default"
  //         }
  //       },
  //       "apns": {
  //         "payload": {
  //           "aps": {"content_available": true}
  //         }
  //       },
  //       "data": {
  //         "type": type,
  //         "id": userId,
  //         "click_action": "FLUTTER_NOTIFICATION_CLICK"
  //       }
  //     }
  //   };
  // }

  // Future<void> sendNotifications({
  //   required String fcmToken,
  //   required String title,
  //   required String body,
  //   required String userId,
  //   String? type,
  // }) async {
  //   try {
  //     var serverKeyAuthorization = await getAccessToken();

  //     // change your project id
  //     const String urlEndPoint =
  //         "https://fcm.googleapis.com/v1/projects/academe-35669/messages:send";

  //     Dio dio = Dio();
  //     dio.options.headers['Content-Type'] = 'application/json';
  //     dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

  //     await dio.post(
  //       urlEndPoint,
  //       data: getBody(
  //         userId: userId,
  //         fcmToken: fcmToken,
  //         title: title,
  //         body: body,
  //         type: type ?? "message",
  //       ),
  //     );
  //     // Print response status code and body for debugging
  //   } catch (e) {
  //     // Print error message for debugging
  //   }
  // }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging
        .unsubscribeFromTopic(topic)
        .then((value) {})
        .catchError((e) {});
  }

  void onBackgroundMessage(RemoteMessage message) {}
}

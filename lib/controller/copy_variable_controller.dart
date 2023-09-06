// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationController extends GetxController {
//   final FlutterLocalNotificationsPlugin flutterLocalPlugin =
//       FlutterLocalNotificationsPlugin();
//   AndroidNotificationChannel notificationChannel =
//       const AndroidNotificationChannel(
//           "coding is the life", "android channal service",
//           description: "this is channel des..", importance: Importance.high);

//   @override
//   void onInit() {
//     super.onInit();
//     initService();
//   }

//   Future<void> initService() async {
//     var service = FlutterBackgroundService();
//     if (Platform.isIOS) {
//       await flutterLocalPlugin.initialize(
//           const InitializationSettings(iOS: DarwinInitializationSettings()));
//     }

//     await flutterLocalPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(notificationChannel);

//     await service.configure(
//         iosConfiguration: IosConfiguration(
//             onBackground: iosBackground, onForeground: onStartNot),
//         androidConfiguration: AndroidConfiguration(
//             onStart: onStartNot,
//             autoStart: true,
//             isForegroundMode: true,
//             notificationChannelId: "coding is the life",
//             initialNotificationTitle: "coding is life servic",
//             initialNotificationContent: "coding is life content",
//             foregroundServiceNotificationId: 90));

//     service.startService();
//   }

// // onstart
//   @pragma('vm:entry-point')
//   void onStartNot(ServiceInstance service) {
//     DartPluginRegistrant.ensureInitialized();

//     service.on("setAsForeground").listen((event) {
//       print("forground =====");
//     });

//     service.on("setAsBackground").listen((event) {
//       print("bacground =====");
//     });

//     service.on("stopService").listen((event) {
//       service.stopSelf();
//     });

//     Timer.periodic(Duration(seconds: 10), (timer) {
//       flutterLocalPlugin.show(
//         90,
//         " عمل نسخة ",
//         '"تم عمل نسخة إحتياطية"',
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//               "coding is the life", "android channal service",
//               ongoing: true, icon: "@mipmap/ic_launcher"),
//         ),
//       );
//     });
//   }

// //ios
// // onstart
//   @pragma('vm:entry-point')
//   Future<bool> iosBackground(ServiceInstance service) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     DartPluginRegistrant.ensureInitialized();

//     return true;
//   }
// }

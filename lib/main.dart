import 'dart:async';
import 'dart:io' as io;
import 'package:account_app/controller/pdf_controller.dart';
import 'package:background_fetch/background_fetch.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/accgroup_controller.dart';

import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/main_controller.dart';
import 'package:account_app/models/sitting_model.dart';
import 'package:account_app/screen/intro_screen/intro_screen.dart';
import 'package:account_app/screen/main_screen/main_screen.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/sitting_data.dart';
import 'package:account_app/service/http_service/google_drive_service.dart';
import 'package:account_app/widget/custom_dialog.dart';

import 'package:account_app/widget/empty_accgroup_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel("coding is the life", "android channal service",
        description: "this is channel des..", importance: Importance.low);

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)

    BackgroundFetch.finish(taskId);
    return;
  }
  // Do your work here...
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(MainController());
  Get.put(PdfApi());

  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('assets/fonts/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });

  runApp(const MyApp());

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

Future<void> _doCopyToGoogleDrive() async {
  SittingData sittingData = SittingData();
  SittingModel? sittingModel = await sittingData.read(1);
  //final settingArray = [1, 2, 7, 30];

  String title = "";

  if (sittingModel?.isCopyOn ?? false) {
    if (sittingModel?.newData ?? false) {
      GoogleDriveAppData googleDriveAppData = GoogleDriveAppData();
      GoogleSignInAccount? googleUser;
      DriveApi? driveApi;

      googleUser = await googleDriveAppData.signInGoogle();

      if (googleUser != null) {
        driveApi = await googleDriveAppData.getDriveApi(googleUser);
      } else {
        CustomDialog.customSnackBar(
            "حدث خطأ أثناء تسجيل الدخول", SnackPosition.TOP, true);
      }

      if (driveApi != null) {
        String path = await DatabaseService().fullPath;

        await googleDriveAppData.uploadDriveFile(
          driveApi: driveApi,
          file: io.File(path),
        );
        title = "تم عمل نسخة إحتياطية";
        CustomDialog.customSnackBar(
            "تم عمل نسخة إحتياطية", SnackPosition.TOP, false);
        await sittingData.updateNewData(0);
      } else {
        CustomDialog.customSnackBar(
            "حدث خطأ أثناء تسجيل الدخول", SnackPosition.TOP, true);
        title = "حدث خطأ أثناء تسجيل الدخول";
      }
    } else {
      title = "ليس هناك اي بيانات جديدة لعمل نسخة إحتياطية";
    }

    flutterLocalPlugin.show(
      90,
      "النسخ الإ حتياطي",
      title,
      const NotificationDetails(
        android: AndroidNotificationDetails(
            "coding is the life", "android channal service",
            ongoing: false, icon: "logo"),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final IntroController introController = Get.find();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.landscapeLeft,
    // ]);
  }

  // @override
  // dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);

  //   super.dispose();
  // }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 60 * 12,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE,
        ), (String taskId) async {
      // if (DateTime.now().hour == 23) {
      await _doCopyToGoogleDrive();
      //   }

      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      BackgroundFetch.finish(taskId);
    });

    if (!mounted) return;
  }

  int popped = 0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'e-smart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: MyColors.containerColor,
      ),
      // theme: AppThemes.darkTheme,
      // home: ShowSnackBar(),
      home: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        child: FutureBuilder(
          future: introController.readIntro(),
          initialData: true,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData &&
                ConnectionState.done == snapshot.connectionState) {
              return introController.introShow.value
                  ? ShowMyMainScreen()
                  : const MyEntroScreen();
            } else {
              return WillPopScope(
                onWillPop: () async {
                  DateTime initTime = DateTime.now();
                  popped += 1;
                  if (popped >= 2) return true;
                  await ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Tap one more time to exit.',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 2),
                      ))
                      .closed;

                  // if timer is > 2 seconds reset popped counter
                  if (DateTime.now().difference(initTime) >=
                      Duration(seconds: 2)) {
                    popped = 0;
                  }
                  return false;
                },
                child: const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// class ShowSnackBar extends StatelessWidget {
//   const ShowSnackBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               CustomDialog.customSnackBar(
//                   "hello fro snak bar", SnackPosition.TOP, true);
//               ;
//             },
//             child: Text("show snak bar")),
//       ),
//     );
//   }
// }

class ShowMyMainScreen extends StatelessWidget {
  ShowMyMainScreen({super.key});
  final AccGroupController accGroupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => accGroupController.allAccGroups.isEmpty
          ? Scaffold(
              backgroundColor: MyColors.bg,
              body: EmptyAccGroupsWidget(),
            )
          : MyMainScreen(),
    );
  }
}

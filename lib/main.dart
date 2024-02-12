import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/copy_controller.dart';
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
        description: "this is channel des..", importance: Importance.high);

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

Future<void> _doLocalCopy() async {
  CopyController copyController = Get.put(CopyController());
  Platform.isIOS
      ? copyController.selectFolderIos()
      : copyController.selectFolder();

  flutterLocalPlugin.show(
    90,
    "النسخ الإ حتياطي",
    "تم عمل نسخة إحتياطية",
    const NotificationDetails(
      android: AndroidNotificationDetails(
          "coding is the life", "android channal service",
          ongoing: false, icon: "logo"),
    ),
  );
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 60 * 24,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE,
        ), (String taskId) async {
      await _doCopyToGoogleDrive();
      await _doLocalCopy();

      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      await _doCopyToGoogleDrive();
      await _doLocalCopy();

      BackgroundFetch.finish(taskId);
    });
    if (DateTime.now().hour == 23) {
      await _doLocalCopy();

      await _doCopyToGoogleDrive();
    }
    if (!mounted) return;
  }

// back btn

//end back btn
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'e-smart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: MyColors.containerColor,
        brightness: Brightness.light,
      ),
      home: WillBackBtnWidget(introController: introController),
    );
  }
}

class WillBackBtnWidget extends StatelessWidget {
  const WillBackBtnWidget({
    super.key,
    required this.introController,
  });

  final IntroController introController;

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await _showExitBottomSheet(context);
    return exitResult ?? false;
  }

  Future<bool?> _showExitBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: const BoxDecoration(
            color: MyColors.containerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: _buildBottomSheet(context),
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'هل انت متأكد من الخروج من التطبيق ؟',
          style: MyTextStyles.subTitle,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                SystemNavigator.pop();
              },
              child: Text(
                'نعم , متأكد',
                style: MyTextStyles.subTitle.copyWith(color: Colors.green[600]),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'إلغاء',
                textAlign: TextAlign.right,
                style: MyTextStyles.subTitle.copyWith(color: Colors.red[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Container(
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
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

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
          : Scaffold(body: MyMainScreen()),
    );
  }
}

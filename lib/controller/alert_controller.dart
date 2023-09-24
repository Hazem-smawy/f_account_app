import 'package:account_app/models/alert_model.dart';
import 'package:account_app/service/database/alert_data.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as time_zone;

import '../service/database/sitting_data.dart';

class AlertController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AlertData alertData = AlertData();
  final newAlerts = <AlertModel>[].obs;
  final oldAlerts = <AlertModel>[].obs;
  final newAlert = {}.obs;

  @override
  void onInit() {
    readAllAlerts();

    super.onInit();
  }

  Future<List<AlertModel>> readAllAlerts() async {
    final allAlerts = await alertData.readAllAlerts();
    newAlerts.value =
        allAlerts.where((element) => element.isDone == false).toList();
    newAlerts.sort((a, b) => b.date.compareTo(a.date));
    oldAlerts.value =
        allAlerts.where((element) => element.isDone == true).toList();

    return allAlerts;
  }

  Future<void> createAlert() async {
    if (newAlert['name'] == null || newAlert['name'].length < 2) {
      CustomDialog.customSnackBar('قم بإدخال الاسم', SnackPosition.TOP, true);
      return;
    }

    final alert = AlertModel(
      date: DateTime.parse(newAlert['date'] ??
          DateTime.now().add(const Duration(days: 1)).toIso8601String()),
      name: newAlert['name'],
      note: newAlert['note'] ?? "",
      isDone: false,
      createdAt: DateTime.now(),
    );

    await alertData.create(alert);

    CustomDialog.customSnackBar(
        'تم إضافة التنبية بنجاح', SnackPosition.BOTTOM, false);

    await readAllAlerts();
    try {
      flutterLocalNotificationsPlugin.zonedSchedule(
          alert.id ?? 0,
          newAlert['name'],
          newAlert['note'] ?? "",
          time_zone.TZDateTime.from(
              DateTime.parse(newAlert['date'] ??
                  DateTime.now()
                      .add(const Duration(days: 1))
                      .toIso8601String()),
              time_zone.UTC),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                "coding is the life", "android channal service",
                ongoing: false, icon: "logo"),
          ),
          androidScheduleMode: AndroidScheduleMode.alarmClock,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      CustomDialog.customSnackBar(
          "لايمكن إستخدام الوقت الحالي", SnackPosition.BOTTOM, true);
    }
    // notification

    newAlert.clear();

    Get.back();
    SittingData sittingData = SittingData();
    await sittingData.updateNewData(1);
  }

  Future<void> updateAlert(AlertModel alertModel) async {
    await alertData.updateAlert(alertModel);
    await readAllAlerts();
    try {
      await flutterLocalNotificationsPlugin.cancel(alertModel.id ?? 0);
    } catch (e) {
      //print(e);
    }

    SittingData sittingData = SittingData();
    await sittingData.updateNewData(1);
  }

  Future<void> deleteAlert(int id) async {
    alertData.delete(id);
    readAllAlerts();
  }
}

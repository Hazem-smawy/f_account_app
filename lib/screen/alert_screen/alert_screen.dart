import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/alert_controller.dart';
import 'package:account_app/models/alert_model.dart';
import 'package:account_app/screen/alert_screen/new_alert_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_formater;

import '../../widget/custom_dialog.dart';

class AlertScreen extends StatelessWidget {
  AlertScreen({super.key});
  final AlertController alertController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 50),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.lessBlackColor,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Text(
                          'التنبيهات',
                          textAlign: TextAlign.center,
                          style: MyTextStyles.subTitle.copyWith(
                            color: MyColors.bg,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.lessBlackColor,
                          ),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 5),
                          child: const FaIcon(
                            FontAwesomeIcons.arrowRightLong,
                            size: 20,
                            color: MyColors.secondaryTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                //container
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: alertController.newAlerts.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  alertController.oldAlerts.isEmpty ? 50 : 0),
                          child: EmptyAlertListWidget(),
                        )
                      : AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          child: ListView.builder(
                            itemCount: alertController.newAlerts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AlertItemWidget(
                                isNew: true,
                                alertModel: alertController.newAlerts[index],
                              );
                            },
                          ),
                        ),
                ),
                if (alertController.oldAlerts.isNotEmpty)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.bg,
                    ),
                    child: Row(
                      children: [
                        // GestureDetector(
                        //   onTap: () async {
                        //     if (homeController.todaysJournals.isNotEmpty) {
                        //       NewDailyPdfController.generateTodayDailyReportPdf();
                        //     }
                        //   },
                        //   child: const FaIcon(
                        //     FontAwesomeIcons.filePdf,
                        //     size: 17,
                        //     color: MyColors.secondaryTextColor,
                        //   ),
                        // ),
                        const Spacer(),
                        Text(
                          "كل التنبيهات",
                          style: MyTextStyles.subTitle,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.bell,
                          color: MyColors.secondaryTextColor,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                if (alertController.oldAlerts.isNotEmpty)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: ListView.builder(
                        itemCount: alertController.oldAlerts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AlertItemWidget(
                            isNew: false,
                            alertModel: alertController.oldAlerts[index],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        onPressed: () {
          Get.bottomSheet(const NewAlertSheet(), isScrollControlled: true);
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container EmptyAlertListWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: MyColors.bg.withOpacity(0.7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              Icons.alarm_off,
              size: 50,
              color: MyColors.lessBlackColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "لا توجد أي  تنبيهات جد يدة",
              style: MyTextStyles.subTitle,
            )
          ],
        ));
  }
}

class AlertItemWidget extends StatelessWidget {
  final AlertModel alertModel;
  final bool isNew;
  AlertItemWidget({super.key, required this.alertModel, required this.isNew});
  final AlertController alertController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.bg,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    date_formater.DateFormat.Hm().format(alertModel.date),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date_formater.DateFormat.yMd().format(alertModel.date),
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                alertModel.name,
                style: MyTextStyles.title2,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  alertModel.note,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: MyTextStyles.body,
                ),
              ),
            ],
          ),

          // btns
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              CustomDialog.showDialog(
                  title: isNew ? 'إنهاء ' : "حذف ",
                  description: isNew
                      ? "هل انت متاكد من إنهاء هذا التنبية"
                      : "هل انت متاكد من حذف هذا التنبية",
                  color: isNew ? Colors.green : Colors.red,
                  icon: isNew ? Icons.alarm : FontAwesomeIcons.trashCan,
                  action: () async {
                    Get.back();

                    isNew
                        ? await alertController
                            .updateAlert(alertModel.copyWith(isDone: true))
                        : await alertController.deleteAlert(alertModel.id ?? 0);
                  });
            },
            child: Container(
              height: 40,
              width: Get.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isNew
                    ? const Color.fromARGB(225, 52, 155, 18).withOpacity(0.8)
                    : Colors.red[400],
              ),
              child: Center(
                child: Text(
                  isNew ? "إنهاء" : 'حذف',
                  style: MyTextStyles.title2.copyWith(
                    color: MyColors.bg,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

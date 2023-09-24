import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/alert_controller.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NewAlertSheet extends StatefulWidget {
  NewAlertSheet({super.key});

  @override
  State<NewAlertSheet> createState() => _NewAlertSheetState();
}

class _NewAlertSheetState extends State<NewAlertSheet> {
  DateTime dateTime = DateTime.now().add(const Duration(days: 1));

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
  AlertController alertController = Get.find();

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Container(
      //  margin: EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: MyColors.bg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          const FaIcon(
            Icons.alarm,
            size: 50,
            color: MyColors.secondaryTextColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'إضافة منبة',
            style: MyTextStyles.title2,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await pickDate();
                          if (date == null) {
                            return;
                          }

                          dateTime = date;

                          final time = await pickTime();
                          // if (time == null) return;

                          final newDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            time?.hour ?? dateTime.hour,
                            time?.minute ?? dateTime.minute,
                          );

                          setState(() {
                            dateTime = newDateTime;

                            alertController.newAlert.update(
                              'date',
                              (value) => dateTime.toIso8601String(),
                              ifAbsent: () => dateTime.toIso8601String(),
                            );
                          });
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,

                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.containerSecondColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${dateTime.month}/${dateTime.day}  $hours:$minutes',
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                  color: MyColors.lessBlackColor,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.clock,
                                size: 18,
                                color: MyColors.lessBlackColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: CustomTextFieldWidget(
                  textHint: 'الاسم',
                  action: (p0) {
                    alertController.newAlert.update(
                      'name',
                      (value) => p0.toString().trim(),
                      ifAbsent: () => p0.toString().trim(),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFieldWidget(
            textHint: 'ملاحضة',
            action: (p0) {
              alertController.newAlert.update(
                'note',
                (value) => p0.toString().trim(),
                ifAbsent: () => p0.toString().trim(),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              await alertController.createAlert();
            },
            child: Container(
              height: 50,
              width: Get.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColors.primaryColor,
              ),
              child: Center(
                child: Text(
                  "إضافة",
                  style: MyTextStyles.title2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: MyColors.bg,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

// ignore: file_names
import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/main.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyAccGroupsWidget extends StatelessWidget {
  EmptyAccGroupsWidget({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/accGroup.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "قم بإضافة بعض التصنيفات ",
                style: MyTextStyles.title1.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await homeController
                      .addDefaultAccGroupsAndCurency()
                      .then((value) => {
                            Future.delayed(const Duration(milliseconds: 200))
                                .then((value) =>
                                    {Get.offAll(() => ShowMyMainScreen())})
                          });
                },
                child: Container(
                  width: Get.width / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.lessBlackColor,
                  ),
                  child: Text(
                    "إضافة التصنيفات الإ فتراضية",
                    textAlign: TextAlign.center,
                    style: MyTextStyles.body.copyWith(
                      color: MyColors.bg,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AccGroupSettingScreen());
                },
                child: Container(
                  width: Get.width / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: MyColors.lessBlackColor.withOpacity(0.2),
                        width: 1,
                      )),
                  child: Text(
                    "إضافة",
                    textAlign: TextAlign.center,
                    style: MyTextStyles.body.copyWith(
                      color: MyColors.lessBlackColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

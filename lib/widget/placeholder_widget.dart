import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/screen/settings/curency_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceHolderWidget extends StatelessWidget {
  PlaceHolderWidget({super.key});
  final CurencyController curencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (curencyController.allCurency.isEmpty)
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: MyColors.bg.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/curency2.png",
                      width: Get.width - 100,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "قم بإضافة بعض العملات ",
                      style: MyTextStyles.title1.copyWith(
                        color: MyColors.lessBlackColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CurencySettingScreen());
                      },
                      child: Container(
                        width: Get.width / 3,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: MyColors.secondaryTextColor,
                              width: 1,
                            )),
                        child: Text(
                          "إضافة",
                          textAlign: TextAlign.center,
                          style: MyTextStyles.title1.copyWith(
                            color: MyColors.lessBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (curencyController.allCurency.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                width: double.infinity,
                //constraints: BoxConstraints(maxHeight: Get.height / 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        "assets/images/customerAccount.png",
                        width: Get.width - 100,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "لا يوجد أي حساب في هذا التصنيف ",
                        style: MyTextStyles.title2.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "للإضافة إضغط زر الإضافة",
                        style: MyTextStyles.subTitle.copyWith(
                          fontWeight: FontWeight.normal,
                          color: MyColors.lessBlackColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

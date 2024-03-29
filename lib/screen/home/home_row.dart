import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/screen/details/details.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class HomeRowView extends StatelessWidget {
  final HomeModel homeModel;

  HomeRowView({super.key, required this.homeModel, required this.status});
  final NewAccountController newAccountController =
      Get.put(NewAccountController());
  final CurencyController curencyController = Get.find();
  final bool status;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (!status || !homeModel.caStatus || !homeModel.cacStatus)
            ? MyColors.secondaryTextColor.withOpacity(0.1)
            : MyColors.bg,
        // boxShadow: [myShadow.blackShadow],
      ),
      child: GestureDetector(
        onTap: () => Get.to(() => DetailsScreen(
              isFormReports: false,
              homeModel: homeModel,
              accGoupStatus: status,
            )),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Container(
              width: 15,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: homeModel.totalCredit < homeModel.totalDebit
                    ? MyColors.creditColor
                    : MyColors.debetColor,
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: Get.width * 0.2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  intl.NumberFormat.currency(symbol: '', decimalDigits: 1)
                      .format(
                          (homeModel.totalCredit - homeModel.totalDebit).abs()),
                  textAlign: TextAlign.left,
                  style: MyTextStyles.title2.copyWith(
                    //   fontWeight: FontWeight.bold,
                    color: homeModel.totalCredit < homeModel.totalDebit
                        ? MyColors.creditColor
                        : MyColors.debetColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            CircleAvatar(
              backgroundColor: MyColors.lessBlackColor.withOpacity(0.9),
              radius: 13,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${homeModel.operation}',
                    style: const TextStyle(
                      color: MyColors.bg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                homeModel.name,
                textAlign: TextAlign.right,
                style: MyTextStyles.subTitle.copyWith(
                  color: MyColors.secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(width: 15),
            if (!status || !homeModel.caStatus || !homeModel.cacStatus)
              GestureDetector(
                onTap: () {
                  CustomDialog.customSnackBar(
                    " تم ايقاف هذا الحساب من الاعدادات للإضافة قم بتغير الإعدادات",
                    SnackPosition.TOP,
                    true,
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.circleXmark,
                  size: 20,
                  color: MyColors.creditColor.withOpacity(0.4),
                ),
              ),
            if (status && homeModel.caStatus && homeModel.cacStatus)
              GestureDetector(
                onTap: () {
                  if (curencyController.allCurency
                      .firstWhere(
                        (element) =>
                            element.id ==
                            curencyController.selectedCurency['id'],
                      )
                      .status) {
                    Get.bottomSheet(
                      NewRecordScreen(
                        homeModel: homeModel,
                        isEdditing: false,
                      ),
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  } else {
                    CustomDialog.customSnackBar(
                      "تم ايقاف هذه العمله من الاعدادات",
                      SnackPosition.BOTTOM,
                      false,
                    );
                    //  return;
                  }
                },
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 20,
                ),
              ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  bool getRowStatus() {
    if (!homeModel.caStatus ||
        !homeModel.cacStatus ||
        (curencyController.selectedCurency['status'] != null &&
            curencyController.selectedCurency['status'] == false)) {
      return false;
    } else {
      return true;
    }
  }
}

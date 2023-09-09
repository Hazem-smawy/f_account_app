import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/sitting_controller.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class GoogleDriveAveryList extends StatelessWidget {
  final SittingController sittingController = Get.find();

  GoogleDriveAveryList({super.key});
  String getCopyEveryString(int i) {
    switch (i) {
      case 1:
        return "يوم";
      case 2:
        return "يومين";
      case 7:
        return "أسبوع";

      default:
        return "شهر";
    }
  }

  @override
  Widget build(BuildContext context) {
    sittingController.everyArray.sort();
    final newArraay = sittingController.everyArray.reversed;
    return Obx(
      () => Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.containerColor.withOpacity(0.5),
        ),
        child: SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: newArraay
                .map((e) => GoogleDriveAveryListItem(
                    action: () {
                      CustomDialog.showDialog(
                          title: "نسخة",
                          description:
                              "  سيتم النسخ الى جوجل درايف كل ${getCopyEveryString(e)}",
                          color: Colors.green,
                          icon: FontAwesomeIcons.upload,
                          action: () {
                            sittingController.every.value =
                                sittingController.everyArray.indexOf(e);
                            sittingController.setEvery();
                            Get.back();
                          });
                    },
                    isSelected: sittingController.every ==
                        sittingController.everyArray.indexOf(e),
                    lable: getCopyEveryString(e)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class GoogleDriveAveryListItem extends StatelessWidget {
  GoogleDriveAveryListItem(
      {super.key,
      required this.action,
      required this.isSelected,
      required this.lable});
  final VoidCallback action;
  final bool isSelected;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            lable,
            style: myTextStyles.body.copyWith(
              color: isSelected
                  ? MyColors.primaryColor
                  : MyColors.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 7),
          FaIcon(
            isSelected ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
            size: 15,
            color: isSelected
                ? MyColors.primaryColor
                : MyColors.secondaryTextColor,
          ),
        ],
      ),
    );
  }
}

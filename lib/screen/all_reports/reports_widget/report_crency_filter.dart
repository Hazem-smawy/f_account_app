import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ReportCurenyFilterWidget extends StatelessWidget {
  final CurencyController curencyController = Get.find();
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback action;
  final int curencyId;

  ReportCurenyFilterWidget({
    super.key,
    required this.action,
    required this.curencyId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(7),
        // margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              // topLeft: Radius.circular(8),
              // topRight: Radius.circular(8),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          color: MyColors.containerColor.withOpacity(0.4),
        ),
        child: SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: curencyController.allCurency.map((element) {
                return CurencyShowItem(
                  action: () {
                    controller.curencyId.value = element.id ?? 0;

                    action();
                  },
                  isSelected: controller.curencyId.value == element.id,
                  lable: element.name,
                );
              }).toList()),
        ),
      ),
    );
  }
}

class CurencyShowItem extends StatelessWidget {
  const CurencyShowItem(
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
        children: [
          const SizedBox(
            width: 5,
          ),
          Text(
            lable,
            style: MyTextStyles.body.copyWith(
              color: isSelected
                  ? MyColors.primaryColor
                  : MyColors.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 5),
          FaIcon(
            isSelected ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
            size: 15,
            color: isSelected
                ? MyColors.primaryColor
                : MyColors.secondaryTextColor,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

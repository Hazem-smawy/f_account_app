import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CurencyShowWidget extends StatelessWidget {
  final CurencyController curencyController = Get.find();

  CurencyShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: curencyController.allCurency
                  .where((element) => element.status == true)
                  .map((element) {
                return CurencyShowItem(
                  action: () {
                    //curencyController.selectedCurency.clear();
                    curencyController.selectedCurency
                        .addAll(element.toEditMap());
                    curencyController.selectedCurency.update(
                      'crId',
                      (value) => element.id,
                      ifAbsent: () => element.id,
                    );
                  },
                  isSelected:
                      curencyController.selectedCurency[CurencyField.name] ==
                          element.name,
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

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/screen/all_reports/reports_widget/dialy_sammary_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constant/colors.dart';

class ReportFooterWidget extends StatelessWidget {
  ReportFooterWidget({
    super.key,
    this.controller,
  });
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final CurencyController curencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      margin: const EdgeInsets.all(10),
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                ReportSammaryWidget(
                  icon: FontAwesomeIcons.arrowUp,
                  title: controller.totalCredit.toString(),
                  subTitle: "لة",
                  color: MyColors.debetColor,
                  curencyId: controller.curencyId.value,
                ),
                const SizedBox(
                  width: 2,
                ),
                ReportSammaryWidget(
                  curencyId: controller.curencyId.value,
                  icon: FontAwesomeIcons.arrowDown,
                  title: controller.totalDebit.toString(),
                  subTitle: "علية",
                  color: MyColors.creditColor,
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MyColors.shadowColor),
                color: MyColors.bg,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  FaIcon(
                    controller.totalDebit.value < controller.totalCredit.value
                        ? FontAwesomeIcons.arrowUp
                        : FontAwesomeIcons.arrowDown,
                    size: 10,
                    color: controller.totalDebit.value <
                            controller.totalCredit.value
                        ? MyColors.debetColor
                        : MyColors.creditColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    curencyController.allCurency
                        .firstWhere((element) =>
                            element.id == controller.curencyId.value)
                        .symbol,
                    style: MyTextStyles.body,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    (controller.totalDebit.value - controller.totalCredit.value)
                        .abs()
                        .toString(),
                    style: MyTextStyles.title1,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    controller.totalDebit.value < controller.totalCredit.value
                        ? "لة"
                        : 'علية',
                    style: MyTextStyles.body,
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

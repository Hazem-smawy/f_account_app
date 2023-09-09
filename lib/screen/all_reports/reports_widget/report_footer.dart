import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/all_reports/reports_widget/dialy_sammary_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constant/colors.dart';

class ReportFooterWidget extends StatelessWidget {
  ReportFooterWidget({
    super.key,
    this.controller,
  });
  final controller;

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
                SizedBox(
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
                  Spacer(),
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
                  const SizedBox(width: 5),
                  Text(
                    (controller.totalDebit.value - controller.totalCredit.value)
                        .abs()
                        .toString(),
                    style: myTextStyles.title1,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    controller.totalDebit.value < controller.totalCredit.value
                        ? "لة"
                        : 'علية',
                    style: myTextStyles.body,
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

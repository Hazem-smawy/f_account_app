import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constant/colors.dart';
import '../../../controller/curency_controller.dart';

class ReportSammaryWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  final int curencyId;
  ReportSammaryWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.curencyId,
      required this.color})
      : super(key: key);
  final CurencyController curencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MyColors.shadowColor),
          color: MyColors.bg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FaIcon(
                  icon,
                  size: 10,
                  color: color,
                ),
                const Spacer(),
                Text(
                  curencyController.allCurency
                      .firstWhere((element) => element.id == curencyId)
                      .symbol,
                  style: MyTextStyles.body,
                ),
                const SizedBox(
                  width: 5,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    GlobalUtitlity.formatNumberString(number: title),
                    style: MyTextStyles.title2,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  ": $subTitle",
                  style: MyTextStyles.body,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

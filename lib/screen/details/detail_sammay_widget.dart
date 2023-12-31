import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../controller/curency_controller.dart';

class DetailsSammaryWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  DetailsSammaryWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.color})
      : super(key: key);
  final CurencyController curencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  curencyController.selectedCurency['symbol'],
                  style: MyTextStyles.body,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: FittedBox(
                    key: Key(subTitle),
                    fit: BoxFit.scaleDown,
                    child: Text(
                      GlobalUtitlity.formatNumberString(number: title),
                      style: MyTextStyles.subTitle.copyWith(
                        color: MyColors.lessBlackColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  ": $subTitle ",
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

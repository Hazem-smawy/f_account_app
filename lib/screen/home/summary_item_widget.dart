import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class HomeSammaryWidget extends StatelessWidget {
  final CurencyController curencyController = Get.find();
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  final Curency curency;
  HomeSammaryWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.color,
      required this.curency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          //  border: Border.all(color: MyColors.shadowColor),
          color: MyColors.bg,
        ),
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              alignment: Alignment.bottomLeft,
              child: FaIcon(
                color == MyColors.creditColor
                    ? Icons.trending_down
                    : Icons.trending_up,
                size: 90,
                color: color.withOpacity(0.08),
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 35,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: MyColors.shadowColor,
                    ),
                  ),
                  child: FaIcon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      curency.symbol,
                      style: MyTextStyles.body.copyWith(
                        // color: MyColors.secondaryTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FittedBox(
                      child: Text(
                        intl.NumberFormat.currency(symbol: '', decimalDigits: 1)
                            .format(double.parse(title)),
                        style: MyTextStyles.title1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Text(
                    subTitle,
                    style: MyTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

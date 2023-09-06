// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as dateFormater;

import '../../../constant/colors.dart';

class AllMoneyRowWidget extends StatelessWidget {
  final allMoneyRow;
  const AllMoneyRowWidget({super.key, required this.allMoneyRow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: MyColors.bg.withOpacity(0.5),
      ),
      child: Row(
        children: [
          Text(
            dateFormater.DateFormat.MEd().format(DateTime.now()),
            textDirection: TextDirection.rtl,
            style: myTextStyles.body.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            width: 7,
          ),

          const SizedBox(
            width: 15,
          ),

          SizedBox(
            width: Get.width / 8,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                allMoneyRow['accName'],
                style: myTextStyles.title2,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: Get.width / 6,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      clipBehavior: Clip.hardEdge,
                      child: Text(
                        allMoneyRow['accName'],
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: myTextStyles.subTitle.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.folder,
                    size: 12,
                    color: MyColors.secondaryTextColor,
                  ),
                ],
              ),
            ),
          ),
          // const Spacer(),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    // width: Get.width / 2.7,
                    child: FittedBox(
                      child: Text(
                        "hazem smawy",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: myTextStyles.subTitle
                            .copyWith(overflow: TextOverflow.ellipsis),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

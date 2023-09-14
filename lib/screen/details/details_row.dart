// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_formater;

import '../../../constant/colors.dart';

class DetailsRowWidget extends StatelessWidget {
  final Journal journal;
  final String accountMoney;
  const DetailsRowWidget(
      {super.key, required this.journal, required this.accountMoney});

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
          SizedBox(
            width: Get.width / 6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                accountMoney,
                style: MyTextStyles.title2.copyWith(
                  color: MyColors.blackColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: Get.width / 7,
            child: Text(
              date_formater.DateFormat.MEd().format(journal.registeredAt),
              textDirection: TextDirection.ltr,
              style: MyTextStyles.body.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),

          Container(
            width: 20,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: journal.credit < journal.debit
                  ? MyColors.creditColor.withOpacity(0.8)
                  : MyColors.debetColor.withOpacity(0.8),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: Get.width / 6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                (journal.debit - journal.credit).abs().toString(),
                style: MyTextStyles.title2.copyWith(
                  color: MyColors.lessBlackColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
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
                    child: FittedBox(
                      child: Text(
                        journal.details,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: MyTextStyles.subTitle.copyWith(
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
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

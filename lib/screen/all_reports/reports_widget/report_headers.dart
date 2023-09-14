import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ReportHeaderWidget extends StatelessWidget {
  final VoidCallback action;
  final String title;
  const ReportHeaderWidget({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.lessBlackColor,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              action();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: FaIcon(
                FontAwesomeIcons.filePdf,
                size: 20,
                color: MyColors.containerColor,
              ),
            ),
          ),
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: MyTextStyles.subTitle.copyWith(
              color: MyColors.bg,
              fontWeight: FontWeight.normal,
            ),
          )),
          GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: FaIcon(
                FontAwesomeIcons.arrowRightLong,
                size: 20,
                color: MyColors.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

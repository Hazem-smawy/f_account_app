import 'package:account_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ReportHeaderWidget extends StatelessWidget {
  const ReportHeaderWidget({
    super.key,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: FaIcon(
              FontAwesomeIcons.filePdf,
              size: 20,
              color: MyColors.containerColor,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
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

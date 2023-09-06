import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constant/colors.dart';

class EmptyReportListWidget extends StatelessWidget {
  bool? isCustomerMovementAccount;
  EmptyReportListWidget({super.key, this.isCustomerMovementAccount});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: isCustomerMovementAccount == null
            ? const EdgeInsets.symmetric(horizontal: 15, vertical: 5)
            : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg.withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.clock,
              size: 50,
              color: MyColors.lessBlackColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "لا توجد أي عمليات ",
              style: myTextStyles.subTitle,
            )
          ],
        ));
  }
}

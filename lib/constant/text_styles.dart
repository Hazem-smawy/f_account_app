import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/responsve.dart';
import 'package:flutter/material.dart';

class MyTextStyles {
  static final title1 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: Responsive.isMobile ? 14 : 23,
    color: MyColors.lessBlackColor,
    fontWeight: FontWeight.bold,
  );
  static final title2 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: Responsive.isMobile ? 12 : 16,
    color: MyColors.lessBlackColor,
    fontWeight: FontWeight.bold,
  );
  static final subTitle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: Responsive.isMobile ? 10 : 14,
    color: MyColors.secondaryTextColor,
    fontWeight: FontWeight.bold,
  );

  static final body = TextStyle(
    fontFamily: 'Cairo',
    fontSize: Responsive.isMobile ? 10 : 12,
    color: MyColors.secondaryTextColor,
  );
}

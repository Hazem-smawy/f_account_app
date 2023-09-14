import 'package:account_app/constant/colors.dart';
import 'package:flutter/material.dart';

class MyShadow {
  static final blackShadow = BoxShadow(
    color: MyColors.shadowColor,
    offset: const Offset(1, 1),
    blurRadius: 10,
    blurStyle: BlurStyle.solid,
  );
}

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalTextFieldWidget extends StatelessWidget {
  final String textHint;
  final IconData icon;
  Function(String)? action;
  String? placeHolder;
  PersonalTextFieldWidget(
      {super.key,
      required this.icon,
      required this.textHint,
      this.placeHolder = "",
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.containerSecondColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              initialValue: placeHolder ?? "",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: myTextStyles.subTitle.copyWith(
                  color: MyColors.blackColor, fontWeight: FontWeight.bold),
              onChanged: (value) {
                action!(value);
                CEC.errorMessage.value = "";
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: textHint,
                hintStyle:
                    myTextStyles.body.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(width: 10),
          FaIcon(
            icon,
            size: 20,
            color: MyColors.secondaryTextColor,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

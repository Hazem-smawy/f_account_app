import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorShowWidget extends StatelessWidget {
  const ErrorShowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.red.withOpacity(0.08),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            CEC.errorMessage.value,
            textAlign: TextAlign.right,
            style: MyTextStyles.subTitle.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            size: 15,
            color: Colors.red.withOpacity(0.7),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

class CorrectShowWidget extends StatelessWidget {
  const CorrectShowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "there is some eror",
            textAlign: TextAlign.right,
            style: MyTextStyles.body.copyWith(color: Colors.green),
          ),
          const SizedBox(width: 10),
          const FaIcon(
            FontAwesomeIcons.circleInfo,
            color: Colors.green,
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

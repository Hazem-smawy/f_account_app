// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsShareSheetWidget extends StatelessWidget {
  const DetailsShareSheetWidget(
      {super.key,
      required this.customerPhone,
      this.debit,
      this.credit,
      required this.shareAction,
      required this.pdfAction});
  final customerPhone;
  final debit;
  final credit;
  final VoidCallback shareAction;
  final VoidCallback pdfAction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.bg,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleWidget(
              title: 'تصد ير',
              icon: FontAwesomeIcons.filePdf,
              action: () async {
                pdfAction();
              },
            ),

            TitleWidget(
              title: 'مشاركة',
              icon: Icons.share_outlined,
              action: () async {
                shareAction();
              },
            ),
            // whatsaap                      Icons.share_outlined,

            TitleWidget(
              title: 'رسالة',
              icon: FontAwesomeIcons.commentSms,
              action: () async {
                final Uri smsLaunchUri = Uri(
                  scheme: 'sms',
                  path: customerPhone,
                  queryParameters: <String, String>{
                    'body': 'لك :$credit , عليك : $debit',
                  },
                );
                if (await canLaunchUrl(smsLaunchUri)) {
                  launchUrl(smsLaunchUri);
                } else {
                  CustomDialog.customSnackBar(
                      "حدث خطأ", SnackPosition.TOP, false);
                }
              },
            ),

            TitleWidget(
              title: 'إتصال',
              icon: Icons.phone_enabled_outlined,
              action: () async {
                final Uri phoneUri = Uri(scheme: "tel", path: customerPhone);
                try {
                  if (await launchUrlString(phoneUri.toString())) {
                    await launchUrlString(phoneUri.toString());
                  }
                } catch (error) {
                  throw ("Cannot dial");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final VoidCallback action;
  final String title;
  final IconData icon;
  const TitleWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MyColors.secondaryTextColor),
              // color: MyColors.lessBlackColor.withOpacity(0.9),
            ),
            child: FaIcon(
              icon,
              size: 20,
              color: MyColors.lessBlackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style:
                  MyTextStyles.title2.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

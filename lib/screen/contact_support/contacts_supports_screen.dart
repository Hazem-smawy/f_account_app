import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactAndSupportsScreen extends StatelessWidget {
  const ContactAndSupportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const CustomBackBtnWidget(title: "الإ تصال و الدعم"),
            const SizedBox(
              height: 50,
            ),
            const TitleWidget(
              title: 'الهاتف',
              icon: Icons.phone_enabled_outlined,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.bg.withOpacity(0.5),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "7743232323",
                    style: TextStyle(
                      fontSize: 10,
                      color: MyColors.secondaryTextColor,
                    ),
                  ),
                  Divider(),
                  Text(
                    "7743232323",
                    style: TextStyle(
                      fontSize: 10,
                      color: MyColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // whatsaap

            const TitleWidget(
              title: 'واتساب',
              icon: FontAwesomeIcons.whatsapp,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.bg.withOpacity(0.5),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "7743232323",
                    style: TextStyle(
                      fontSize: 10,
                      color: MyColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // emails
            const TitleWidget(
              title: 'البريد الإ لكتروني',
              icon: FontAwesomeIcons.envelope,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.bg.withOpacity(0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "hazemsmawy@gmail.com",
                    style: MyTextStyles.subTitle,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'v:1.1.0',
              style: MyTextStyles.body,
            ),
          ],
        ),
      )),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: MyTextStyles.title2.copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          width: 10,
        ),
        FaIcon(
          icon,
          size: 15,
          color: MyColors.blackColor,
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

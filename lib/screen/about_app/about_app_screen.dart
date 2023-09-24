import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_btns_widges.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const CustomBackBtnWidget(title: "حول البرنامج"),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.containerSecondColor.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' E-smart مرحبا بكم في برنامج ',
                      style: MyTextStyles.title1,
                    ),
                    Text(
                      'دقة سهولة أمان',
                      style: MyTextStyles.subTitle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'با لإضافة إلي سهولة الإستخدام يوفر لك هذا البرنامج',
                textAlign: TextAlign.right,
                style: MyTextStyles.title2,
              ),
              const SizedBox(
                height: 10,
              ),
              FetureWidget('سهولة ترتيب الحياة المالية'),
              FetureWidget('سهولة ترتيب الحياة المالية'),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container FetureWidget(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.bg.withOpacity(0.5),
      ),
      child: Text(title,
          textAlign: TextAlign.right,
          style: MyTextStyles.subTitle.copyWith(
            fontWeight: FontWeight.normal,
          )),
    );
  }
}

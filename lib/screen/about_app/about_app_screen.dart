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
        child: SingleChildScrollView(
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
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Text(
                  'كل العمليات التالية تستطيع تنفيذها من الأ عدادات او من الشريط العلوي للتطبيق او من قائمة المساعدة السريعة',
                  textAlign: TextAlign.right,
                  style: MyTextStyles.subTitle.copyWith(
                    color: MyColors.lessBlackColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FetureWidget('إضافة عدد لا نهائي من التصنيفات'),
              FetureWidget("إضافة عدد لا نهائي من العملات"),
              FetureWidget(
                  "إضافة عدد لا نهائي من العملاء تحت اي صنف و اي عملة"),
              FetureWidget('يمكنك إيقاف او تجميد اي حساب من قائمة كل الحسابات'),
              FetureWidget(
                  " إيقاف او تجميد اي تصنيف او عملة او عميل عن طريق الحالة "),
              FetureWidget(
                  " في حالة إيقاف اي تصنيف لن تستطيع إضافة اي حساب الى هذا التصنيف "),
              FetureWidget(
                  " في حالة إيقاف اي عملة لن تستطيع إضافة اي حساب الى هذه العملة "),
              FetureWidget(
                  "سهولة عمل نسخة لجميع البيانات الى الملفات واسترجاعها في اي وقت"),
              FetureWidget("سهولة عمل نسخة سحابية للحفاض علي بياناتك"),
              FetureWidget("عمل العديد من التقارير المهمة"),
              FetureWidget(" حفض  التقارير في الملفات او مشاركتها"),
              FetureWidget("يمكنك إضافة التنبيهات للتذكير فيما بعد"),
              const SizedBox(
                height: 20,
              ),
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
            color: MyColors.lessBlackColor,
          )),
    );
  }
}

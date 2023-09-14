// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/reports_pdf_controller/new_journals_pdf_controller.dart';
import 'package:account_app/screen/all_reports/customer_accounts_in_accgroup_screen/customer_accounts_in_accgroup_screen.dart';
import 'package:account_app/screen/all_reports/account_move/account_move_screen.dart';
import 'package:account_app/screen/all_reports/accgroups_report_screen/accgroups_report_screen.dart';
import 'package:account_app/screen/all_reports/customer_account_reports/customer_account_report.dart';
import 'package:account_app/screen/customer_account/customer_account.dart';
import 'package:account_app/screen/all_reports/daily_report/daily_report_screen.dart';
import 'package:account_app/screen/quick_help/quick_help_list.dart';
import 'package:account_app/screen/settings/curency_setting.dart';
import 'package:account_app/screen/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';

class HomeReportsScreen extends StatelessWidget {
  HomeReportsScreen({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     color: MyColors.bg,
              //   ),
              //   child: Text(
              //     "تنبة",
              //     style: myTextStyles.body,
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: MyColors.containerSecondColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "التقارير",
                        style: MyTextStyles.title2,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      alignment: WrapAlignment.end,
                      runAlignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ReportItemWidget(
                          action: () {
                            Get.to(() => CustomerAccountsReportScreen());
                          },
                          title: "إجمالي المبالغ",
                        ),
                        ReportItemWidget(
                          action: () {
                            Get.to(() => DailyReportScreen());
                          },
                          title: "القيود اليومية",
                        ),
                        ReportItemWidget(
                          action: () {
                            Get.to(
                                () => CustomerAccountsInAccGroupReportScreen());
                          },
                          title: " إجمالي المبالغ حسب التصنيف",
                        ),
                        ReportItemWidget(
                          action: () {
                            Get.to(() => AccGroupsReportScreen());
                          },
                          title: " إجمالي التصنيفات",
                        ),
                        ReportItemWidget(
                          action: () {
                            Get.to(() => AccountMoveScreen());
                          },
                          title: " حركة الحسابات",
                        )
                        // item tow
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // second report item
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.bg,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (homeController.todaysJournals.isNotEmpty) {
                          NewDailyPdfController.generateTodayDailyReportPdf();
                        }
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.filePdf,
                        size: 17,
                        color: MyColors.secondaryTextColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "العمليات الحد يثة",
                      style: MyTextStyles.subTitle,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.clockRotateLeft,
                      color: MyColors.secondaryTextColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.containerColor,
                  ),
                  child: const JournalListWidget(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SettingScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.lessBlackColor),
                        child: const FaIcon(
                          FontAwesomeIcons.gear,
                          size: 13,
                          color: MyColors.bg,
                        ),
                      ),
                    ),
                    const Spacer(),
                    HomeReportFooterWidget(
                      title: "جميع الحسابات",
                      icon: FontAwesomeIcons.fileCircleCheck,
                      action: () {
                        Get.to(() => CustomerAccountsView());
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    HomeReportFooterWidget(
                      title: "العملات",
                      icon: FontAwesomeIcons.dollarSign,
                      action: () {
                        Get.to(() => CurencySettingScreen());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReportItemWidget extends StatelessWidget {
  final VoidCallback action;
  final String title;

  const ReportItemWidget({
    super.key,
    required this.action,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.bg,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: MyTextStyles.subTitle,
            ),
            const SizedBox(
              width: 10,
            ),
            const FaIcon(
              FontAwesomeIcons.fileLines,
              color: MyColors.secondaryTextColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeReportFooterWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback action;
  const HomeReportFooterWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.lessBlackColor,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: MyTextStyles.subTitle.copyWith(
                color: MyColors.containerColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FaIcon(
              icon,
              color: MyColors.containerColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

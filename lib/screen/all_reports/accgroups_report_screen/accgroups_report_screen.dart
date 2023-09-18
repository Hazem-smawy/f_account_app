// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/reports/accgroups_report_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_footer.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_headers.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/accgroup_controller.dart';
import '../../../controller/reports_pdf_controller/accgroups_pdf_controller.dart';

class AccGroupsReportScreen extends StatelessWidget {
  AccGroupsReportScreen({super.key});
  final AccGroupsReportController allAccGroupReportController =
      Get.put(AccGroupsReportController());
  final AccGroupController accGroupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ReportHeaderWidget(
                title: " إجمالي التصنيفات",
                action: () {
                  AccGroupsPdfContoller.generateAllAccGroupPdfReports();
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.containerSecondColor,
              ),
              child: ReportCurenyFilterWidget(
                // isAllGroupReport: true,
                action: () {
                  // allAccGroupReportController.totalCredit.value = 0;
                  // allAccGroupReportController.totalDebit.value = 0;

                  allAccGroupReportController.getAllAccGroupSammary();
                },
                curencyId: allAccGroupReportController.curencyId.value,
                controller: allAccGroupReportController,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: accGroupController.allAccGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  return AccGroupReportWidget(
                    accGroup: accGroupController.allAccGroups[index],
                  );
                },
              ),
            ),
            ReportFooterWidget(
              controller: allAccGroupReportController,
            )
          ],
        ),
      ),
    );
  }
}

class AccGroupReportWidget extends StatelessWidget {
  final AccGroup accGroup;
  AccGroupReportWidget({super.key, required this.accGroup});
  final AccGroupsReportController accGroupReportsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyColors.bg,
      ),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  GlobalUtitlity.formatNumberDouble(
                      number: (accGroupReportsController
                                  .getTotalDebit(accGroup.id!)
                                  .$2 -
                              accGroupReportsController
                                  .getTotalDebit(accGroup.id!)
                                  .$1)
                          .abs()),
                  style: MyTextStyles.subTitle.copyWith(
                    color: accGroupReportsController
                                .getTotalDebit(accGroup.id!)
                                .$1 <
                            accGroupReportsController
                                .getTotalDebit(accGroup.id!)
                                .$2
                        ? MyColors.creditColor
                        : MyColors.debetColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  GlobalUtitlity.formatNumberDouble(
                      number: accGroupReportsController
                          .getTotalDebit(accGroup.id!)
                          .$2),
                  style: MyTextStyles.subTitle
                      .copyWith(color: MyColors.creditColor),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  GlobalUtitlity.formatNumberDouble(
                      number: accGroupReportsController
                          .getTotalDebit(accGroup.id!)
                          .$1),
                  textAlign: TextAlign.right,
                  style: MyTextStyles.subTitle
                      .copyWith(color: MyColors.debetColor),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: Text(
                accGroup.name,
                textAlign: TextAlign.right,
                style: MyTextStyles.title2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

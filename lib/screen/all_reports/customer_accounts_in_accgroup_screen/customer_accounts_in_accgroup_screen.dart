// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/reports/accgourp_report_controller.dart';
import 'package:account_app/controller/reports_pdf_controller/customer_accounts_in_accgroup_pdf_controller.dart';
import 'package:account_app/screen/all_reports/customer_account_reports/customer_account_report.dart';
import 'package:account_app/screen/all_reports/customer_account_reports/row.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_footer.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/accgroup_controller.dart';
import '../../../widget/custom_dialog.dart';

class CustomerAccountsInAccGroupReportScreen extends StatelessWidget {
  CustomerAccountsInAccGroupReportScreen({super.key});
  final CustomerAccountsInAccGroupReportController accGroupReportController =
      Get.put(CustomerAccountsInAccGroupReportController());

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
                title: 'إجمالي المبالغ حسب التصنيف',
                action: () {
                  if (accGroupReportController
                      .allCustomerAccountsRow.isNotEmpty) {
                    CustomerAccountsInAccGroupPdfController
                        .generateAccGroupPdfReports();
                  } else {
                    CustomDialog.customSnackBar(
                        "ليس هناك شئ ل طباعتة", SnackPosition.BOTTOM, true);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: MyColors.bg,
                          ),
                          child: ReportAccGroupFilterWidget(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            accGroupReportController.accGroupId.value = 0;
                            accGroupReportController
                                .getCustomerAccountReportsForAccGroup();
                          },
                          child: Row(
                            children: [
                              Text("الكل",
                                  style: MyTextStyles.subTitle.copyWith(
                                    fontWeight: accGroupReportController
                                                .accGroupId.value ==
                                            0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: accGroupReportController
                                                .accGroupId.value ==
                                            0
                                        ? Colors.green
                                        : MyColors.secondaryTextColor,
                                  )),
                              SizedBox(
                                width: 6,
                              ),
                              FaIcon(
                                accGroupReportController.accGroupId.value == 0
                                    ? FontAwesomeIcons.circleCheck
                                    : FontAwesomeIcons.circle,
                                size: 15,
                                color:
                                    accGroupReportController.accGroupId.value ==
                                            0
                                        ? Colors.green
                                        : MyColors.secondaryTextColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.containerSecondColor,
                  ),
                  child: ReportCurenyFilterWidget(
                    action: () {
                      accGroupReportController
                          .getCustomerAccountReportsForAccGroup();
                    },
                    curencyId: accGroupReportController.curencyId.value,
                    controller: accGroupReportController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Obx(
              () => accGroupReportController.allCustomerAccountsRow.isEmpty
                  ? EmptyCustomerAccountReport()
                  : ListView.builder(
                      itemCount: accGroupReportController
                          .allCustomerAccountsRow.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomerAccountReportRowWidget(
                          cac: accGroupReportController
                              .allCustomerAccountsRow[index],
                        );
                      },
                    ),
            )),
            ReportFooterWidget(
              controller: accGroupReportController,
            )
          ],
        ),
      ),
    );
  }
}

class ReportAccGroupFilterWidget extends StatelessWidget {
  final AccGroupController accGroupController = Get.find();
  final CustomerAccountsInAccGroupReportController accGroupReportController =
      Get.find();

  ReportAccGroupFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(7),
        // margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: MyColors.bg.withOpacity(0.7),
        ),
        child: SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: accGroupController.allAccGroups.map((element) {
                return accGroupFilterItem(
                  action: () {
                    accGroupReportController.accGroupId.value = element.id ?? 0;

                    accGroupReportController
                        .getCustomerAccountReportsForAccGroup();
                  },
                  isSelected:
                      accGroupReportController.accGroupId.value == element.id,
                  lable: element.name,
                );
              }).toList()),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class accGroupFilterItem extends StatelessWidget {
  const accGroupFilterItem(
      {super.key,
      required this.action,
      required this.isSelected,
      required this.lable});
  final VoidCallback action;
  final bool isSelected;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 5,
          ),
          Text(
            lable,
            style: MyTextStyles.body.copyWith(
              color: isSelected
                  ? MyColors.primaryColor
                  : MyColors.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 5),
          FaIcon(
            isSelected ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
            size: 15,
            color: isSelected
                ? MyColors.primaryColor
                : MyColors.secondaryTextColor,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/reports/customer_accounts_report_controller.dart';
import 'package:account_app/controller/reports_pdf_controller/customer_accounts_pdf_controller.dart';
import 'package:account_app/screen/all_reports/customer_account_reports/row.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_footer.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/accgroup_controller.dart';
import '../../../models/accgroup_model.dart';
import '../../../widget/custom_dialog.dart';

class CustomerAccountsReportScreen extends StatelessWidget {
  CustomerAccountsReportScreen({super.key});
  final CustomerAccountReportController customerAccountReportController =
      Get.put(CustomerAccountReportController());

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
                title: 'إجمالي المبالغ',
                action: () {
                  if (customerAccountReportController
                      .allCustomerAccountsRow.isNotEmpty) {
                    CustomerAccountPdfController
                        .generateCustomerAccountPdfReports();
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(GestureDetector(
                        onTap: () => Get.back(),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: AccGroupCurencyListWidget(),
                        ),
                      ));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          //  color: MyColors.bg,
                        ),
                        child: Icon(Icons.filter_list_outlined)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.bg,
                      ),
                      child: ReportCurenyFilterWidget(
                          controller: customerAccountReportController,
                          curencyId:
                              customerAccountReportController.curencyId.value,
                          action: () {
                            customerAccountReportController
                                .getCustomerAccountReports();
                          }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Obx(
              () =>
                  customerAccountReportController.allCustomerAccountsRow.isEmpty
                      ? EmptyCustomerAccountReport()
                      : ListView.builder(
                          itemCount: customerAccountReportController
                              .allCustomerAccountsRow.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomerAccountReportRowWidget(
                              cac: customerAccountReportController
                                  .allCustomerAccountsRow[index],
                            );
                          },
                        ),
            )),
            ReportFooterWidget(
              controller: customerAccountReportController,
            )
          ],
        ),
      ),
    );
  }
}

class AccGroupCurencyListWidget extends StatelessWidget {
  AccGroupCurencyListWidget({
    super.key,
  });
  final AccGroupController accGroupController = Get.find();
  final CustomerAccountReportController customerAccountReportController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        top: 105,
        // right: Get.width / 2.3,
      ),
      width: Get.width / 2 - 30,
      //height: 300,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: accGroupController.allAccGroups.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: AccGroupReportListItemWidget(
                  accGroup: accGroupController.allAccGroups[index],
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              customerAccountReportController.getCustomerAccountReports();
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.lessBlackColor.withOpacity(0.9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "كل التصنيفات",
                    textAlign: TextAlign.right,
                    style: MyTextStyles.subTitle.copyWith(
                      color: MyColors.bg,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AccGroupReportListItemWidget extends StatelessWidget {
  final AccGroup accGroup;
  final CustomerAccountReportController customerAccountReportController =
      Get.find();
  AccGroupReportListItemWidget({
    super.key,
    required this.accGroup,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customerAccountReportController
            .getCustomerAccountReportsForAccGroup(accGroup.id!);
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.containerColor.withOpacity(0.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: Text(
                accGroup.name,
                textAlign: TextAlign.right,
                style: MyTextStyles.subTitle,
              ),
            ),
            const Spacer(),
            const FaIcon(
              FontAwesomeIcons.folderOpen,
              size: 14,
              color: MyColors.secondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

// empyt account
class EmptyCustomerAccountReport extends StatelessWidget {
  const EmptyCustomerAccountReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/customerAccount.png"),
            const SizedBox(
              height: 30,
            ),
            Text(
              "لاتوجد حسابات هنا",
              style: MyTextStyles.subTitle,
            )
          ],
        ));
  }
}

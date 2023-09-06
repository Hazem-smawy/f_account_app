// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/reports/customer_accounts_report_controller.dart';
import 'package:account_app/screen/all_reports/customer_account_reports/row.dart';
import 'package:account_app/screen/all_reports/reports_widget/empyt_report.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_footer.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/accgroup_controller.dart';
import '../../../models/accgroup_model.dart';

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ReportHeaderWidget(),
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
                      ? const EmptyReportListWidget()
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        top: 90,
        // right: Get.width / 2.3,
      ),
      width: Get.width / 2,
      //height: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "كل التصنيفات",
            style: myTextStyles.title2,
          ),
          const SizedBox(height: 10),
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
          // const Spacer(),
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
        margin: const EdgeInsets.only(top: 5),
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
                style: myTextStyles.subTitle,
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

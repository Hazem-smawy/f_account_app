// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/reports/account_move_controller.dart';
import 'package:account_app/controller/reports_pdf_controller/mony_movements_pdf_controller.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/screen/all_reports/account_movement_screen/account_movement_acc_group_list_widget.dart';
import 'package:account_app/screen/all_reports/account_movement_screen/row.dart';
import 'package:account_app/screen/all_reports/reports_widget/date_filter_widget.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_footer.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widget/custom_dialog.dart';

class AccountMoveScreen extends StatelessWidget {
  final AccountMovemoentController accountMovemoentController =
      Get.put(AccountMovemoentController());

  final AccGroupController accGroupController = Get.find();
  final CurencyController curencyController = Get.find();

  final CustomerController customerController = Get.find();

  final CustomerAccountController customerAccountController = Get.find();

  final TextEditingController textEditingController = TextEditingController();
  final DateTime fromDateTime = DateTime(2022, 1, 1);
  final DateTime toDateTime = DateTime.now();

  AccountMoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          accountMovemoentController.searchList.clear();
        },
        child: SafeArea(
            child: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (accountMovemoentController
                                          .customerAccountsJournals
                                          .isNotEmpty) {
                                        MoneyMovementPdfController
                                            .generateMoneyMovementReportPdf(
                                                share: false);
                                      } else {
                                        CustomDialog.customSnackBar(
                                            "ليس هناك شئ ل طباعتة",
                                            SnackPosition.BOTTOM,
                                            true);
                                      }
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.filePdf,
                                      color: MyColors.secondaryTextColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (accountMovemoentController
                                          .customerAccountsJournals
                                          .isNotEmpty) {
                                        final file =
                                            await MoneyMovementPdfController
                                                .generateMoneyMovementReportPdf(
                                                    share: true);

                                        if (file != null) {
                                          Share.shareXFiles([XFile(file.path)],
                                              text: 'حساب ');
                                        }
                                        //f
                                      } else {
                                        CustomDialog.customSnackBar(
                                            "ليس هناك شئ ل طباعتة",
                                            SnackPosition.BOTTOM,
                                            true);
                                      }
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.share,
                                      color: MyColors.secondaryTextColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      // color: MyColors.bg,
                                    ),
                                    child: TextFormField(
                                      controller: textEditingController,

                                      onChanged: (value) {
                                        accountMovemoentController
                                                .fromDate.value =
                                            fromDateTime.toIso8601String();
                                        accountMovemoentController
                                                .toDate.value =
                                            toDateTime.toIso8601String();
                                        accountMovemoentController
                                            .customerAccountsJournals
                                            .clear();

                                        accountMovemoentController
                                            .totalCredit.value = 0;
                                        accountMovemoentController
                                            .totalDebit.value = 0;
                                        if (value.isNotEmpty) {
                                          var customerList = customerController
                                              .allCustomers
                                              .where((p0) => p0.name
                                                  .toLowerCase()
                                                  .contains(
                                                      value.toLowerCase()))
                                              .toList();
                                          accountMovemoentController
                                                  .searchList.value =
                                              customerAccountController
                                                  .allCustomerAccounts
                                                  .where((p0) =>
                                                      customerList
                                                          .firstWhereOrNull(
                                                              (element) =>
                                                                  element.id ==
                                                                  p0.customerId) !=
                                                      null)
                                                  .toList();
                                          value = "";
                                        } else {
                                          accountMovemoentController.searchList
                                              .clear();
                                        }
                                      },

                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: MyTextStyles.subTitle.copyWith(
                                        color: MyColors.blackColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        fillColor:
                                            MyColors.containerSecondColor,
                                        focusColor: Colors.transparent,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 0,
                                        ),
                                        hintText: "بحث في حسابات العملاء",
                                        hintStyle: MyTextStyles.body.copyWith(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // style: myTextStyles.subTitle,
                                    ),
                                  )),
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 5,
                                          left: 10),
                                      color: MyColors.containerColor,
                                      child: const FaIcon(
                                        FontAwesomeIcons.arrowRightLong,
                                        color: MyColors.secondaryTextColor,
                                        size: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //filter
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DateFilterWidget(
                                            controller:
                                                accountMovemoentController,
                                            action: () {
                                              accountMovemoentController
                                                  .getCustomerAccountJournals();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.dialog(GestureDetector(
                                          onTap: () => Get.back(),
                                          child: Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                AccountMovementAccGroupListWidget(),
                                              ],
                                            ),
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // border: Border.all(
                                          //   color: MyColors.secondaryTextColor
                                          //       .withOpacity(0.4),
                                          //   width: 1,
                                          // )
                                          // color: MyColors.bg,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              accGroupController.allAccGroups
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      accountMovemoentController
                                                          .accGroupId.value)
                                                  .name,
                                              style: MyTextStyles.subTitle
                                                  .copyWith(
                                                color: MyColors.lessBlackColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons
                                                  .solidFolderClosed,
                                              size: 15,
                                              color: MyColors.lessBlackColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.bg,
                              ),
                              child: ReportCurenyFilterWidget(
                                  action: () {
                                    accountMovemoentController
                                        .getCustomerAccountJournals();
                                  },
                                  curencyId: accountMovemoentController
                                      .curencyId.value,
                                  controller: accountMovemoentController),
                            ),

                            // list
                            const SizedBox(height: 10),

                            Expanded(
                              child: accountMovemoentController
                                      .customerAccountsJournals.isEmpty
                                  ? EmptyCustomerAccountJournlsReport()
                                  : ListView.builder(
                                      itemCount: accountMovemoentController
                                          .customerAccountsJournals.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AccountMoveRowWidget(
                                          curency: curencyController.allCurency
                                              .firstWhere(
                                            (element) =>
                                                element.id ==
                                                accountMovemoentController
                                                    .curencyId.value,
                                          ),
                                          journal: accountMovemoentController
                                              .customerAccountsJournals[index],
                                          name: textEditingController.text,
                                        );
                                      },
                                    ),
                            ),
                          ],
                        )),
                  ),
                  ReportFooterWidget(
                    controller: accountMovemoentController,
                  ),
                ],
              ),

              //search list
              if (accountMovemoentController.searchList.isNotEmpty)
                Positioned(
                  top: 60,
                  right: 0,
                  left: 0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 3),
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.secondaryTextColor.withOpacity(0.3),
                        ),
                        child: ListView.builder(
                          itemCount:
                              accountMovemoentController.searchList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomerAccountsSearchListItem(
                              curencyId: accountMovemoentController
                                  .searchList[index].curencyId,
                              accGroupId: accountMovemoentController
                                  .searchList[index].accgroupId,
                              customerId: accountMovemoentController
                                  .searchList[index].customerId,
                              action: () {
                                textEditingController.text = customerController
                                    .allCustomers
                                    .firstWhere((element) =>
                                        element.id ==
                                        accountMovemoentController
                                            .searchList[index].customerId)
                                    .name;
                                //accId
                                accountMovemoentController.accGroupId.value =
                                    accountMovemoentController
                                        .searchList[index].accgroupId;

                                //curId
                                accountMovemoentController.curencyId.value =
                                    accountMovemoentController
                                        .searchList[index].curencyId;
                                //customerId
                                accountMovemoentController.customerId.value =
                                    accountMovemoentController
                                        .searchList[index].customerId;

                                accountMovemoentController.searchList.clear();
                                accountMovemoentController
                                    .getCustomerAccountJournals();
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
                          left: 35,
                          top: -10,
                          child: GestureDetector(
                            onTap: () {
                              accountMovemoentController.searchList.clear();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [MyShadow.blackShadow]),
                              child: const FaIcon(
                                FontAwesomeIcons.xmark,
                                size: 13,
                                color: Colors.red,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
            ],
          ),
        )),
      ),
    );
  }
}

// empyt account
class EmptyCustomerAccountJournlsReport extends StatelessWidget {
  const EmptyCustomerAccountJournlsReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
              "قم بإختيار الحساب من نافذة البحث",
              style: MyTextStyles.subTitle,
            )
          ],
        ));
  }
}

//search list

class CustomerAccountsSearchList extends StatelessWidget {
  final Customer customer;
  final VoidCallback action;

  const CustomerAccountsSearchList(
      {super.key, required this.customer, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 35,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(left: 3, bottom: 3, right: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.containerColor,
        ),
        child: Text(
          customer.name,
          textAlign: TextAlign.right,
          style: MyTextStyles.subTitle.copyWith(
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor,
          ),
        ),
      ),
    );
  }
}

class CustomerAccountsSearchListItem extends StatelessWidget {
  final int customerId;
  final int curencyId;
  final int accGroupId;
  final VoidCallback action;

  CustomerAccountsSearchListItem({
    Key? key,
    required this.customerId,
    required this.curencyId,
    required this.accGroupId,
    required this.action,
  }) : super(key: key);
  final CustomerController customerController = Get.find();
  final CurencyController curencyController = Get.find();
  final AccGroupController accGroupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        height: 35,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(left: 3, bottom: 3, right: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: MyColors.containerColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  curencyController.allCurency
                      .firstWhere((element) => element.id == curencyId)
                      .symbol,
                  textAlign: TextAlign.right,
                  style: MyTextStyles.body.copyWith(
                    fontWeight: FontWeight.normal,
                    color: MyColors.blackColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  accGroupController.allAccGroups
                      .firstWhere((element) => element.id == accGroupId)
                      .name,
                  textAlign: TextAlign.right,
                  style: MyTextStyles.body.copyWith(
                    fontWeight: FontWeight.normal,
                    color: MyColors.blackColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  customerController.allCustomers
                      .firstWhere((element) => element.id == customerId)
                      .name,
                  textAlign: TextAlign.right,
                  style: MyTextStyles.subTitle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: MyColors.blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

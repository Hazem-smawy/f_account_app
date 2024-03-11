import 'dart:io';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/reports_pdf_controller/details_journals_pdf_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/screen/details/details_row.dart';
import 'package:account_app/screen/details/details_share_sheet.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:intl/intl.dart' as DateFormater;

import 'detail_info_sheet.dart';
import 'detail_sammay_widget.dart';

class DetailsScreen extends StatefulWidget {
  final HomeModel homeModel;

  final bool accGoupStatus;
  final bool isFormReports;
  const DetailsScreen(
      {super.key,
      required this.homeModel,
      required this.accGoupStatus,
      required this.isFormReports});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Journal> journals = [];
  double onHem = 0.0;
  double onYou = 0.0;
  double resultMoney = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllJournals();
  }

  Future<void> getAllJournals() async {
    setState(() {
      isLoading = true;
    });
    var newJournals = await journalController
        .getAllJournalsForCustomerAccount(widget.homeModel.cacId ?? 0);

    setState(() {
      journals = newJournals;
      journals.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
    getAllCalculationForMoney();
    setState(() {
      isLoading = false;
    });
  }

  void getAllCalculationForMoney() {
    resultMoney = 0.0;
    var onHemPrivate = 0.0;
    var onYouPrivate = 0.0;
    for (var element in journals) {
      onHemPrivate += element.debit;
      onYouPrivate += element.credit;
    }
    setState(() {
      onHem = onHemPrivate;
      onYou = onYouPrivate;
      resultMoney = onYou - onHem;
    });
  }

  double getAccountMoney(Journal e) {
    var index = journals.indexOf(e);
    double result = 0.0;
    for (int i = journals.length - 1; i > index - 1; i--) {
      result += journals[i].credit - journals[i].debit;
    }
    return result;
  }

  JournalController journalController = Get.find();
  CustomerController customerController = Get.find();
  CurencyController curencyController = Get.find();

  Future<void> shareAction() async {
    if (journals.isNotEmpty) {
      File? file = await JournalPdfControls.generateJournlsPdfReports(
        journals: journals,
        totalCredit: onYou,
        totalDebit: onHem,
        customerId: widget.homeModel.caId ?? 0,
        curencyId: widget.homeModel.curId ?? 0,
        accGroupId: widget.homeModel.accGId ?? 0,
        share: true,
      );
      if (file != null) {
        Share.shareXFiles([XFile(file.path)], text: 'حساب ');
      }
    } else {
      CustomDialog.customSnackBar(
          "ليس هناك شئ لمشاركتة", SnackPosition.BOTTOM, true);
    }
  }

  Future<void> pdfAction() async {
    if (journals.isNotEmpty) {
      JournalPdfControls.generateJournlsPdfReports(
          journals: journals,
          totalCredit: onYou,
          totalDebit: onHem,
          customerId: widget.homeModel.caId ?? 0,
          curencyId: widget.homeModel.curId ?? 0,
          accGroupId: widget.homeModel.accGId ?? 0,
          share: false);
    } else {
      CustomDialog.customSnackBar(
          "ليس هناك شئ لطباعتة", SnackPosition.BOTTOM, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              CustomBackBtnWidget(
                shareAction: shareAction,
                action: pdfAction,
                icon: FontAwesomeIcons.solidFilePdf,
                title: customerController.allCustomers
                    .firstWhere(
                        (element) => element.id == widget.homeModel.caId)
                    .name,
              ),
              const SizedBox(height: 10),
              if (journals.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: MyColors.lessBlackColor,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width / 5,
                        child: Text(
                          'الحساب',
                          textAlign: TextAlign.center,
                          style: MyTextStyles.subTitle.copyWith(
                            color: MyColors.bg,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 9,
                        child: Text(
                          'التأريخ',
                          textAlign: TextAlign.center,
                          style: MyTextStyles.subTitle.copyWith(
                            color: MyColors.bg,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Container(
                        width: 20,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: onYou > onHem
                              ? MyColors.debetColor
                              : MyColors.creditColor,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: Get.width / 6,
                        child: Text(
                          'المبلغ',
                          textAlign: TextAlign.left,
                          style: MyTextStyles.subTitle.copyWith(
                            color: MyColors.bg,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: Get.width / 4,
                          child: Text(
                            ' التفاصيل',
                            textAlign: TextAlign.center,
                            style: MyTextStyles.subTitle.copyWith(
                              color: MyColors.bg,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                    ],
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              if (journals.isEmpty)
                Expanded(
                    child: isLoading
                        ? Container(
                            width: Get.width - 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: MyColors.bg.withOpacity(0.7),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: MyColors.lessBlackColor,
                              ),
                            ),
                          )
                        : const EmptyWidget(
                            imageName: 'assets/images/accGroup.png',
                            label: "لايوجد أي عمليات في هذا الحساب")),
              if (journals.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: journals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.dialog(
                            DetialInfoSheet(
                              action: getAllJournals,
                              homeModel: widget.homeModel,
                              name: customerController.allCustomers
                                  .firstWhere(
                                    (element) =>
                                        element.id == widget.homeModel.caId,
                                  )
                                  .name,
                              detailsRows: journals[index],
                              curency: curencyController.allCurency.firstWhere(
                                (element) =>
                                    element.id == widget.homeModel.curId,
                              ),
                              accountPaused: getStatus(),
                            ),
                          );
                        },
                        child: DetailsRowWidget(
                          journal: journals[index],
                          accountMoney: getAccountMoney(journals[index]),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              // const Spacer(),
              Row(
                children: [
                  DetailsSammaryWidget(
                    icon: FontAwesomeIcons.arrowUp,
                    title: "$onYou",
                    subTitle: "له",
                    color: MyColors.debetColor,
                  ),
                  const SizedBox(width: 3),
                  DetailsSammaryWidget(
                    icon: FontAwesomeIcons.arrowDown,
                    title: ' $onHem',
                    subTitle: "عليه",
                    color: MyColors.creditColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyColors.shadowColor),
                  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          DetailsShareSheetWidget(
                            pdfAction: pdfAction,
                            shareAction: shareAction,
                            customerPhone: customerController.allCustomers
                                .firstWhere((element) =>
                                    element.id == widget.homeModel.caId)
                                .phone,
                            debit: onHem,
                            credit: onYou,
                          ),
                        );
                      },
                      child: Container(
                        color: MyColors.bg,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const FaIcon(
                          Icons.share,
                          size: 20,
                          color: MyColors.lessBlackColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          curencyController.selectedCurency['symbol'],
                          style: MyTextStyles.body,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            GlobalUtitlity.formatNumberDouble(
                                number: resultMoney.abs()),
                            style: MyTextStyles.subTitle.copyWith(
                              color: MyColors.lessBlackColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          resultMoney < 0 ? ": علية" : ": لة",
                          style: MyTextStyles.subTitle.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: MyColors.shadowColor,
                            ),
                          ),
                          child: Center(
                            child: FaIcon(
                              resultMoney > 0
                                  ? FontAwesomeIcons.chevronUp
                                  : FontAwesomeIcons.chevronDown,
                              color: resultMoney > 0
                                  ? MyColors.debetColor
                                  : MyColors.creditColor,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 9),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isFormReports
          ? const SizedBox()
          : FloatingActionButton(
              backgroundColor:
                  getStatus() ? MyColors.primaryColor : MyColors.blackColor,
              onPressed: () {
                if (getStatus()) {
                  Get.bottomSheet(
                    NewRecordScreen(
                      isEdditing: false,
                      homeModel: widget.homeModel,
                    ),
                    isScrollControlled: true,
                  ).then((value) {
                    getAllJournals();
                  });
                } else {
                  CustomDialog.customSnackBar(
                      "تم ايقاف هذا الحساب من الاعدادات",
                      SnackPosition.BOTTOM,
                      false);
                  return;
                }
              },
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
    );
  }

  bool getStatus() {
    if (widget.accGoupStatus &&
        widget.homeModel.caStatus &&
        widget.homeModel.cacStatus) {
      return true;
    } else {
      return false;
    }
  }
}

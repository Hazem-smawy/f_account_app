import 'dart:io';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/reports_pdf_controller/details_journals_pdf_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/screen/details/details_row.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
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
  const DetailsScreen(
      {super.key, required this.homeModel, required this.accGoupStatus});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Journal> journals = [];
  double onHem = 0.0;
  double onYou = 0.0;
  double resultMoney = 0.0;

  @override
  void initState() {
    super.initState();
    getAllJournals();
  }

  Future<void> getAllJournals() async {
    var newJournals = await journalController
        .getAllJournalsForCustomerAccount(widget.homeModel.cacId ?? 0);

    setState(() {
      journals = newJournals;
      journals.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
    getAllCalculationForMoney();
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
  @override
  Widget build(BuildContext context) {
    return journals.isEmpty
        ? const SizedBox()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    CustomBackBtnWidget(
                      shareAction: () async {
                        File? file =
                            await JournalPdfControls.generateJournlsPdfReports(
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
                      },
                      action: () {
                        if (journals.isNotEmpty) {
                          JournalPdfControls.generateJournlsPdfReports(
                              journals: journals,
                              totalCredit: onYou,
                              totalDebit: onHem,
                              customerId: widget.homeModel.caId ?? 0,
                              curencyId: widget.homeModel.curId ?? 0,
                              accGroupId: widget.homeModel.accGId ?? 0,
                              share: false);
                        }
                      },
                      icon: FontAwesomeIcons.solidFilePdf,
                      title: customerController.allCustomers
                          .firstWhere(
                              (element) => element.id == widget.homeModel.caId)
                          .name,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 4),
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 20,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: widget.homeModel.totalCredit >
                                      widget.homeModel.totalDebit
                                  ? MyColors.debetColor
                                  : MyColors.creditColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: Get.width / 6,
                            child: Text('المبلغ',
                                textAlign: TextAlign.left,
                                style: MyTextStyles.subTitle.copyWith(
                                  color: MyColors.bg,
                                )),
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
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: journals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.dialog(DetialInfoSheet(
                                name: customerController.allCustomers
                                    .firstWhere((element) =>
                                        element.id == widget.homeModel.caId)
                                    .name,
                                detailsRows: journals[index],
                                curency: curencyController.allCurency
                                    .firstWhere((element) =>
                                        element.id == widget.homeModel.curId),
                              ));
                            },
                            child: DetailsRowWidget(
                              journal: journals[index],
                              accountMoney: getAccountMoney(journals[index])
                                  .abs()
                                  .toString(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        DetailsSammaryWidget(
                            icon: FontAwesomeIcons.arrowUp,
                            title: "$onYou",
                            subTitle: "له",
                            color: MyColors.debetColor),
                        const SizedBox(width: 3),
                        DetailsSammaryWidget(
                            icon: FontAwesomeIcons.arrowDown,
                            title: ' $onHem',
                            subTitle: "عليه",
                            color: MyColors.creditColor),
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
                          const SizedBox(
                            width: 20,
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
                                resultMoney < 0 ? "علية" : "لة",
                                style: MyTextStyles.subTitle,
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
            floatingActionButton: FloatingActionButton(
              backgroundColor:
                  getStatus() ? MyColors.primaryColor : MyColors.blackColor,
              onPressed: () {
                if (getStatus()) {
                  Get.bottomSheet(
                    NewRecordScreen(
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

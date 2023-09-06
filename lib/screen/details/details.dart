import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as DateFormater;

import 'detail_info_sheet.dart';
import 'detail_sammay_widget.dart';

class DetailsScreen extends StatefulWidget {
  HomeModel homeModel;

  bool accGoupStatus;
  DetailsScreen(
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
    // TODO: implement initState
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
                      icon: FontAwesomeIcons.solidFilePdf,
                      title: customerController.allCustomers
                          .firstWhere(
                              (element) => element.id == widget.homeModel.caId)
                          .name,
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: DataTable(
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  return MyColors.lessBlackColor;
                                  // Use the default value.
                                }),
                                columnSpacing: 5,
                                headingRowHeight: 45,
                                headingTextStyle:
                                    myTextStyles.subTitle.copyWith(
                                  color: MyColors.bg,
                                  fontSize: 12,
                                ),
                                dataTextStyle: myTextStyles.subTitle.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                                decoration: BoxDecoration(
                                    color: MyColors.bg,
                                    borderRadius: BorderRadius.circular(12)),
                                columns: [
                                  const DataColumn(label: Text('التأريخ')),
                                  const DataColumn(label: Text('المبلغ')),
                                  const DataColumn(
                                      label: Center(
                                    child: Text(
                                      ' تفاصيل',
                                    ),
                                  )),
                                  DataColumn(
                                      label: Container(
                                    width: 20,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: widget.homeModel.totalCredit >
                                              widget.homeModel.totalDebit
                                          ? MyColors.debetColor
                                          : MyColors.creditColor,
                                    ),
                                  )),
                                  const DataColumn(
                                    label: Text('الحساب'),
                                  ),
                                ],
                                rows: journals
                                    .map(
                                      (e) => DataRow(
                                          onLongPress: () {
                                            Get.dialog(DetialInfoSheet(
                                              name: customerController
                                                  .allCustomers
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      widget.homeModel.caId)
                                                  .name,
                                              detailsRows: e,
                                              curency: curencyController
                                                  .allCurency
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      widget.homeModel.curId),
                                            ));
                                          },
                                          cells: [
                                            DataCell(
                                              FittedBox(
                                                child: Text(
                                                  DateFormater.DateFormat.yMd()
                                                      .format(e.registeredAt),
                                                  style: myTextStyles.body,
                                                ),
                                              ),
                                            ),
                                            DataCell(FittedBox(
                                              child: Text(
                                                " ${(e.credit - e.debit).abs()}",
                                                style: myTextStyles.subTitle
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            )),
                                            DataCell(FittedBox(
                                              fit: BoxFit.fill,
                                              clipBehavior: Clip.hardEdge,
                                              child: Text(
                                                e.details,
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.clip,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: myTextStyles.body,
                                              ),
                                            )),
                                            DataCell(Container(
                                              width: 20,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: e.credit > e.debit
                                                    ? MyColors.debetColor
                                                    : MyColors.creditColor,
                                              ),
                                            )),
                                            DataCell(Text(
                                              getAccountMoney(e)
                                                  .abs()
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              style: myTextStyles.subTitle
                                                  .copyWith(
                                                      color:
                                                          MyColors.blackColor),
                                            )),
                                          ]),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        DetailsSammaryWidget(
                            icon: FontAwesomeIcons.arrowDown,
                            title: "$onYou",
                            subTitle: "له",
                            color: MyColors.debetColor),
                        const SizedBox(width: 5),
                        DetailsSammaryWidget(
                            icon: FontAwesomeIcons.arrowUp,
                            title: ' $onHem',
                            subTitle: "عليه",
                            color: MyColors.creditColor),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: MyColors.shadowColor),
                        color: MyColors.bg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MyColors.containerColor,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                Text(
                                  curencyController.selectedCurency['symbol'],
                                  style: myTextStyles.body.copyWith(
                                    fontSize: 10,
                                    color: MyColors.lessBlackColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 1,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: MyColors.secondaryTextColor
                                        .withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  curencyController.selectedCurency['name'],
                                  style: myTextStyles.body.copyWith(
                                    fontSize: 10,
                                    color: MyColors.lessBlackColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                curencyController.selectedCurency['symbol'],
                                style: myTextStyles.body,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FittedBox(
                                child: Text(
                                  "$resultMoney",
                                  style: myTextStyles.title2,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                resultMoney > 0 ? "عليك" : "لك",
                                style: myTextStyles.subTitle,
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
                                        ? FontAwesomeIcons.chevronDown
                                        : FontAwesomeIcons.chevronUp,
                                    color: resultMoney > 0
                                        ? MyColors.debetColor
                                        : MyColors.creditColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
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
                      "تم ايقاف هذا الحساب من الاعدادات", SnackPosition.BOTTOM);
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

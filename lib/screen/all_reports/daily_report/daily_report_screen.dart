// ignore_for_file: prefer_const_constructors

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/report_controller.dart';
import 'package:account_app/screen/all_reports/reports_widget/dialy_sammary_widget.dart';
import 'package:account_app/screen/all_reports/reports_widget/empyt_report.dart';
import 'package:account_app/screen/all_reports/reports_widget/report_headers.dart';

import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as dateFormater;

class DailyReportScreen extends StatelessWidget {
  final ReportsController reportsController = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReportHeaderWidget(),

                    //filters
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.bg,
                      ),
                      child: Column(
                        children: [
                          ReportFilterWidget(),
                          SizedBox(
                            height: 10,
                          ),
                          ReportCurenyFilterWidget(
                            controller: reportsController,
                            curencyId: reportsController.curencyId.value,
                            action: () {
                              reportsController.getJournalReport();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //list
              //list googse here

              Expanded(
                child: Obx(
                  () => Container(
                    child: reportsController.isLoadding.value
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: const CircularProgressIndicator.adaptive(),
                          )
                        : reportsController.journalsReports.isEmpty
                            ? const EmptyReportListWidget()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 5),
                                  itemCount:
                                      reportsController.journalsReports.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: MyColors.bg.withOpacity(0.5),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            dateFormater.DateFormat.MEd()
                                                .format(DateTime.parse(
                                                    reportsController
                                                            .journalsReports[
                                                        index]['date'])),
                                            textDirection: TextDirection.rtl,
                                            style: myTextStyles.body.copyWith(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Container(
                                            width: 20,
                                            height: 5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: reportsController
                                                                .journalsReports[
                                                            index]['debit'] >
                                                        reportsController
                                                                .journalsReports[
                                                            index]['credit']
                                                    ? MyColors.creditColor
                                                    : MyColors.debetColor),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            reportsController
                                                    .journalsReports[index]
                                                ['symbol'],
                                            style: myTextStyles.body,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: Get.width / 8,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                (reportsController
                                                                .journalsReports[
                                                            index]['debit'] -
                                                        reportsController
                                                                .journalsReports[
                                                            index]['credit'])
                                                    .toString(),
                                                style: myTextStyles.title2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: SizedBox(
                                              width: Get.width / 6,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      child: Text(
                                                        reportsController
                                                                .journalsReports[
                                                            index]['accName'],
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: myTextStyles
                                                            .subTitle
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const FaIcon(
                                                    FontAwesomeIcons.folder,
                                                    size: 12,
                                                    color: MyColors
                                                        .secondaryTextColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // const Spacer(),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    // width: Get.width / 2.7,
                                                    child: FittedBox(
                                                      child: Text(
                                                        reportsController
                                                                .journalsReports[
                                                            index]['name'],
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: myTextStyles
                                                            .subTitle
                                                            .copyWith(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                ),
              ),

              // footer here
              if (reportsController.curencyId.value != 0)
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ReportSammaryWidget(
                            icon: FontAwesomeIcons.arrowUp,
                            title: reportsController.totalDebit.toString(),
                            subTitle: "لك",
                            color: Colors.green,
                            curencyId: reportsController.curencyId.value,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          ReportSammaryWidget(
                            curencyId: reportsController.curencyId.value,
                            icon: FontAwesomeIcons.arrowDown,
                            title: reportsController.totalCredit.toString(),
                            subTitle: "عليك",
                            color: Colors.red,
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: MyColors.shadowColor),
                          color: MyColors.bg,
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            FaIcon(
                              reportsController.totalDebit.value >=
                                      reportsController.totalCredit.value
                                  ? FontAwesomeIcons.arrowUp
                                  : FontAwesomeIcons.arrowDown,
                              size: 10,
                              color: reportsController.totalDebit.value >=
                                      reportsController.totalCredit.value
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              (reportsController.totalDebit.value -
                                      reportsController.totalCredit.value)
                                  .toString(),
                              style: myTextStyles.title1,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              reportsController.totalDebit.value <
                                      reportsController.totalCredit.value
                                  ? "عليك"
                                  : "لك",
                              style: myTextStyles.body,
                            ),
                            Spacer(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportFilterWidget extends StatelessWidget {
  final ReportsController reportsController = Get.find();
  Future _selectFromDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (picked != null &&
        picked != DateTime.parse(reportsController.fromDate.value)) {
      picked;
      reportsController.fromDate.value = picked.toIso8601String();
      reportsController.getJournalReport();
    }
  }

  Future _selectToDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (picked != null &&
        picked != DateTime.parse(reportsController.toDate.value)) {
      reportsController.toDate.value = picked.toIso8601String();
      reportsController.getJournalReport();
    }
  }

  @override
  Widget build(BuildContext context) {
    // reportsController.fromDate.value = fromDate.toIso8601String();
    // reportsController.toDate.value = toDate.toIso8601String();
    return Obx(
      () => Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "إجمالي",
                style: myTextStyles.subTitle.copyWith(
                  color: MyColors.lessBlackColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 15,
                color: MyColors.lessBlackColor,
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Text(
                "تفصيلي",
                style: myTextStyles.subTitle.copyWith(
                  color: MyColors.secondaryTextColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const FaIcon(
                FontAwesomeIcons.circle,
                size: 15,
                color: MyColors.secondaryTextColor,
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _selectToDate(context);
            },
            child: DateFileterItemWidget(
              date: DateTime.parse(reportsController.toDate.value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "الى",
              style: myTextStyles.title2.copyWith(
                color: MyColors.blackColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _selectFromDate(context);
            },
            child: DateFileterItemWidget(
              date: DateTime.parse(reportsController.fromDate.value),
            ),
          ),
        ],
      ),
    );
  }
}

class DateFileterItemWidget extends StatelessWidget {
  final DateTime date;
  DateFileterItemWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor,
      ),
      child: Row(
        children: [
          Text(
            dateFormater.DateFormat.yMd().format(date),
            style: myTextStyles.body.copyWith(
              color: MyColors.secondaryTextColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const FaIcon(
            FontAwesomeIcons.calendarDays,
            color: MyColors.secondaryTextColor,
            size: 13,
          ),
        ],
      ),
    );
  }
}

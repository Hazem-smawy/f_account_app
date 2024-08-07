import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date_formater;

import '../new_record/new_record.dart';

class DetialInfoSheet extends StatelessWidget {
  final String name;
  final Journal detailsRows;
  final Curency curency;
  final JournalController journalController = Get.find();
  final HomeModel homeModel;
  final VoidCallback action;
  final bool accountPaused;
  final bool isFromReports;

  DetialInfoSheet({
    super.key,
    required this.name,
    required this.detailsRows,
    required this.curency,
    required this.homeModel,
    required this.action,
    required this.accountPaused,
    required this.isFromReports,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Row(
                  children: [
                    if (!isFromReports)
                      GestureDetector(
                        onTap: () {
                          if (accountPaused) {
                            CustomDialog.showDialog(
                                title: "حذف",
                                description: "هل أنت متأكد من حذف هذا السجل",
                                icon: FontAwesomeIcons.solidTrashCan,
                                color: Colors.red,
                                action: () async {
                                  await journalController
                                      .deleteJournal(detailsRows);
                                  action();
                                  Get.back();
                                  Get.back();
                                });
                          } else {
                            CustomDialog.customSnackBar(
                              " تم ايقاف هذا الحساب من الاعدادات للحذف قم بتغير الإعدادات",
                              SnackPosition.BOTTOM,
                              false,
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(
                              left: 10, right: 5, top: 15, bottom: 15),
                          color: MyColors.containerColor,
                          child: FaIcon(
                            FontAwesomeIcons.solidTrashCan,
                            color: Colors.red.withOpacity(0.7),
                            size: 20,
                          ),
                        ),
                      ),
                    if (!isFromReports)
                      GestureDetector(
                        onTap: () {
                          if (accountPaused) {
                            Get.back();
                            journalController.newJournal
                                .addAll(detailsRows.toMap());
                            Get.bottomSheet(
                              NewRecordScreen(
                                homeModel: homeModel,
                                isEdditing: true,
                              ),
                              isScrollControlled: true,
                            ).then((value) {
                              action();
                            });
                          } else {
                            CustomDialog.customSnackBar(
                              " تم ايقاف هذا الحساب من الاعدادات ل التعديل قم بتغير الإعدادات",
                              SnackPosition.BOTTOM,
                              false,
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 15,
                            top: 15,
                            bottom: 15,
                          ),
                          color: MyColors.containerColor,
                          child: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: MyColors.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    if (isFromReports)
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 15,
                          bottom: 15,
                        ),
                        color: MyColors.containerColor,
                        child: const SizedBox(
                          height: 10,
                          width: 0,
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  name,
                  style: MyTextStyles.title2,
                ),
                const Spacer(),
                const FaIcon(Icons.more_vert_rounded),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),

            const Divider(),
            //  const SizedBox(height: 5),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        // const SizedBox(width: 5),
                        Container(
                          width: 20,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: detailsRows.credit > detailsRows.debit
                                ? MyColors.debetColor
                                : MyColors.creditColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          GlobalUtitlity.formatNumberDouble(
                            number:
                                (detailsRows.credit - detailsRows.debit).abs(),
                          ),
                          style: MyTextStyles.subTitle
                              .copyWith(color: MyColors.blackColor),
                        ),
                        const Spacer(),
                        const InfoTitleWidget(
                          title: "المبلغ",
                          icon: FontAwesomeIcons.moneyBill,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          curency.symbol,
                          style: MyTextStyles.title2.copyWith(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          curency.name,
                          style: MyTextStyles.title2.copyWith(
                            fontWeight: FontWeight.normal,
                            color: MyColors.blackColor,
                          ),
                        ),
                        const InfoTitleWidget(
                          title: "العمله",
                          icon: FontAwesomeIcons.dollarSign,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date_formater.DateFormat.yMEd()
                              .format(detailsRows.registeredAt),
                          style: MyTextStyles.title2.copyWith(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.normal),
                        ),
                        const InfoTitleWidget(
                          title: "التاريخ",
                          icon: FontAwesomeIcons.calendarCheck,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date_formater.DateFormat.Hm()
                              .format(detailsRows.createdAt),
                          style: MyTextStyles.title2.copyWith(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.normal),
                        ),
                        const InfoTitleWidget(
                          title: "الوقت",
                          icon: FontAwesomeIcons.clock,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date_formater.DateFormat.yMEd()
                              .format(detailsRows.createdAt),
                          style: MyTextStyles.title2.copyWith(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.normal),
                        ),
                        const InfoTitleWidget(
                          title: "تأريخ الإنشاء",
                          icon: FontAwesomeIcons.calendarCheck,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date_formater.DateFormat.Hm()
                              .format(detailsRows.createdAt),
                          style: MyTextStyles.title2.copyWith(
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const InfoTitleWidget(
                          title: "وقت الإنشاء",
                          icon: FontAwesomeIcons.clock,
                        ),
                      ],
                    ),
                    const Divider(),

                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          "التفاصيل",
                          style: MyTextStyles.subTitle.copyWith(
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.bg.withOpacity(0.7),
                          ),
                          child: Text(
                            detailsRows.details,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            style: MyTextStyles.subTitle.copyWith(
                                fontWeight: FontWeight.normal,
                                color: MyColors.lessBlackColor),
                          ),
                        )
                      ],
                    ),
                    //  Divider(),
                    const SizedBox(height: 20),
                    const Spacer(),

                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MyColors.secondaryTextColor,
                              ),
                              child: Text(
                                "رجوع",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.subTitle
                                    .copyWith(color: MyColors.bg),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class InfoTitleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const InfoTitleWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: MyTextStyles.subTitle.copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 7),
        Container(
          width: 20,
          alignment: Alignment.center,
          child: FaIcon(
            icon,
            size: 15,
            color: MyColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

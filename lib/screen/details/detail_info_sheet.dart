import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as DateFormater;

class DetialInfoSheet extends StatelessWidget {
  final name;
  Journal detailsRows;
  Curency curency;

  DetialInfoSheet(
      {super.key,
      required this.name,
      required this.detailsRows,
      required this.curency});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: myTextStyles.title2,
              ),
              //Divider(),
              const SizedBox(height: 25),
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
                    "${detailsRows.credit - detailsRows.debit}",
                    style: myTextStyles.subTitle
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
                    style: myTextStyles.subTitle.copyWith(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    curency.name,
                    style: myTextStyles.subTitle.copyWith(
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
                    DateFormater.DateFormat.yMEd()
                        .format(detailsRows.registeredAt),
                    style: myTextStyles.subTitle.copyWith(
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
                    DateFormater.DateFormat.Hm().format(detailsRows.createdAt),
                    style: myTextStyles.subTitle.copyWith(
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
                    DateFormater.DateFormat.yMEd()
                        .format(detailsRows.createdAt),
                    style: myTextStyles.subTitle.copyWith(
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
                    DateFormater.DateFormat.Hm().format(detailsRows.createdAt),
                    style: myTextStyles.subTitle.copyWith(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.normal),
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
                    style: myTextStyles.subTitle.copyWith(
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
                      style: myTextStyles.subTitle.copyWith(
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
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.secondaryTextColor,
                  ),
                  child: Text(
                    "إلغاء",
                    textAlign: TextAlign.center,
                    style: myTextStyles.subTitle.copyWith(color: MyColors.bg),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
            ],
          ),
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
          style: myTextStyles.subTitle.copyWith(fontWeight: FontWeight.normal),
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

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as dateFormater;

class DateFilterWidget extends StatelessWidget {
  final controller;
  final VoidCallback action;
  DateFilterWidget({key, required this.controller, required this.action});
  Future _selectFromDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (picked != null && picked != DateTime.parse(controller.fromDate.value)) {
      picked;
      controller.fromDate.value = picked.toIso8601String();
      action();
    }
  }

  Future _selectToDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (picked != null && picked != DateTime.parse(controller.toDate.value)) {
      controller.toDate.value = picked.toIso8601String();
      action();
    }
  }

  @override
  Widget build(BuildContext context) {
    // reportsController.fromDate.value = fromDate.toIso8601String();
    // reportsController.toDate.value = toDate.toIso8601String();
    return Obx(
      () => Row(
        children: [
          Spacer(),
          GestureDetector(
            onTap: () {
              _selectToDate(context);
            },
            child: DateFileterItemWidget(
              date: DateTime.parse(controller.toDate.value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "الى",
              style: myTextStyles.subTitle.copyWith(
                color: MyColors.blackColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _selectFromDate(context);
            },
            child: DateFileterItemWidget(
              date: DateTime.parse(controller.fromDate.value),
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

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart' as dateFormater;

import '../../../constant/colors.dart';

class CustomerAccountReportRowWidget extends StatelessWidget {
  final CustomerAccount cac;
  CustomerAccountReportRowWidget({super.key, required this.cac});
  final AccGroupController accGroupController = Get.find();
  final CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: MyColors.bg.withOpacity(0.5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 8,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                cac.totalDebit.toString(),
                style: myTextStyles.title2.copyWith(color: Colors.green),
              ),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          SizedBox(
            width: Get.width / 8,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                cac.totalCredit.toString(),
                style: myTextStyles.title2.copyWith(color: Colors.red),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      clipBehavior: Clip.hardEdge,
                      child: Text(
                        accGroupController.allAccGroups
                            .firstWhere(
                                (element) => element.id == cac.accgroupId)
                            .name,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: myTextStyles.subTitle.copyWith(
                          fontWeight: FontWeight.normal,
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
                    color: MyColors.secondaryTextColor,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    // width: Get.width / 2.7,
                    child: FittedBox(
                      child: Text(
                        customerController.allCustomers
                            .firstWhere(
                                (element) => element.id == cac.customerId)
                            .name,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: myTextStyles.subTitle
                            .copyWith(overflow: TextOverflow.ellipsis),
                        overflow: TextOverflow.ellipsis,
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
  }
}

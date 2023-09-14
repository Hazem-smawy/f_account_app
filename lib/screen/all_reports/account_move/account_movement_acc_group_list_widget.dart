// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/reports/account_move_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccountMovementAccGroupListWidget extends StatelessWidget {
  AccountMovementAccGroupListWidget({
    super.key,
  });
  final AccGroupController accGroupController = Get.find();
  final AccountMovemoentController accountMovemoentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 15,
        top: 110,
        // right: Get.width / 2.3,
      ),
      width: Get.width / 2 - 30,
      //height: 300,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: accGroupController.allAccGroups.length,
            itemBuilder: (BuildContext context, int index) {
              return AccountMovementAccGroupListItemWidget(
                accGroup: accGroupController.allAccGroups[index],
                action: () {
                  accountMovemoentController.accGroupId.value =
                      accGroupController.allAccGroups[index].id ?? 0;
                  accountMovemoentController.getCustomerAccountJournals();
                },
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

class AccountMovementAccGroupListItemWidget extends StatelessWidget {
  final AccGroup accGroup;
  final VoidCallback action;
  const AccountMovementAccGroupListItemWidget(
      {super.key, required this.accGroup, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
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
                style: MyTextStyles.subTitle,
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

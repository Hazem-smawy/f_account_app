import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/alert_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/screen/alert_screen/alert_screen.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyAppBarWidget extends StatelessWidget {
  final AccGroup? accGroup;
  final VoidCallback action;
  final VoidCallback reportsAction;
  MyAppBarWidget(
      {super.key,
      required GlobalKey<ScaffoldState> globalKey,
      required this.accGroup,
      required this.action,
      required this.reportsAction})
      : _globalKey = globalKey;

  final GlobalKey<ScaffoldState> _globalKey;
  final AccGroupController accGroupController = Get.find();
  final AccGroupCurencyController accGroupCurencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    var accGroupName = "";

    if (accGroupCurencyController.allAccgroupsAndCurency.isNotEmpty) {
      final accGroupId = accGroupCurencyController
          .allAccgroupsAndCurency[accGroupCurencyController.pageViewCount.value]
          .accGroupId;
      accGroupName = accGroupController.allAccGroups.isNotEmpty
          ? accGroupController.allAccGroups
                  .firstWhereOrNull((element) => element.id == accGroupId)
                  ?.name ??
              " "
          : "";
    }
    AlertController alertController = Get.find();

    return Obx(
      () => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
            color: MyColors.lessBlackColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(GestureDetector(
                  onTap: () => Get.back(),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: AccGroupCurencyListWidget(
                      goToPageAction: action,
                    ),
                  ),
                ));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.lessBlackColor,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.solidFolderClosed,
                  size: 20,
                  color: MyColors.containerColor,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => Get.to(() => AlertScreen()),
              child: Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.lessBlackColor,
                    ),
                    child: const FaIcon(Icons.access_alarms_outlined,
                        size: 20, color: MyColors.containerColor),
                  ),
                  if (alertController.newAlerts.isNotEmpty)
                    Positioned(
                        top: 7,
                        left: 2,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ))
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (!accGroupCurencyController.homeReportShow.value)
              GestureDetector(
                onTap: () async {
                  reportsAction();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  color: MyColors.lessBlackColor,
                  child: const Icon(
                    Icons.flash_on,
                    size: 20,
                    color: MyColors.bg,
                  ),
                ),
              ),
            const SizedBox(
              width: 5,
            ),
            const Spacer(),
            Text(
              accGroupCurencyController.homeReportShow.value
                  ? "مساعدة سريعة"
                  : accGroupName,
              style:
                  MyTextStyles.title2.copyWith(color: MyColors.containerColor),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                _globalKey.currentState?.openEndDrawer();
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.lessBlackColor,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.bars,
                  color: MyColors.containerColor,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccGroupCurencyListWidget extends StatelessWidget {
  AccGroupCurencyListWidget({super.key, required this.goToPageAction});
  final AccGroupCurencyController accGroupCurencyController = Get.find();
  final AccGroupController accGroupController = Get.find();
  final CurencyController curencyController = Get.find();
  final VoidCallback goToPageAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        top: 60,
        // right: Get.width / 2.3,
      ),
      width: Get.width / 2,
      //height: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "كل التصنيفات",
            style: MyTextStyles.title2,
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: accGroupCurencyController.allAccgroupsAndCurency.length,
            itemBuilder: (BuildContext context, int index) {
              var accGroup = accGroupController.allAccGroups.firstWhere(
                (element) =>
                    element.id ==
                    accGroupCurencyController
                        .allAccgroupsAndCurency[index].accGroupId,
              );
              var curency = curencyController.allCurency.firstWhereOrNull(
                (element) =>
                    element.id ==
                    accGroupCurencyController
                        .allAccgroupsAndCurency[index].curencyId,
              );
              return GestureDetector(
                onTap: () {
                  Get.back();
                  accGroupCurencyController.pageViewCount.value =
                      accGroupCurencyController.allAccgroupsAndCurency
                          .indexWhere(
                    (element) =>
                        element.accGroupId == accGroup.id &&
                        element.curencyId == curency?.id,
                  );
                  goToPageAction();
                },
                child: AccGroupCurencyListItemWidget(
                  accGroup: accGroup,
                  curency: curency,
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          // const Spacer(),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.to(() => AccGroupSettingScreen());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.lessBlackColor.withOpacity(0.9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "اضافه",
                    textAlign: TextAlign.right,
                    style: MyTextStyles.subTitle.copyWith(
                      color: MyColors.containerColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AccGroupCurencyListItemWidget extends StatelessWidget {
  final AccGroup accGroup;
  final Curency? curency;
  const AccGroupCurencyListItemWidget({
    super.key,
    required this.accGroup,
    required this.curency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: !accGroup.status || !(curency?.status ?? true)
            ? MyColors.blackColor.withOpacity(0.1)
            : MyColors.containerColor.withOpacity(0.7),
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
          if (curency != null)
            Text(
              curency?.symbol ?? "",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: MyTextStyles.subTitle.copyWith(
                fontWeight: FontWeight.normal,
                color: MyColors.blackColor,
              ),
            ),
          if (curency == null)
            const FaIcon(
              FontAwesomeIcons.folderOpen,
              size: 14,
              color: MyColors.secondaryTextColor,
            ),
        ],
      ),
    );
  }
}

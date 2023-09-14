import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/screen/home/home.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:account_app/widget/empty_accGroup_widget.dart';
import 'package:account_app/widget/my_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:account_app/screen/quick_help/quick_help_screen.dart';

class MyMainScreen extends StatelessWidget {
  MyMainScreen({super.key});
  final AccGroupCurencyController accGroupCurencyController = Get.find();

  final AccGroupController accGroupController = Get.find();

  final CurencyController curencyController = Get.find();
  final HomeController homeController = Get.find();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      endDrawer: MyDrawerView(),
      body: SafeArea(
        child: Obx(() =>
            accGroupCurencyController.allAccgroupsAndCurency.isEmpty &&
                    curencyController.allCurency.isEmpty &&
                    accGroupController.allAccGroups.isEmpty
                ? EmptyAccGroupsWidget()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyAppBarWidget(
                          reportsAction: () {
                            controller.animateToPage(
                                accGroupCurencyController
                                    .allAccgroupsAndCurency.length,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          action: () {
                            controller.animateToPage(
                                accGroupCurencyController.pageViewCount.value,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          globalKey: _globalKey,
                          accGroup: accGroupCurencyController
                                  .allAccgroupsAndCurency.isNotEmpty
                              ? accGroupController.allAccGroups
                                      .firstWhereOrNull((element) =>
                                          // ignore: unrelated_type_equality_checks
                                          element.id ==
                                          accGroupCurencyController
                                                  .allAccgroupsAndCurency[
                                              accGroupCurencyController
                                                  .pageViewCount.value]) ??
                                  AccGroup(
                                      name: "name",
                                      status: true,
                                      createdAt: DateTime.now(),
                                      modifiedAt: DateTime.now())
                              : AccGroup(
                                  name: "name",
                                  status: true,
                                  createdAt: DateTime.now(),
                                  modifiedAt: DateTime.now())),
                      Expanded(
                        child: PageView.builder(
                            controller: controller,
                            onPageChanged: (value) {
                              if (value <
                                  accGroupCurencyController
                                      .allAccgroupsAndCurency.length) {
                                accGroupCurencyController.homeReportShow.value =
                                    false;
                                accGroupCurencyController.pageViewCount.value =
                                    value;

                                Curency? selectedCurency = curencyController
                                    .allCurency
                                    .firstWhereOrNull((element) =>
                                        element.id ==
                                        accGroupCurencyController
                                            .allAccgroupsAndCurency[value]
                                            .curencyId);
                                curencyController.selectedCurency
                                    .addAll(selectedCurency?.toEditMap() ?? {});
                              } else {
                                accGroupCurencyController.homeReportShow.value =
                                    true;
                              }
                            },
                            reverse: true,
                            itemCount: accGroupCurencyController
                                    .allAccgroupsAndCurency.length +
                                1,
                            itemBuilder: (context, index) {
                              if (index <
                                  accGroupCurencyController
                                      .allAccgroupsAndCurency.length) {
                                final accCurIds = accGroupCurencyController
                                    .allAccgroupsAndCurency[index];
                                return Obx(
                                  () => HomeScreen(
                                      rows: homeController.loadData
                                          .where((p0) =>
                                              p0.curId == accCurIds.curencyId &&
                                              p0.accGId == accCurIds.accGroupId)
                                          .toList(),
                                      accGroup: accGroupController.allAccGroups.firstWhere((element) =>
                                          element.id == accCurIds.accGroupId),
                                      stauts: accGroupController.allAccGroups
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  accGroupCurencyController
                                                      .allAccgroupsAndCurency[
                                                          accGroupCurencyController
                                                              .pageViewCount
                                                              .value]
                                                      .accGroupId)
                                              .status &&
                                          (curencyController.allCurency.firstWhereOrNull((element) => element.id == accCurIds.curencyId)?.status ?? true),
                                      curency: curencyController.allCurency.firstWhereOrNull((element) => element.id == accCurIds.curencyId)),
                                );
                              } else {
                                return HomeReportsScreen();
                              }
                            }),
                      ),
                    ],
                  )),
      ),
      floatingActionButton: Obx(
        () => !accGroupCurencyController.homeReportShow.value &&
                accGroupController.allAccGroups.isNotEmpty &&
                accGroupCurencyController.allAccgroupsAndCurency.isNotEmpty
            ? curencyController.allCurency.isEmpty
                ? const SizedBox()
                : FloatingActionButton(
                    elevation: 0,
                    backgroundColor: accGroupController.allAccGroups
                            .firstWhere((element) =>
                                element.id ==
                                accGroupCurencyController
                                    .allAccgroupsAndCurency[
                                        accGroupCurencyController
                                            .pageViewCount.value]
                                    .accGroupId)
                            .status
                        ? MyColors.primaryColor
                        : MyColors.blackColor,
                    onPressed: () {
                      if (accGroupController.allAccGroups
                              .firstWhere((element) =>
                                  element.id ==
                                  accGroupCurencyController
                                      .allAccgroupsAndCurency[
                                          accGroupCurencyController
                                              .pageViewCount.value]
                                      .accGroupId)
                              .status ==
                          true) {
                        if (accGroupController.allAccGroups.isNotEmpty &&
                            curencyController.allCurency.isNotEmpty) {
                          Get.bottomSheet(
                            NewAccountScreen(
                              accGroupId: accGroupCurencyController
                                  .allAccgroupsAndCurency[
                                      accGroupCurencyController
                                          .pageViewCount.value]
                                  .accGroupId,
                              curencyId: accGroupCurencyController
                                  .allAccgroupsAndCurency[
                                      accGroupCurencyController
                                          .pageViewCount.value]
                                  .curencyId,
                            ),
                            isScrollControlled: true,
                          ).then((value) async {
                            homeController
                                .getCustomerAccountsFromCurencyAndAccGroupIds();
                            accGroupCurencyController
                                .getAllAccGroupAndCurency()
                                .then((value) {
                              var index = accGroupCurencyController
                                  .allAccgroupsAndCurency
                                  .indexWhere((element) =>
                                      element.accGroupId ==
                                          accGroupCurencyController
                                              .allAccgroupsAndCurency[
                                                  accGroupCurencyController
                                                      .pageViewCount.value]
                                              .accGroupId &&
                                      element.curencyId ==
                                          curencyController
                                              .selectedCurency['id']);
                              if (index > -1) {
                                try {
                                  controller.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.linear);
                                } catch (e) {
                                  CustomDialog.customSnackBar(
                                      "حدث خطأ", SnackPosition.BOTTOM);
                                }
                              }
                            });
                          });
                        }
                      } else {
                        CustomDialog.customSnackBar(
                            "هذا التصنيف موقف", SnackPosition.BOTTOM);
                        return;
                      }
                    },
                    child: const FaIcon(FontAwesomeIcons.plus),
                  )
            : const SizedBox(),
      ),
    );
  }
}

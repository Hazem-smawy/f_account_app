import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/notification.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccGroupSettingScreen extends StatelessWidget {
  AccGroupSettingScreen({super.key});
  final AccGroupController accGroupController = Get.put(AccGroupController());
  final CustomerAccountController customerAccountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(
            () => Column(
              children: [
                CustomBackBtnWidget(title: "التصنيفات"),
                const SizedBox(height: 15),
                if (accGroupController.allAccGroups.isEmpty)
                  EmptyWidget(
                    imageName: 'assets/images/accGroup.png',
                    label: "لايوجد أي تصنيف , قم بالإضافة",
                  ),
                if (accGroupController.allAccGroups.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DataTable(
                                showCheckboxColumn: true,
                                horizontalMargin: 20,
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  return MyColors.lessBlackColor;
                                  // Use the default value.
                                }),
                                columnSpacing: 10,
                                headingRowHeight: 50,
                                headingTextStyle: myTextStyles.title2.copyWith(
                                  color: MyColors.bg,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                dataTextStyle: myTextStyles.subTitle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                decoration: BoxDecoration(
                                    color: MyColors.bg,
                                    borderRadius: BorderRadius.circular(12)),
                                columns: const [
                                  DataColumn(label: SizedBox(width: 10)),
                                  DataColumn(
                                      label: Expanded(child: Text('الاسم'))),
                                  DataColumn(
                                      label: Center(
                                    child: Text(
                                      ' الحسابات',
                                    ),
                                  )),
                                  DataColumn(
                                    label: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                                rows: accGroupController.allAccGroups.map(
                                  (element) {
                                    return DataRow(cells: [
                                      DataCell(GestureDetector(
                                        onTap: () => CustomDialog.showDialog(
                                            title: "تعد يل",
                                            description:
                                                "هل انت متاكد من تعد يل هذا التصنيف",
                                            color: Colors.green,
                                            icon: FontAwesomeIcons.penToSquare,
                                            action: () {
                                              if (Get.isDialogOpen == true) {
                                                Get.back();
                                              }
                                              accGroupController.newAccGroup
                                                  .addAll(element.toEditMap());
                                              Get.bottomSheet(
                                                      NewAccGroupSheet(
                                                        isEditing: true,
                                                      ),
                                                      isScrollControlled: true)
                                                  .then((value) {
                                                accGroupController.newAccGroup
                                                    .clear();
                                              });
                                            }),
                                        child: const FaIcon(
                                          FontAwesomeIcons.penToSquare,
                                          size: 17,
                                          color: MyColors.primaryColor,
                                        ),
                                      )),
                                      DataCell(Text(
                                        element.name,
                                        style: myTextStyles.title2,
                                      )),
                                      DataCell(Text(
                                        "${customerAccountController.allCustomerAccounts.where((p0) => p0.accgroupId == element.id).toList().length}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        textDirection: TextDirection.rtl,
                                      )),
                                      DataCell(CircleAvatar(
                                        backgroundColor: element.status
                                            ? Colors.green
                                            : Colors.red,
                                        radius: 5,
                                      )),
                                    ]);
                                  },
                                ).toList()),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            NewAccGroupSheet(),
            isScrollControlled: true,
          ).then((value) {
            accGroupController.newAccGroup.clear();
          });
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class NewAccGroupSheet extends StatelessWidget {
  final bool isEditing;
  NewAccGroupSheet({super.key, this.isEditing = false});
  final AccGroupController accGroupController = Get.find();
  final CustomerAccountController customerAccountController = Get.find();
  final AccGroupCurencyController accGroupCurencyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        // margin: const EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: MyColors.bg,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomSheetBackBtnWidget(),
              const SizedBox(height: 30),
              FaIcon(
                isEditing
                    ? FontAwesomeIcons.folderOpen
                    : FontAwesomeIcons.folderPlus,
                size: 40,
                color: MyColors.secondaryTextColor,
              ),
              const SizedBox(height: 7),
              Text(
                isEditing ? "تعد يل " : "اضافه ",
                style: myTextStyles.title1
                    .copyWith(color: MyColors.secondaryTextColor),
              ),
              const SizedBox(height: 20),

              // acc  state
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch.adaptive(
                      value: accGroupController
                              .newAccGroup[AccGroupField.status] ??
                          true,
                      onChanged: (newValue) {
                        accGroupController.newAccGroup.update(
                          AccGroupField.status,
                          (value) => newValue,
                          ifAbsent: () => newValue,
                        );
                        if (newValue == false) {
                          CustomDialog.customSnackBar(
                              changeStatusMessageAcc, SnackPosition.TOP);
                        }
                      }),
                  Text(
                    "الحالة ",
                    style: myTextStyles.subTitle,
                  )
                ],
              ),
              // name
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                textHint: "الاسم",
                placeHolder:
                    accGroupController.newAccGroup[AccGroupField.name] ?? '',
                action: (p0) {
                  accGroupController.newAccGroup.update(
                    AccGroupField.name,
                    (value) => p0,
                    ifAbsent: () => p0,
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: CustomBtnWidget(
                      color: MyColors.secondaryTextColor,
                      label: "الغاء",
                      action: () {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                      child: CustomBtnWidget(
                          color: MyColors.primaryColor,
                          label: isEditing ? "تعد يل" : "اضافة",
                          action: () async {
                            try {
                              if (accGroupController
                                      .newAccGroup[AccGroupField.name] !=
                                  null) {
                                var accgroup = AccGroup(
                                  id: isEditing
                                      ? accGroupController
                                          .newAccGroup[AccGroupField.id]
                                      : null,
                                  name: accGroupController
                                      .newAccGroup[AccGroupField.name]
                                      .toString()
                                      .trim(),
                                  status: accGroupController
                                          .newAccGroup[AccGroupField.status] ??
                                      true,
                                  createdAt: isEditing
                                      ? DateTime.parse(accGroupController
                                          .newAccGroup[AccGroupField.createdAt])
                                      : DateTime.now(),
                                  modifiedAt: DateTime.now(),
                                );

                                if (accgroup.name.isEmpty) {
                                  CustomDialog.customSnackBar(
                                      "ادخل كل القيم بطريقة صحيحة",
                                      SnackPosition.TOP);

                                  return;
                                }
                                isEditing
                                    ? await accGroupController
                                        .updateAccGroup(accgroup)
                                    : await accGroupController
                                        .createAccGroup(accgroup);
                                await accGroupCurencyController
                                    .getAllAccGroupAndCurency();
                                await accGroupController.readAllAccGroup();
                              } else {
                                CustomDialog.customSnackBar(
                                    "ادخل كل القيم بطريقة صحيحة",
                                    SnackPosition.TOP);

                                return;
                              }
                            } catch (e) {
                              // print("some error : $e");
                            }
                          }))
                ],
              ),
              const SizedBox(height: 20),
              //CustomBtnWidget(color: Colors.red, label: "حذف التصنيف"),
              if (isEditing && isHasAAccountsOnIt())
                CustomDeleteBtnWidget(
                  lable: "حذف ",
                  action: () {
                    CustomDialog.showDialog(
                        title: "حذف التصنيف",
                        description: "هل انت متاكد من حذف هذا التصنيف",
                        color: Colors.red,
                        icon: FontAwesomeIcons.trashCan,
                        action: () {
                          accGroupController.deleteAccGroup(
                              accGroupController.newAccGroup[AccGroupField.id]);
                          Get.back();
                          Get.back();
                        });
                  },
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  bool isHasAAccountsOnIt() {
    var accGoup = customerAccountController.allCustomerAccounts
        .firstWhereOrNull((element) =>
            element.accgroupId ==
            accGroupController.newAccGroup[AccGroupField.id]);
    return accGoup == null;
  }
}

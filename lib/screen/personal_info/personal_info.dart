import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/image_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/models/personal_model.dart';
import 'package:account_app/screen/personal_info/personal_text_field_widget.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});
  final PersonalController personalController = Get.find();
  final ImageController imageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => personalController.newPersonal['name'] == null
          ? Scaffold(
              body: EditPersonalInfoSheet(
              isFirstTime: true,
            ))
          : Scaffold(
              body: SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    CustomBackBtnWidget(title: "المعلومات الشخصيه"),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.bg,
                          boxShadow: [myShadow.blackShadow]),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  imageController.customImage['image'] == null
                                      ? imageController.createImage()
                                      : imageController.updateImage();
                                },
                                child: Obx(
                                  () => Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: imageController
                                                    .customImage['image'] ==
                                                null
                                            ? null
                                            : MemoryImage(imageController
                                                .customImage['image']),
                                        backgroundColor:
                                            MyColors.lessBlackColor,
                                        child: imageController
                                                    .customImage['image'] !=
                                                null
                                            ? const SizedBox()
                                            : const FaIcon(
                                                FontAwesomeIcons.user,
                                                color: Colors.white,
                                              ),
                                      ),
                                      if (imageController
                                              .customImage['image'] !=
                                          null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: MyColors.shadowColor)),
                                          child: Text(
                                            "تعد يل صوره",
                                            style: myTextStyles.body
                                                .copyWith(fontSize: 8),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                personalController.newPersonal['name'],
                                style: myTextStyles.title2,
                              ),
                              const SizedBox(width: 10),
                              const FaIcon(
                                FontAwesomeIcons.user,
                                size: 20,
                                color: MyColors.lessBlackColor,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                personalController.newPersonal['email'],
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const FaIcon(
                                FontAwesomeIcons.envelope,
                                size: 15,
                                color: MyColors.secondaryTextColor,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                personalController.newPersonal['phone'].length <
                                        2
                                    ? "لايوجد"
                                    : personalController.newPersonal['phone'],
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.phone_outlined,
                                size: 17,
                                color: MyColors.secondaryTextColor,
                              ),
                              // const FaIcon(
                              //   FontAwesomeIcons.phoneFlip,
                              //   size: 15,
                              //   color: MyColors.secondaryTextColor,
                              // )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    EditPersonalInfoSheet(
                                      isFirstTime: false,
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 17,
                                  color: Colors.green,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                personalController
                                            .newPersonal['address'].length <
                                        2
                                    ? "لايوجد"
                                    : personalController.newPersonal['address'],
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.location_pin,
                                size: 18,
                                color: MyColors.secondaryTextColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ),
    );
  }
}

class EditPersonalInfoSheet extends StatelessWidget {
  EditPersonalInfoSheet({super.key, required this.isFirstTime});
  final PersonalController personalController = Get.find();
  final isFirstTime;
  final ImageController imageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: isFirstTime ? false : true,
      bottom: false,
      child: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(top: Get.width / 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: personalController.newPersonal['name'] == null
                ? Colors.transparent
                : MyColors.bg,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (personalController.newPersonal['name'] == null)
                  SafeArea(
                    child: CustomBackBtnWidget(title: "الإعدادات الشخصية"),
                  ),
                if (personalController.newPersonal['name'] != null)
                  const CustomSheetBackBtnWidget(),
                const SizedBox(height: 30),
                Obx(
                  () => Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (imageController.customImage['image'] == null) {
                            imageController.createImage();
                          } else {
                            imageController.updateImage();
                          }
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              imageController.customImage['image'] == null
                                  ? null
                                  : MemoryImage(
                                      imageController.customImage['image']),
                          backgroundColor: MyColors.lessBlackColor,
                          child: imageController.customImage['image'] != null
                              ? SizedBox()
                              : FaIcon(
                                  FontAwesomeIcons.user,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      Positioned(
                          child: CircleAvatar(
                        radius: 12,
                        backgroundColor: MyColors.primaryColor,
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: MyColors.bg,
                          size: 15,
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                PersonalTextFieldWidget(
                  textHint: "الاسم",
                  icon: FontAwesomeIcons.user,
                  placeHolder: personalController.newPersonal['name'] ?? "",
                  action: (p0) {
                    personalController.newPersonal.update(
                      'newName',
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                ),
                const SizedBox(height: 10),
                PersonalTextFieldWidget(
                  textHint: "البريد ألإلكتروني",
                  icon: FontAwesomeIcons.envelope,
                  placeHolder: personalController.newPersonal['email'] ?? "",
                  action: (p0) {
                    personalController.newPersonal.update(
                      'email',
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                ),
                const SizedBox(height: 10),
                PersonalTextFieldWidget(
                  textHint: "الرقم",
                  icon: FontAwesomeIcons.phone,
                  placeHolder: personalController.newPersonal['phone'] ?? "",
                  action: (p0) {
                    personalController.newPersonal.update(
                      'phone',
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                PersonalTextFieldWidget(
                  textHint: "العنوان",
                  icon: FontAwesomeIcons.locationPin,
                  placeHolder: personalController.newPersonal['address'] ?? "",
                  action: (p0) {
                    personalController.newPersonal.update(
                      'address',
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                        child: CustomBtnWidget(
                      color: MyColors.secondaryTextColor,
                      label: "الغاء",
                      action: () {
                        if (isFirstTime) {
                          personalController.newPersonal.clear();
                        }

                        Get.back();
                      },
                    )),
                    const SizedBox(width: 10),
                    Flexible(
                        child: CustomBtnWidget(
                      color: MyColors.primaryColor,
                      label: isFirstTime ? 'إضافة' : 'تعد يل',
                      action: () {
                        if (personalController.newPersonal['newName'] == null ||
                            personalController.newPersonal['email'] == null) {
                          CustomDialog.customSnackBar(
                              "ادخل كل القيم بطريقة صحيحة", SnackPosition.TOP);
                          return;
                        }
                        if (personalController.newPersonal['newName'].length <
                                1 ||
                            personalController.newPersonal['email'].length <
                                1) {
                          CustomDialog.customSnackBar(
                              "ادخل كل القيم بطريقة صحيحة", SnackPosition.TOP);
                          return;
                        }
                        var newPersonalInfo = PersonalModel(
                            id: 1,
                            name:
                                personalController.newPersonal['newName'] ?? "",
                            email:
                                personalController.newPersonal['email'] ?? "",
                            address:
                                personalController.newPersonal['address'] ?? "",
                            phone:
                                personalController.newPersonal['phone'] ?? "");

                        isFirstTime
                            ? personalController.createPersona(newPersonalInfo)
                            : personalController
                                .updatePersonal(newPersonalInfo);
                        personalController.getPersonal();
                      },
                    ))
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/sitting_controller.dart';
import 'package:account_app/screen/copy_screen/all_google_drive_file.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class GoogleDriveCopyWidget extends StatefulWidget {
  const GoogleDriveCopyWidget({super.key});

  @override
  State<GoogleDriveCopyWidget> createState() => _GoogleDriveCopyWidgetState();
}

class _GoogleDriveCopyWidgetState extends State<GoogleDriveCopyWidget> {
  @override
  void initState() {
    super.initState();
  }

  String getCopyEveryString(int i) {
    switch (i) {
      case 0:
        return "يوم";
      case 1:
        return "يومين";
      case 2:
        return "أسبوع";

      default:
        return "شهر";
    }
  }

  SittingController sittingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        //  padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
        ),
        child: GetBuilder<CopyController>(builder: (contorller) {
          if (contorller.googleUser == null) {
            contorller.signIn();
          }
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
                child: Column(
                  children: [
                    const FaIcon(FontAwesomeIcons.googleDrive),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "النسخ الإ حتياطي الى جوجل درايف",
                      style: MyTextStyles.subTitle,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.background,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch.adaptive(
                        value: contorller.googleUser != null,
                        inactiveTrackColor: contorller.googleUser == null
                            ? Colors.red
                            : Colors.green,
                        onChanged: (value) {
                          value ? contorller.signIn() : contorller.signOut();
                        }),
                    Text(
                      "تفعيل النسخ الى جوجل درايف",
                      style: MyTextStyles.subTitle.copyWith(
                          color: contorller.googleUser == null
                              ? Colors.red
                              : Colors.green),
                    ),
                  ],
                ),
              ),
              if (contorller.googleUser != null)
                Column(
                  children: [
                    CustomCopyBtnWidget(
                      topIcon: FontAwesomeIcons.upload,
                      color: Colors.green,
                      icon: FontAwesomeIcons.upload,
                      label: "عمل نسخة جد يد ة",
                      action: () async {
                        await contorller.uploadCopy();
                      },
                      description:
                          "قم بعمل نسخة إحتياطية جديدة , لحفظ كل بياناتك في جوجل درايف وإستعادتها في وقت لاحق",
                    ),
                    CustomDriveCopyBtnWidget(
                      topIcon: FontAwesomeIcons.download,
                      color: const Color.fromARGB(197, 170, 18, 18),
                      icon: FontAwesomeIcons.download,
                      label: "فتح أخر نسخة ",
                      //  action: () {},
                      action: () {
                        CustomDialog.showDialog(
                            action: () {
                              //  copyController.openDatabaseFile();

                              contorller.getTheLastFile();
                              Get.back();
                            },
                            title: "إستعادة",
                            icon: FontAwesomeIcons.download,
                            color: Colors.red,
                            description:
                                " هل أنت متأكد من إستعادة هذه النسخة ");
                      },
                      description:
                          'عند استعادة اي نسخة سابقة سيتم حذف جميع البيانات الحالية , تأكد من عمل نسخة إحتياطية للبيانات الحالية',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Obx(
                            () => Switch.adaptive(
                                value: sittingController
                                    .toggleAsyncGoogleDrive.value,
                                inactiveTrackColor: sittingController
                                        .toggleAsyncGoogleDrive.value
                                    ? Colors.green
                                    : Colors.red,
                                onChanged: (value) async {
                                  if (value) {
                                    if (contorller.driveApi == null) {
                                      await contorller.signIn();
                                    }
                                    if (contorller.driveApi != null) {
                                      if (Get.isSnackbarOpen == false) {
                                        CustomDialog.customSnackBar(
                                            "سيتم رفع نسخة الي جوجل درايف كل ${getCopyEveryString(sittingController.every.value)}",
                                            SnackPosition.BOTTOM,
                                            false);
                                      }
                                    }
                                  }
                                  if (contorller.driveApi != null &&
                                      value == true) {
                                    await sittingController
                                        .toogleIsCopyOn(value);
                                  } else {
                                    await sittingController
                                        .toogleIsCopyOn(value);
                                  }
                                }),
                          ),
                          const Spacer(),
                          Text(
                            "المزامنة مع جوجل درايف",
                            style: MyTextStyles.subTitle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.circular(10),
                              color: MyColors.lessBlackColor.withOpacity(0.8),
                            ),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.googleDrive,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Column(
                          children: [
                            if (sittingController.toggleAsyncGoogleDrive.value)
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 30, left: 40, top: 10),
                                child: Text(
                                  "سيقوم البرنامج بعمل نسخة إحتياطية كل يوم الساعة 12 منتصف الليل",
                                  textAlign: TextAlign.right,
                                  style: MyTextStyles.body,
                                ),
                              ),
                            // if (sittingController.toggleAsyncGoogleDrive.value)
                            //   Container(
                            //     margin: EdgeInsets.symmetric(horizontal: 15),
                            //     child: GoogleDriveAveryList(),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.lessBlackColor.withOpacity(0.07),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    contorller.signOut();
                                    contorller.signIn();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.penToSquare,
                                    size: 17,
                                    color: contorller.googleUser == null
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                                Text(
                                  "الحساب المتصل بجوجل درايف",
                                  style: MyTextStyles.body.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              contorller.googleUser == null
                                  ? "لايوجد حساب"
                                  : contorller.googleUser?.email ?? "",
                              style: MyTextStyles.title2,
                            )
                          ]),
                    ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }));
  }
}

// class GoogleCopyApi {
//  static final _googleApi =  Google();

// }

class CustomDriveCopyBtnWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback action;
  final IconData topIcon;
  const CustomDriveCopyBtnWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.description,
      required this.action,
      required this.topIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color.withOpacity(0.08),
            ),
            child: FaIcon(
              topIcon,
              size: 20,
              color: MyColors.secondaryTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: MyTextStyles.body,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 17),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Get.to(() => const ShowAllFiles());
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: MyColors.lessBlackColor.withOpacity(0.8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                " كل النسخ",
                                style: MyTextStyles.subTitle.copyWith(
                                  color: MyColors.bg,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.filePen,
                                color: MyColors.bg,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          action();
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          //  margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: color,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                label,
                                style: MyTextStyles.subTitle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              FaIcon(
                                icon,
                                size: 15,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

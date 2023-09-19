// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/image_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/screen/copy_screen/google_copy_screen.dart';
import 'package:account_app/screen/copy_screen/local_copy_screen.dart';
import 'package:account_app/screen/personal_info/personal_info.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:account_app/screen/settings/curency_setting.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/no_personal_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/settings/customer_setting.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final PersonalController personalController = Get.find();
  final CopyController copyController = Get.find();
  final ImageController imageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.lessBlackColor,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyColors.lessBlackColor,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Expanded(
                              child: Text(
                            "الا عدادات",
                            textAlign: TextAlign.center,
                            style: MyTextStyles.title1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              // fontSize: 18,
                            ),
                          )),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              color: MyColors.lessBlackColor,
                              child: const FaIcon(
                                FontAwesomeIcons.arrowRightLong,
                                color: Colors.white54,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Get.to(() => PersonalInfoScreen()),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 12,
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.bg,
                        ),
                        child: Obx(
                          () => personalController.newPersonal['name'] == null
                              ? NoPersonalInfoWidget(
                                  isDrawer: false,
                                )
                              : Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 15,
                                      color: MyColors.secondaryTextColor,
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          personalController
                                              .newPersonal['name'],
                                          style: MyTextStyles.title1.copyWith(
                                            // color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          personalController
                                              .newPersonal['email'],
                                          style: MyTextStyles.title1.copyWith(
                                            //  color: Colors.white54,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: imageController
                                                      .customImage['image'] ==
                                                  null
                                              ? null
                                              : MemoryImage(imageController
                                                  .customImage['image']),
                                          backgroundColor:
                                              MyColors.lessBlackColor,
                                          child: imageController
                                                      .customImage['image'] ==
                                                  null
                                              ? const FaIcon(
                                                  FontAwesomeIcons.user,
                                                  color:
                                                      MyColors.containerColor,
                                                )
                                              : const SizedBox(),
                                        ),
                                        Positioned(
                                          bottom: -2.5,
                                          right: -2.5,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.plus,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                    //const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: MyColors.bg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        SettingItemWidget(
                          onPress: () => Get.to(() => CustomerSettingScreen()),
                          icon: FontAwesomeIcons.users,
                          title: "كل العملاء",
                        ),
                        SettingItemWidget(
                          onPress: () => Get.to(() => CurencySettingScreen()),
                          icon: FontAwesomeIcons.dollarSign,
                          title: "العملات",
                        ),
                        SettingItemWidget(
                          onPress: () => Get.to(() => AccGroupSettingScreen()),
                          icon: FontAwesomeIcons.fileCirclePlus,
                          title: " التصنيفات",
                        ),
                        SettingItemWidget(
                          onPress: () => Get.to(() => const LocalCopyScreen()),
                          icon: FontAwesomeIcons.solidFolderClosed,
                          title: "النسخ الإحتياطي",
                        ),
                        SettingItemWidget(
                            onPress: () =>
                                Get.to(() => const GoogleCopyScreen()),
                            title: "النسخ الإحتياطي الى جوجل درايف",
                            icon: FontAwesomeIcons.googleDrive),
                        const SizedBox(height: 30),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                SystemNavigator.pop();
                              },
                              child: Container(
                                width: Get.width - 150,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: MyColors.containerColor,
                                ),
                                child: Text(
                                  "خروج ",
                                  style: MyTextStyles.subTitle,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 20),
                              child: const FaIcon(
                                FontAwesomeIcons.question,
                                size: 20,
                                color: MyColors.secondaryTextColor,
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     CustomDialog.loadingProgress();
                        //     await deleteDatabase(
                        //         await DatabaseService().fullPath);
                        //     await copyController.restoreSucess();
                        //     Get.back();

                        //     Get.offAll(() => MyEntroScreen());
                        //   },
                        //   child: Container(
                        //     width: Get.width - 100,
                        //     alignment: Alignment.center,
                        //     padding: const EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(18),
                        //       color: Color.fromARGB(255, 252, 203, 203),
                        //     ),
                        //     child: Text(
                        //       "خروج ومسح كل البيانات ",
                        //       style: myTextStyles.subTitle.copyWith(
                        //         color: Color.fromARGB(255, 146, 44, 36),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class GoogleDriveSyncWidget extends StatelessWidget {
//   GoogleDriveSyncWidget({
//     super.key,
//   });
//   SittingController sittingController = Get.find();
//   CopyController copyController = Get.find();

//   String getCopyEveryString(int i) {
//     switch (i) {
//       case 0:
//         return "يوم";
//       case 1:
//         return "يومين";
//       case 2:
//         return "أسبوع";

//       default:
//         return "شهر";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.only(top: 5.0),
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: MyColors.containerColor.withOpacity(0.3),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Switch.adaptive(
//                     value: sittingController.toggleAsyncGoogleDrive.value,
//                     onChanged: (value) async {
//                       if (value) {
//                         if (copyController.driveApi == null) {
//                           await copyController.signIn();
//                         }
//                         if (copyController.driveApi != null) {
//                           if (Get.isSnackbarOpen == false) {
//                             CustomDialog.customSnackBar(
//                                 "سيتم رفع نسخة الي جوجل درايف كل ${getCopyEveryString(sittingController.every.value)}",
//                                 SnackPosition.BOTTOM);
//                           }
//                         }
//                       }
//                       if (copyController.driveApi != null && value == true) {
//                         await sittingController.toogleIsCopyOn(value);
//                       } else {
//                         await sittingController.toogleIsCopyOn(value);
//                       }
//                     }),
//                 const Spacer(),
//                 Text(
//                   "المزامنة مع جوجل درايف",
//                   style: myTextStyles.subTitle,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   width: 35,
//                   height: 35,
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     //borderRadius: BorderRadius.circular(10),
//                     color: MyColors.lessBlackColor.withOpacity(0.8),
//                   ),
//                   child: const Center(
//                     child: FaIcon(
//                       FontAwesomeIcons.googleDrive,
//                       size: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (sittingController.toggleAsyncGoogleDrive.value)
//               Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: MyColors.bg,
//                           ),
//                           child: Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () async {
//                                   //  await sittingController.increemint();

//                                   CustomDialog.customSnackBar(
//                                       "سيتم رفع نسخة الي جوجل درايف كل ${getCopyEveryString(sittingController.every.value)}",
//                                       SnackPosition.BOTTOM);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: MyColors.lessBlackColor
//                                         .withOpacity(0.8),
//                                   ),
//                                   child: const FaIcon(
//                                     FontAwesomeIcons.plus,
//                                     size: 15,
//                                     color: MyColors.containerColor,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 5),
//                                 child: FittedBox(
//                                   child: Text(
//                                     getCopyEveryString(
//                                         sittingController.every.value),
//                                     style: myTextStyles.title2.copyWith(
//                                       color: MyColors.lessBlackColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//                                   // decreming
//                                   //  await sittingController.decreemint();
//                                   CustomDialog.customSnackBar(
//                                       "سيتم رفع نسخة الي جوجل درايف كل ${getCopyEveryString(sittingController.every.value)}",
//                                       SnackPosition.BOTTOM);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: MyColors.lessBlackColor
//                                         .withOpacity(0.8),
//                                   ),
//                                   child: const FaIcon(
//                                     FontAwesomeIcons.minus,
//                                     size: 15,
//                                     color: MyColors.containerColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         Text(
//                           "عمل نسخة كل",
//                           style: myTextStyles.title2.copyWith(
//                             //fontSize: 13,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }

class SettingItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPress;
  const SettingItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPress != null) {
          onPress!();
        }
      },
      child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyColors.containerColor.withOpacity(0.3),
          ),
          child: Row(children: [
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.all(5),
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 15,
                color: Colors.black45,
              ),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.right,
              style: MyTextStyles.title2.copyWith(
                //fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(10),
                color: MyColors.lessBlackColor.withOpacity(0.8),
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ])),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/detail_controller.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:get/get.dart';

class NewRecordScreen extends StatefulWidget {
  final HomeModel homeModel;
  const NewRecordScreen({super.key, required this.homeModel});

  @override
  State<NewRecordScreen> createState() => _NewRecordScreenState();
}

class _NewRecordScreenState extends State<NewRecordScreen> {
  DateTime _selectedDate = DateTime.now();

  Future _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  CurencyController curencyController = Get.find();
  NewAccountController newAccountController = Get.find();
  DetailController detailController = Get.find();
  List<dynamic> details = [];
  TextEditingController detailsTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newAccountController.newAccount.clear();
  }

  @override
  Widget build(BuildContext context) {
    CEC.errorMessage.value = "";
    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(10),
        constraints: const BoxConstraints(
          minHeight: 300,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyColors.bg,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Obx(
              () => Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (CEC.errorMessage.isNotEmpty) const ErrorShowWidget(),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            details = [];
                          });
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.lessBlackColor.withOpacity(0.9),
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    // color: MyColors.containerColor.withOpacity(0.5),
                                  ),
                                  child: Text(
                                    curencyController.allCurency
                                        .firstWhere((element) =>
                                            element.id ==
                                            widget.homeModel.curId)
                                        .name,
                                    style: myTextStyles.body
                                        .copyWith(color: MyColors.bg),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  widget.homeModel.name,
                                  textAlign: TextAlign.right,
                                  style: myTextStyles.subTitle
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColors.containerSecondColor,
                                ),
                                child: const Center(
                                    child: FaIcon(
                                  FontAwesomeIcons.calendarCheck,
                                  color: MyColors.secondaryTextColor,
                                  size: 22,
                                ))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomNumberFieldWidget(
                            textHint: "المبلغ",
                            onTap: () {
                              setState(() {
                                details = [];
                              });
                            },
                            action: (p0) {
                              newAccountController.newAccount.update(
                                'money',
                                (value) => p0,
                                ifAbsent: () => p0,
                              );
                            },
                          )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: DetailTextFieldWidget(
                            key: const Key("newRecord"),
                            textHint: "التفاصل",
                            controller: detailsTextController,
                            action: (p0) {
                              newAccountController.newAccount.update(
                                'desc',
                                (value) => detailsTextController.text.trim(),
                                ifAbsent: () =>
                                    detailsTextController.text.trim(),
                              );
                              if (p0.isNotEmpty) {
                                setState(() {
                                  details = detailController.allDetails
                                      .where((e) => e['body']
                                          .toString()
                                          .contains(p0.toString().trim()))
                                      .toList();
                                });
                              } else {
                                setState(() {
                                  details = [];
                                });
                              }
                            },
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Flexible(
                              child: CustomBtnWidget(
                            color: MyColors.debetColor,
                            label: "له",
                            action: () {
                              addNewRecordFunction(true);
                            },
                          )),
                          const SizedBox(width: 10),
                          Flexible(
                              child: CustomBtnWidget(
                            color: MyColors.creditColor,
                            label: "عليه",
                            action: () {
                              addNewRecordFunction(false);
                            },
                          ))
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  if (details.isNotEmpty)
                    Positioned(
                      top: 180,
                      right: 0,
                      left: 0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  MyColors.secondaryTextColor.withOpacity(0.5),
                            ),
                            child: ListView.builder(
                              itemCount: details.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return DetailListItemWidet(
                                  body: details[index]['body'],
                                  action: () {
                                    newAccountController.newAccount.update(
                                      'desc',
                                      (value) => details[index]['body'],
                                      ifAbsent: () => details[index]['body'],
                                    );
                                    setState(() {
                                      detailsTextController.text =
                                          details[index]['body'];

                                      details = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          Positioned(
                              left: -5,
                              top: -5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    details = [];
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [myShadow.blackShadow]),
                                  child: const FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 13,
                                    color: Colors.red,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addNewRecordFunction(bool credit) async {
    newAccountController.newAccount['desc'] = detailsTextController.text.trim();

    if (newAccountController.newAccount['money'] == null ||
        newAccountController.newAccount['desc'] == null) {
      CEC.errorMessage.value = "no data to puplished";
      print(newAccountController.newAccount['desc']);
      return;
    }
    if (newAccountController.newAccount['desc'].length < 2 ||
        newAccountController.newAccount['money'].length < 1) {
      CEC.errorMessage.value = "";
      CEC.errorMessage.value = "inter the value in valid way";
      return;
    }

    newAccountController.newAccount.update(
      "date",
      (value) => _selectedDate,
      ifAbsent: () => _selectedDate,
    );
    try {
      if (credit) {
        newAccountController.newAccount.update(
          'credit',
          (value) => double.parse(newAccountController.newAccount['money']),
          ifAbsent: () =>
              double.parse(newAccountController.newAccount['money']),
        );
        newAccountController.newAccount.update(
          'debit',
          (value) => 0.0,
          ifAbsent: () => 0.0,
        );
      } else {
        newAccountController.newAccount.update(
          'debit',
          (value) => double.parse(newAccountController.newAccount['money']),
          ifAbsent: () =>
              double.parse(newAccountController.newAccount['money']),
        );
        newAccountController.newAccount.update(
          'credit',
          (value) => 0.0,
          ifAbsent: () => 0.0,
        );
      }
    } catch (e) {
      CEC.errorMessage.value = "the money is not crected";
      return;
    }
    newAccountController.addNewRecordToCustomerAccount(widget.homeModel);
  }
}

// class NewCustomerSheet extends StatelessWidget {
//   const NewCustomerSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: MyColors.bg,
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 10,
//           ),
//           child: Column(
//             children: [
//               //   const CustomBackBtnWidget(),
//               const SizedBox(height: 30),
//               Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     //  const FaIcon(
//                     //   FontAwesomeIcons.user,
//                     //   size: 50,
//                     //   color: MyColors.secondaryTextColor,
//                     // ),
//                     // Text(
//                     //   "اضافه عميل",
//                     //   style: myTextStyles.title1,
//                     // ),
//                     const SizedBox(height: 20),
//                     CustomTextFieldWidget(
//                       textHint: "العنوان",
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextFieldWidget(
//                       textHint: "الهاتف",
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Flexible(
//                           child: CustomBtnWidget(
//                             color: MyColors.secondaryTextColor,
//                             label: "الغاء",
//                             action: () {},
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Flexible(
//                           child: CustomBtnWidget(
//                             color: Colors.green,
//                             label: "اضافه",
//                             action: () {},
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

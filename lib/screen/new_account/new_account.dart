// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables

import 'package:account_app/constant/notification.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/sizes.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/detail_controller.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/screen/new_account/select_contact_widget.dart';
import 'package:account_app/widget/curency_show_widget.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_calculator/flutter_awesome_calculator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_formater;
// import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen(
      {super.key, required this.accGroupId, required this.curencyId});
  final accGroupId;
  final curencyId;

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  DateTime _selectedDate = DateTime.now();
  List<Customer> customers = [];
  List<dynamic> details = [];
  Customer? selectionCustomer;
  @override
  void initState() {
    super.initState();
    newAccountController.newAccount.clear();
  }

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

  _showBottomSheet() {
    Get.bottomSheet(
      mySheet,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  bool isFindedIt = false;

  NewAccountController newAccountController = Get.find();
  NewCustomerSheet mySheet = Get.put(NewCustomerSheet());
  CustomerController customerController = Get.find();
  HomeController homeController = Get.find();
  DetailController detailController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  CurencyController curencyController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsTextController = TextEditingController();
  TextEditingController moneyTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CEC.errorMessage.value = "";
    return SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () {
            setState(() {
              details = [];
              customers = [];
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: MyColors.bg,
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Obx(
                  () => Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (CEC.errorMessage.isNotEmpty)
                            const ErrorShowWidget(),
                          if (isFindedIt) const CorrectShowWidget(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                  width: Get.width / 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: MyColors.containerSecondColor,
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.bottomSheet(Container(
                                              padding: const EdgeInsets.only(
                                                top: 20,
                                                bottom: 20,
                                              ),
                                              margin: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 30,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: FlutterAwesomeCalculator(
                                                clearButtonColor: Colors.white,
                                                operatorsButtonColor:
                                                    MyColors.bg,
                                                buttonRadius: 15,
                                                context: context,
                                                showAnswerField: true,
                                                digitsButtonColor: Colors.white,
                                                backgroundColor: Colors.white,
                                                expressionAnswerColor:
                                                    Colors.black,
                                                onChanged:
                                                    (answer, expression) {
                                                  setState(
                                                    () {
                                                      moneyTextController.text =
                                                          answer;
                                                      newAccountController
                                                          .newAccount
                                                          .update(
                                                        'money',
                                                        (value) => answer,
                                                        ifAbsent: () => answer,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              // border: Border.all(
                                              //   color: MyColors
                                              //       .secondaryTextColor
                                              //       .withOpacity(0.5),
                                              // ),
                                            ),
                                            width: textFieldSize - 20,
                                            height: textFieldSize - 20,
                                            child: const Center(
                                              child: Icon(
                                                Icons.calculate_outlined,
                                                size: 22,
                                                color:
                                                    MyColors.secondaryTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomCurencyFieldWidget(
                                            controller: moneyTextController,
                                            textHint: "المبلغ",
                                            onTap: () {
                                              setState(() {
                                                customers.clear();

                                                details = [];
                                              });
                                            },
                                            action: (p0) {
                                              newAccountController.newAccount
                                                  .update(
                                                'money',
                                                (value) => p0,
                                                ifAbsent: () => p0,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Container(
                                height: textFieldSize,
                                alignment: Alignment.center,
                                //padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: MyColors.containerSecondColor,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: nameController,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: MyTextStyles.subTitle.copyWith(
                                            color: MyColors.blackColor,
                                            fontWeight: FontWeight.bold),
                                        onTap: () {
                                          setState(() {
                                            details = [];
                                          });
                                        },
                                        onChanged: (p0) {
                                          selectionCustomer = null;
                                          CEC.errorMessage.value = "";
                                          newAccountController.newAccount
                                              .update(
                                            'name',
                                            (value) => p0,
                                            ifAbsent: () => p0,
                                          );
                                          if (p0.isNotEmpty) {
                                            setState(() {
                                              customers = customerController
                                                  .allCustomers
                                                  .where((element) =>
                                                      element.name.contains(
                                                          p0.toString().trim()))
                                                  .toList();
                                            });
                                          } else {
                                            setState(() {
                                              customers.clear();
                                              details = [];
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "الاسم",
                                          hintStyle: MyTextStyles.body.copyWith(
                                            fontWeight: FontWeight.normal,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SelectContactWidget(
                                      action: (contactName, contactNumber) {
                                        nameController.text = contactName;
                                        newAccountController.newAccount.update(
                                          'phone',
                                          (value) => contactName,
                                          ifAbsent: () => contactNumber,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: Container(
                                      height: textFieldSize,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyColors.containerSecondColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              date_formater.DateFormat.yMd()
                                                  .format(_selectedDate),
                                              style: const TextStyle(
                                                color: MyColors.blackColor,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const FaIcon(
                                            FontAwesomeIcons.calendarCheck,
                                            color: MyColors.secondaryTextColor,
                                            size: 22,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                  flex: 2,
                                  child: DetailTextFieldWidget(
                                    key: const Key("newAccount"),
                                    textHint: "التفاصل",
                                    controller: detailsTextController,
                                    action: (p0) {
                                      newAccountController.newAccount.update(
                                        'desc',
                                        (value) => p0,
                                        ifAbsent: () => p0,
                                      );

                                      if (p0.isNotEmpty) {
                                        setState(() {
                                          details = detailController.allDetails
                                              .where((e) => e['body']
                                                  .toString()
                                                  .contains(
                                                      p0.toString().trim()))
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
                          CurencyShowWidget(),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Flexible(
                                child: CustomBtnWidget(
                                  color: MyColors.debetColor,
                                  label: "له",
                                  action: () {
                                    createCustomerAccount(true);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                  child: CustomBtnWidget(
                                color: MyColors.creditColor,
                                label: "عليه",
                                action: () {
                                  createCustomerAccount(false);
                                },
                              ))
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      if (customers.isNotEmpty)
                        Positioned(
                          top: CEC.errorMessage.value == "" ? 67 : 120,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.only(top: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  MyColors.secondaryTextColor.withOpacity(0.5),
                            ),
                            child: ListView.builder(
                              itemCount: customers.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ExitCustomerItemWidget(
                                  customer: customers[index],
                                  action: () {
                                    setState(() {
                                      selectionCustomer = customers[index];
                                      nameController.text =
                                          customers[index].name;
                                      customers.clear();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      if (details.isNotEmpty)
                        Positioned(
                          top: CEC.errorMessage.value == "" ? 125 : 183,
                          right: 0,
                          left: 0,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                // height: Get.height / 6.4,
                                constraints: BoxConstraints(
                                  minHeight: 40,
                                  maxHeight: Get.height / 6.4,
                                ),
                                padding: const EdgeInsets.only(top: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: MyColors.secondaryTextColor
                                      .withOpacity(0.5),
                                ),
                                child: ListView.builder(
                                  itemCount: details.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DetailListItemWidet(
                                      body: details[index]['body'].toString(),
                                      action: () {
                                        setState(() {
                                          detailsTextController.text =
                                              details[index]['body'].toString();
                                          newAccountController.newAccount
                                              .update(
                                            'desc',
                                            (value) => details[index]['body']
                                                .toString(),
                                            ifAbsent: () => details[index]
                                                    ['body']
                                                .toString(),
                                          );

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
                                          boxShadow: [MyShadow.blackShadow]),
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
        ));
  }
  /*


Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: customers
                          .map((e) => ExitCustomerItemWidget(
                                customer: e,
                                action: () {
                                  setState(() {
                                    selectionCustomer = e;
                                    nameController.text = e.name;
                                    customers.clear();
                                  });
                                },
                              ))
                          .toList(),
                    ),
  */

  void createCustomerAccount(bool credit) async {
    newAccountController.newAccount['money'] =
        newAccountController.newAccount['money'].toString().replaceAll(",", "");
    if (nameController.text.isEmpty) {
      CEC.errorMessage.value = "قم يملئ حقل الاسم بطريقة صحيحة";
      return;
    }
    if (selectionCustomer != null) {
      newAccountController.newAccount.update(
        "name",
        (value) => selectionCustomer?.name,
        ifAbsent: () => selectionCustomer?.name,
      );
    } else {
      newAccountController.newAccount.update(
        "name",
        (value) => nameController.text.trim(),
        ifAbsent: () => nameController.text.trim(),
      );
    }
    if (newAccountController.newAccount['name'] == null ||
        newAccountController.newAccount['money'] == null ||
        newAccountController.newAccount['desc'] == null) {
      CEC.errorMessage.value = interAllValues;
      return;
    }
    if (newAccountController.newAccount['money'].length < 1 ||
        newAccountController.newAccount['desc'].length < 2) {
      CEC.errorMessage.value = interValidText;
      return;
    }

    if (curencyController.allCurency
            .firstWhereOrNull((element) =>
                element.id == curencyController.selectedCurency['crId'])
            ?.status ==
        false) {
      CustomDialog.customSnackBar(
          "لم تقم بتحديد العمله", SnackPosition.BOTTOM, true);
      return;
    }

    newAccountController.newAccount.update(
      "date",
      (value) => _selectedDate,
      ifAbsent: () => _selectedDate,
    );
    newAccountController.newAccount.update(
      "accGroupId",
      (value) => widget.accGroupId,
      ifAbsent: () => widget.accGroupId,
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
      CEC.errorMessage.value = "قم بإدخال المبلغ بشكل صحيح";
      return;
    }

    var findCustomer = customerController.allCustomers.firstWhereOrNull(
      (element) =>
          element.name ==
          newAccountController.newAccount['name'].toString().trim(),
    );
    if (findCustomer != null) {
      newAccountController.newAccount.update(
        "customerId",
        (value) => findCustomer.id,
        ifAbsent: () => findCustomer.id,
      );

      newAccountController.createNewCustomerAccount();
    } else {
      if (findCustomer?.status == false) {
        CustomDialog.customSnackBar(
            " هذا الحساب موقف من الإعدادات", SnackPosition.BOTTOM, true);
        return;
      }
      _showBottomSheet();
    }
  }

  Future<CustomerAccount?> getCustomerAccountStatus(int customerId) async {
    var cac = customerAccountController.findCustomerAccountIfExist(
        cid: customerId,
        accg: newAccountController.newAccount['accGroupId'],
        curid: curencyController.selectedCurency['id']);
    return cac;
  }
}

class ExitCustomerItemWidget extends StatelessWidget {
  final Customer customer;
  final VoidCallback action;

  const ExitCustomerItemWidget(
      {super.key, required this.customer, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        height: 35,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(left: 3, bottom: 3, right: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.containerColor,
        ),
        child: Text(
          customer.name,
          textAlign: TextAlign.right,
          style: MyTextStyles.subTitle.copyWith(
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor,
          ),
        ),
      ),
    );
  }
}

class DetailListItemWidet extends StatelessWidget {
  final String body;
  final VoidCallback action;

  const DetailListItemWidet(
      {super.key, required this.body, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        height: 35,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(left: 3, bottom: 3, right: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.containerColor,
        ),
        child: FittedBox(
          child: Text(
            body.toString(),
            textAlign: TextAlign.right,
            style: MyTextStyles.subTitle.copyWith(
              fontWeight: FontWeight.bold,
              color: MyColors.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}

class NewCustomerSheet extends StatelessWidget {
  NewCustomerSheet({super.key});
  final NewAccountController newAccountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: MyColors.bg,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //   const CustomBackBtnWidget(),
              //const SizedBox(height: 30),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  const FaIcon(
                    //   FontAwesomeIcons.user,
                    //   size: 50,
                    //   color: MyColors.secondaryTextColor,
                    // ),
                    // Text(
                    //   "اضافه عميل",
                    //   style: myTextStyles.title1,
                    // ),
                    const SizedBox(height: 20),
                    CustomNumberFieldWidget(
                      placeHolder:
                          newAccountController.newAccount['phone'] ?? "",
                      textHint: "الهاتف",
                      action: (p0) {
                        newAccountController.newAccount.update(
                          'phone',
                          (value) => p0,
                          ifAbsent: () => p0,
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    CustomTextFieldWidget(
                      textHint: "العنوان",
                      action: (p0) {
                        newAccountController.newAccount.update(
                          'address',
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
                            color: Colors.green,
                            label: "اضافه",
                            action: () {
                              newAccountController.newAccount.update(
                                "new",
                                (value) => true,
                                ifAbsent: () => true,
                              );
                              newAccountController.createNewCustomerAccount();
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

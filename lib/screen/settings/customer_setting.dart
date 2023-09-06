import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/notification.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomerSettingScreen extends StatelessWidget {
  CustomerSettingScreen({super.key});
  CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 50),
            child: Column(
              children: [
                CustomBackBtnWidget(title: "العملاء"),
                const SizedBox(height: 20),
                if (customerController.allCustomers.isEmpty)
                  EmptyWidget(
                    imageName: 'assets/images/customer.png',
                    label: "قم بإضافة بعض العملاء",
                  ),
                Column(
                  children: customerController.allCustomers.map((element) {
                    return CustomerSettingItemWidget(
                      customer: element,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            NewCustomerSheet(),
            isScrollControlled: true,
          ).then((value) {
            customerController.newCustomer.clear();
          });
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class CustomerSettingItemWidget extends StatelessWidget {
  final Customer customer;
  CustomerAccountController customerAccountController = Get.find();
  CustomerSettingItemWidget({
    super.key,
    required this.customer,
  });
  CustomerController customerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
          boxShadow: [
            myShadow.blackShadow,
          ]),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: customer.status ? Colors.green : Colors.red,
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  customer.name,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: myTextStyles.title2,
                ),
              ),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.user,
                size: 20,
                color: MyColors.lessBlackColor,
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Spacer(),
              Text(
                customer.phone,
                style: myTextStyles.title2.copyWith(
                  color: MyColors.secondaryTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.phone,
                size: 15,
                color: MyColors.secondaryTextColor,
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => CustomDialog.showDialog(
                    title: "تعد يل",
                    description: "هل انت متاكد من تعد يل هذا الحساب",
                    color: Colors.green,
                    icon: FontAwesomeIcons.penToSquare,
                    action: () {
                      customerController.newCustomer
                          .addAll(customer.toEditMap());
                      Get.back();
                      Get.bottomSheet(
                        NewCustomerSheet(
                          isEditing: true,
                        ),
                        isScrollControlled: true,
                      ).then((value) {
                        customerController.newCustomer.clear();
                      });
                    }),
                child: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 17,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              if (isHasAAccountsOnIt())
                GestureDetector(
                  onTap: () => CustomDialog.showDialog(
                      title: "حذف",
                      description: "هل انت متاكد من حذف هذا الحساب",
                      color: Colors.red,
                      icon: FontAwesomeIcons.trashCan,
                      action: () {
                        customerController.deleteCustomer(customer.id ?? 0);
                        Get.back();
                      }),
                  child: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    size: 17,
                    color: Colors.red,
                  ),
                ),
              const Spacer(),
              Text(
                customer.address,
                style: myTextStyles.title2.copyWith(
                  color: MyColors.secondaryTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.locationPin,
                size: 15,
                color: MyColors.secondaryTextColor,
              )
            ],
          )
        ],
      ),
    );
  }

  bool isHasAAccountsOnIt() {
    var accGoup = customerAccountController.allCustomerAccounts
        .firstWhereOrNull((element) => element.customerId == customer.id);
    return accGoup == null;
  }
}

class NewCustomerSheet extends StatelessWidget {
  final bool isEditing;
  NewCustomerSheet({super.key, this.isEditing = false});
  CustomerController customerController = Get.find();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyColors.bg,
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const FaIcon(
              FontAwesomeIcons.user,
              size: 40,
              color: MyColors.secondaryTextColor,
            ),
            const SizedBox(height: 7),
            Text(
              isEditing ? "تعد يل" : "اضافة عميل",
              style: myTextStyles.title1
                  .copyWith(color: MyColors.secondaryTextColor),
            ),
            const SizedBox(height: 20),

            // customer state
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch.adaptive(
                    value:
                        customerController.newCustomer[CustomerField.status] ??
                            true,
                    onChanged: (newValue) {
                      customerController.newCustomer.update(
                        CustomerField.status,
                        (value) => newValue,
                        ifAbsent: () => newValue,
                      );
                      if (newValue == false) {
                        CustomDialog.customSnackBar(
                          changeStatusMessageCustomer,
                          SnackPosition.TOP,
                        );
                      }
                    }),
                Text(
                  "حالة العميل",
                  style: myTextStyles.subTitle,
                )
              ],
            ),
            const SizedBox(height: 10),
            // customer name
            Row(
              children: [
                Flexible(
                    child: CustomTextFieldWidget(
                  textHint: "الرقم",
                  placeHolder:
                      customerController.newCustomer[CustomerField.phone] ?? '',
                  action: (p0) {
                    customerController.newCustomer.update(
                      CustomerField.phone,
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                )),
                const SizedBox(width: 10),
                Flexible(
                    child: CustomTextFieldWidget(
                  textHint: "الاسم",
                  placeHolder:
                      customerController.newCustomer[CustomerField.name] ?? '',
                  action: (p0) {
                    customerController.newCustomer.update(
                      CustomerField.name,
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                ))
              ],
            ),
            const SizedBox(height: 10),
            CustomTextFieldWidget(
              textHint: "العنوان",
              placeHolder:
                  customerController.newCustomer[CustomerField.address] ?? "",
              action: (p0) {
                customerController.newCustomer.update(
                  CustomerField.address,
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
                      if (customerController.newCustomer[CustomerField.name] !=
                          null) {
                        if (customerController
                                .newCustomer[CustomerField.name].length <
                            2) {
                          CustomDialog.customSnackBar(
                              "ادخل كل القيم بطريقة صحيحة", SnackPosition.TOP);

                          return;
                        }
                        var customer = Customer(
                            id: isEditing
                                ? customerController
                                    .newCustomer[CustomerField.id]
                                : null,
                            name: customerController.newCustomer[CustomerField.name]
                                .toString()
                                .trim(),
                            phone: customerController
                                    .newCustomer[CustomerField.phone] ??
                                'لا يوجد رقم',
                            address: customerController
                                    .newCustomer[CustomerField.address] ??
                                "لايوجد عنوان",
                            status: customerController
                                    .newCustomer[CustomerField.status] ??
                                true,
                            createdAt: isEditing
                                ? DateTime.parse(customerController
                                    .newCustomer[CustomerField.createdAt])
                                : DateTime.now(),
                            modifiedAt: DateTime.now());

                        isEditing
                            ? await customerController.updateCustomer(customer)
                            : await customerController.createCusomer(customer);

                        homeController
                            .getCustomerAccountsFromCurencyAndAccGroupIds();
                      } else {
                        CustomDialog.customSnackBar(
                            "ادخل كل القيم بطريقة صحيحة", SnackPosition.TOP);

                        return;
                      }
                    } catch (e) {
                      //print(e);
                      // CustomDialog.customSnackBar('هذا الاسم موجود من قبل');
                    }
                    // }
                  },
                ))
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

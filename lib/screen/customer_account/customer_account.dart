import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'customer_sheet.dart';

class CustomerAccountsView extends StatelessWidget {
  CustomerAccountsView({super.key});
  final CustomerAccountController customerAccountController =
      Get.put(CustomerAccountController());
  final CurencyController curencyController = Get.put(CurencyController());
  final CustomerController customerController = Get.put(CustomerController());
  final AccGroupController accGroupController = Get.put(AccGroupController());

  @override
  Widget build(BuildContext context) {
    customerAccountController.searchedList.value =
        customerAccountController.allCustomerAccounts;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: MyColors.bg,
                      ),
                      child: TextField(
                        style: MyTextStyles.subTitle,

                        onChanged: (value) {
                          var customerList = customerController.allCustomers
                              .where((p0) => p0.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          customerAccountController.searchedList.value =
                              customerAccountController.allCustomerAccounts
                                  .where((p0) =>
                                      customerList.firstWhereOrNull((element) =>
                                          element.id == p0.customerId) !=
                                      null)
                                  .toList();
                        },
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25)),
                          fillColor: MyColors.containerSecondColor,
                          focusColor: Colors.transparent,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          hintText: "بحث في حسابات العملاء",
                          hintStyle: MyTextStyles.body,
                        ),
                        // style: myTextStyles.subTitle,
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const FaIcon(
                        FontAwesomeIcons.arrowRightLong,
                        color: MyColors.secondaryTextColor,
                        size: 17,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: customerAccountController.searchedList.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: Get.height / 2,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          //color: MyColors.bg,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/customerAccount.png",
                              fit: BoxFit.cover,
                              height: Get.height / 3,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "لاتوجد اي حسابات ",
                              style: MyTextStyles.title2,
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount:
                            customerAccountController.searchedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var curency = curencyController.allCurency
                              .firstWhere((element) =>
                                  element.id ==
                                  customerAccountController
                                      .searchedList[index].curencyId)
                              .name;
                          var customer = customerController.allCustomers
                              .firstWhereOrNull((element) =>
                                  element.id ==
                                  customerAccountController
                                      .searchedList[index].customerId)
                              ?.name;

                          var accGroup = accGroupController.allAccGroups
                              .firstWhere((element) =>
                                  element.id ==
                                  customerAccountController
                                      .allCustomerAccounts[index].accgroupId)
                              .name;
                          return GestureDetector(
                            onTap: () {
                              Get.bottomSheet(CustomerAccountDetailsSheet(
                                customerAccount: customerAccountController
                                    .allCustomerAccounts[index],
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: MyColors.bg.withOpacity(0.7),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            customerAccountController
                                                    .searchedList[index].status
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "الحالة",
                                        style: MyTextStyles.body,
                                      ),
                                      const Spacer(),
                                      const SizedBox(width: 10),
                                      CustomerAccountItem(
                                          isCustomerName: true,
                                          title: customer ?? "",
                                          icon: FontAwesomeIcons.user),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: Get.width / 4,
                                        child: CustomerAccountItem(
                                            isCustomerName: false,
                                            title: curency,
                                            icon: FontAwesomeIcons.dollarSign),
                                      ),
                                      CustomerAccountItem(
                                          isCustomerName: false,
                                          title: accGroup,
                                          icon: FontAwesomeIcons.folderClosed),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerAccountItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isCustomerName;
  const CustomerAccountItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.isCustomerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: MyTextStyles.body.copyWith(
            overflow: TextOverflow.clip,
            color: isCustomerName ? MyColors.lessBlackColor : null,
            fontWeight: isCustomerName ? FontWeight.bold : null,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        FaIcon(
          icon,
          size: 12,
          color: isCustomerName
              ? MyColors.lessBlackColor
              : MyColors.secondaryTextColor,
        ),
      ],
    );
  }
}

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/notification.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_formater;

class CustomerAccountDetailsSheet extends StatefulWidget {
  final CustomerAccount customerAccount;
  const CustomerAccountDetailsSheet({super.key, required this.customerAccount});

  @override
  State<CustomerAccountDetailsSheet> createState() =>
      _CustomerAccountDetailsSheetState();
}

class _CustomerAccountDetailsSheetState
    extends State<CustomerAccountDetailsSheet> {
  CurencyController curencyController = Get.find();

  CustomerController customerController = Get.find();

  AccGroupController accGroupController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  bool status = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      status = widget.customerAccount.status;
    });
  }

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Switch.adaptive(
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red,
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                    if (value == false) {
                      CustomDialog.customSnackBar(changeStatusMessageCustomer,
                          SnackPosition.TOP, false);
                    }
                  }),
              const Spacer(),
              Text(
                "الحالة",
                style: MyTextStyles.subTitle
                    .copyWith(color: status ? Colors.green : Colors.red),
              )
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.debetColor.withOpacity(0.09)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        GlobalUtitlity.formatNumberDouble(
                            number: widget.customerAccount.totalCredit),
                        style: MyTextStyles.subTitle.copyWith(
                          color: MyColors.blackColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const FaIcon(
                        FontAwesomeIcons.arrowUp,
                        size: 10,
                        color: MyColors.debetColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ": لة",
                        style: MyTextStyles.body
                            .copyWith(color: MyColors.blackColor),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.creditColor.withOpacity(0.09)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        GlobalUtitlity.formatNumberDouble(
                            number: widget.customerAccount.totalDebit),
                        style: MyTextStyles.subTitle.copyWith(
                          color: MyColors.blackColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const FaIcon(
                        FontAwesomeIcons.arrowDown,
                        size: 10,
                        color: MyColors.creditColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ": علية",
                        style: MyTextStyles.body
                            .copyWith(color: MyColors.blackColor),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SheetItem(
            label: "الاسم",
            value: customerController.allCustomers
                .firstWhere((element) =>
                    element.id == widget.customerAccount.customerId)
                .name,
            icon: FontAwesomeIcons.user,
          ),
          const Divider(),
          SheetItem(
            label: "التصنيف",
            value: accGroupController.allAccGroups
                .firstWhere((element) =>
                    element.id == widget.customerAccount.accgroupId)
                .name,
            icon: FontAwesomeIcons.folderClosed,
          ),
          const Divider(),
          SheetItem(
            label: "العملة",
            value: curencyController.allCurency
                .firstWhere(
                    (element) => element.id == widget.customerAccount.curencyId)
                .name,
            icon: FontAwesomeIcons.dollarSign,
          ),
          const Divider(),
          SheetItem(
            label: "التأريخ",
            value: date_formater.DateFormat.yMMMMd()
                .format(widget.customerAccount.createdAt),
            icon: FontAwesomeIcons.calendar,
          ),
          const Divider(),
          SheetItem(
            label: "الوقت",
            value: date_formater.DateFormat.Hms()
                .format(widget.customerAccount.createdAt),
            icon: FontAwesomeIcons.clock,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () async {
              customerAccountController.updateCustomerAccount(
                  widget.customerAccount.copyWith(status: status));
              homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
              Get.back();
            },
            child: Container(
              height: 45,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.primaryColor.withOpacity(0.9)),
              child: Text(
                "تحد يث",
                style: MyTextStyles.title2.copyWith(
                  color: MyColors.bg,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SheetItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const SheetItem({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: MyTextStyles.subTitle.copyWith(color: MyColors.blackColor),
        ),
        const Spacer(),
        Text(
          label,
          style: MyTextStyles.subTitle.copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 10),
        FaIcon(
          icon,
          size: 15,
        ),
      ],
    );
  }
}

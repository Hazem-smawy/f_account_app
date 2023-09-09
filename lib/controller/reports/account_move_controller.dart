import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/reports_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountMovemoentController extends GetxController {
  ReportsData reportsData = ReportsData();
  var totalDebit = 0.0.obs;
  var totalCredit = 0.0.obs;

  // curency & accgroup & customer
  var curencyId = 0.obs;
  var accGroupId = 0.obs;
  var customerId = 0.obs;

  // date
  final fromDate = "".obs;
  final toDate = "".obs;
  DateTime fromDateTime = DateTime(2022, 1, 1);
  DateTime toDateTime = DateTime.now();

  // seachlist

  final searchList = <CustomerAccount>[].obs;

  // journlas list
  final customerAccountsJournals = <Journal>[].obs;

  CurencyController curencyController = Get.find();
  AccGroupController accGroupController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  TextEditingController customerSearchTextFiledController =
      TextEditingController();

  final isLoadding = false.obs;
  @override
  void onInit() {
    super.onInit();
    fromDate.value = fromDateTime.toIso8601String();
    toDate.value = toDateTime.toIso8601String();
    curencyId.value = curencyController.allCurency.last.id ?? 0;
    accGroupId.value = accGroupController.allAccGroups.last.id ?? 0;
  }

  Future<void> getCustomerAccountJournals() async {
    totalCredit.value = 0;
    totalDebit.value = 0;
    int? customerAccountId = customerAccountController.allCustomerAccounts
        .firstWhereOrNull((element) =>
            element.curencyId == curencyId.value &&
            element.accgroupId == accGroupId.value &&
            element.customerId == customerId.value)
        ?.id;
    if (customerAccountId != null) {
      customerAccountsJournals.value =
          await reportsData.getCustomerAccountJournals(
        from: DateTime.parse(fromDate.value),
        to: DateTime.parse(toDate.value),
        customerAccount: customerAccountId,
      );
    } else {
      customerAccountsJournals.clear();
    }
    customerAccountsJournals.forEach((element) {
      totalCredit.value += element.credit;
      totalDebit.value += element.debit;
    });
  }
}

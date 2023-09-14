import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:get/get.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/service/database/reports_data.dart';

class CustomerAccountsInAccGroupReportController extends GetxController {
  CustomerAccountController customerAccountController =
      Get.put(CustomerAccountController());

  final allCustomerAccountsRow = <CustomerAccount>[].obs;
  ReportsData reportsData = ReportsData();
  var totalDebit = 0.0.obs;
  var totalCredit = 0.0.obs;
  var curencyId = 0.obs;
  var accGroupId = 0.obs;

  CurencyController curencyController = Get.find();
  AccGroupController accGroupController = Get.find();

  final isLoadding = false.obs;
  @override
  void onInit() {
    super.onInit();

    curencyId.value = curencyController.allCurency.last.id ?? 0;
    // accGroupId.value = accGroupController.allAccGroups.last.id ?? 0;

    getAllAccGroupSammary();
  }

  Future<void> getAllAccGroupSammary() async {
    isLoadding.value = true;
    totalDebit.value = 0;
    totalCredit.value = 0;

    allCustomerAccountsRow.value = customerAccountController.allCustomerAccounts
        .where((p0) => p0.curencyId == curencyId.value)
        .toList();

    for (var element in allCustomerAccountsRow) {
      totalCredit.value += element.totalCredit;
      totalDebit.value += element.totalDebit;
    }

    isLoadding.value = false;
  }

  Future<void> getCustomerAccountReportsForAccGroup() async {
    isLoadding.value = true;
    totalDebit.value = 0;
    totalCredit.value = 0;
    if (accGroupId.value != 0) {
      allCustomerAccountsRow.value = customerAccountController
          .allCustomerAccounts
          .where((p0) =>
              p0.curencyId == curencyId.value &&
              p0.accgroupId == accGroupId.value)
          .toList();

      for (var element in allCustomerAccountsRow) {
        totalCredit.value += element.totalCredit;
        totalDebit.value += element.totalDebit;
      }

      isLoadding.value = false;
    } else {
      getAllAccGroupSammary();
    }
  }
}

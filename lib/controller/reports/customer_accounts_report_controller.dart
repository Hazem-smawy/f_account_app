import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:get/get.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/service/database/reports_data.dart';

class CustomerAccountReportController extends GetxController {
  CustomerAccountController customerAccountController =
      Get.put(CustomerAccountController());

  final allCustomerAccountsRow = <CustomerAccount>[].obs;
  ReportsData reportsData = ReportsData();
  var totalDebit = 0.0.obs;
  var totalCredit = 0.0.obs;
  var curencyId = 0.obs;
  final fromDate = "".obs;
  final toDate = "".obs;
  DateTime fromDateTime = DateTime(2022, 1, 1);
  DateTime toDateTime = DateTime.now();
  CurencyController curencyController = Get.find();
  final isLoadding = false.obs;
  @override
  void onInit() {
    super.onInit();
    fromDate.value = fromDateTime.toIso8601String();
    toDate.value = toDateTime.toIso8601String();
    curencyId.value = curencyController.allCurency.last.id ?? 0;
    getCustomerAccountReports();
  }

  Future<void> getCustomerAccountReports() async {
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

  Future<void> getCustomerAccountReportsForAccGroup(int accGroupId) async {
    isLoadding.value = true;
    totalDebit.value = 0;
    totalCredit.value = 0;

    allCustomerAccountsRow.value = customerAccountController.allCustomerAccounts
        .where((p0) =>
            p0.curencyId == curencyId.value && p0.accgroupId == accGroupId)
        .toList();

    for (var element in allCustomerAccountsRow) {
      totalCredit.value += element.totalCredit;
      totalDebit.value += element.totalDebit;
    }

    isLoadding.value = false;
  }
}

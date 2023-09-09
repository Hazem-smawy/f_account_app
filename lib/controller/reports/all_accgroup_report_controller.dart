import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/service/database/reports_data.dart';
import 'package:get/get.dart';

class AllAccGroupReportsController extends GetxController {
  ReportsData reportsData = ReportsData();
  var totalDebit = 0.0.obs;
  var totalCredit = 0.0.obs;
  var curencyId = 0.obs;

  CurencyController curencyController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  final isLoadding = false.obs;
  @override
  void onInit() {
    super.onInit();

    curencyId.value = curencyController.allCurency.last.id ?? 0;
    getAllAccGroupSammary();
  }

  Future<void> getAllAccGroupSammary() async {
    totalCredit.value = 0;
    totalDebit.value = 0;
    customerAccountController.allCustomerAccounts
        .where((p0) => p0.curencyId == curencyId.value)
        .forEach((element) {
      totalDebit.value += element.totalDebit;
      totalCredit.value += element.totalCredit;
    });
  }

  (double, double) getTotalDebit(int accGroupId) {
    var privateTotalDebit = 0.0;
    var privateTotalCredit = 0.0;

    customerAccountController.allCustomerAccounts
        .where((p0) =>
            p0.curencyId == curencyId.value && p0.accgroupId == accGroupId)
        .forEach((element) {
      privateTotalCredit += element.totalCredit;
      privateTotalDebit += element.totalDebit;
    });

    return (privateTotalCredit, privateTotalDebit);
  }
}

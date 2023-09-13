// import 'package:account_app/controller/curency_controller.dart';
// import 'package:account_app/service/database/reports_data.dart';
// import 'package:get/get.dart';

// class AllMoneyReportController extends GetxController {
//   RxList<dynamic> allMoneyRows = [].obs;
//   ReportsData reportsData = ReportsData();
//   var totalDebit = 0.0.obs;
//   var totalCredit = 0.0.obs;
//   var curencyId = 0.obs;
//   final fromDate = "".obs;
//   final toDate = "".obs;
//   DateTime fromDateTime = DateTime(2022, 1, 1);
//   DateTime toDateTime = DateTime.now();
//   CurencyController curencyController = Get.find();
//   final isLoadding = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     fromDate.value = fromDateTime.toIso8601String();
//     toDate.value = toDateTime.toIso8601String();
//     curencyId.value = curencyController.allCurency.last.id ?? 0;
//     getAllMoney().then((value) => print(allMoneyRows));
//   }

//   Future<void> getAllMoney() async {
//     isLoadding.value = true;
//     totalDebit.value = 0;
//     totalCredit.value = 0;
//     allMoneyRows.value = await reportsData.getAllMoneyReport(
//         from: DateTime.parse(fromDate.value),
//         to: DateTime.parse(toDate.value),
//         curencyId: curencyId.value);

//     print(allMoneyRows);

//     if (allMoneyRows.isNotEmpty) {
//       allMoneyRows.forEach((element) {
//         totalCredit.value += element['credit'];
//         totalDebit.value += element['debit'];
//       });
//     }
//     isLoadding.value = false;
//   }
// }

// // ignore_for_file: prefer_const_constructors

// import 'package:account_app/constant/colors.dart';
// import 'package:account_app/controller/reports/all_money_report_controller.dart';
// import 'package:account_app/screen/all_reports/all_money_report/row.dart';
// import 'package:account_app/screen/all_reports/reports_widget/date_filter_widget.dart';
// import 'package:account_app/screen/all_reports/reports_widget/empyt_report.dart';
// import 'package:account_app/screen/all_reports/reports_widget/report_crency_filter.dart';
// import 'package:account_app/screen/all_reports/reports_widget/report_headers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AllMoenyReportScreen extends StatelessWidget {
//   AllMoenyReportScreen({super.key});
//   // final DailyReportsController reportsController = Get.put(DailyReportsController());
//   final AllMoneyReportController allMoneyReportController =
//       Get.put(AllMoneyReportController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: ReportHeaderWidget(
//                 action: () {
//                   //TODO: pdf print
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 15),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: MyColors.bg,
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5, right: 5),
//                     child: DateFilterWidget(
//                       controller: allMoneyReportController,
//                       action: () {
//                         allMoneyReportController.getAllMoney();
//                       },
//                     ),
//                   ),
//                   ReportCurenyFilterWidget(
//                       controller: allMoneyReportController,
//                       curencyId: allMoneyReportController.curencyId.value,
//                       action: () {
//                         allMoneyReportController.getAllMoney();
//                       })
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Expanded(
//                 child: Obx(
//               () => allMoneyReportController.allMoneyRows.isEmpty
//                   ? EmptyReportListWidget()
//                   : ListView.builder(
//                       itemCount: allMoneyReportController.allMoneyRows.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return AllMoneyRowWidget(
//                           allMoneyRow:
//                               allMoneyReportController.allMoneyRows[index],
//                         );
//                       },
//                     ),
//             )),
//             // ReportFooterWidget()
//           ],
//         ),
//       ),
//     );
//   }
// }

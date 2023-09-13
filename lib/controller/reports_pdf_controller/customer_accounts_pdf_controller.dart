import 'package:account_app/controller/copy_controller.dart';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import 'package:pdf/pdf.dart';

import 'dart:io';
import 'package:pdf/widgets.dart';

import '../accgroup_controller.dart';
import '../curency_controller.dart';
import '../customers_controller.dart';
import '../pdf_controller.dart';
import '../reports/customer_accounts_report_controller.dart';

class CustomerAccountPdfController {
  static CustomerAccountReportController customerAccountReportController =
      Get.find();
  static CurencyController curencyController = Get.find();
  static CustomerController customerController = Get.find();
  static AccGroupController accGroupController = Get.find();

  static Future<void> generateCustomerAccountPdfReports() async {
    CopyController copyController = Get.find();
    if (Platform.isAndroid) {
      copyController.requestPermission();
    }

    final pdf = Document(
      theme: ThemeData.withFont(
        base: PdfApi.enFont,
        fontFallback: [PdfApi.globalCustomFont],
      ),
    );
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        build: (context) => [
          PdfApi.companyInfHeader(),
          Divider(),
          customerAccountTitle(),
          curencyName(),
          buildCustomerAccountsTableReport(),
          PdfApi.sammaryFooterMoney(
              credit: customerAccountReportController.totalCredit.value,
              debit: customerAccountReportController.totalDebit.value)
        ],
        footer: (context) => Column(children: [
          Divider(),
          PdfApi.documentFooter(
              '${context.pageNumber}  / ${context.pagesCount}')
        ]),
      ),
    );
    File file = await PdfApi.saveDocument(
        name: 'dialy_reports_${DateTime.now().toIso8601String()}.pdf',
        pdf: pdf);
    OpenFile.open(file.path);
  }

  static Widget buildCustomerAccountsTableReport() {
    final headers = ["الحساب", "عليك", "لك", "التصنيف", 'الاسم'];

    return Table(
        border: TableBorder.all(color: PdfColors.grey300),
        tableWidth: TableWidth.max,
        children: [
          TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: PdfApi.buildHeader(headers)),
          ...customerAccountReportController.allCustomerAccountsRow.map((e) {
            return TableRow(children: [
              PdfApi.paddedHeadingTextEnglishCell(
                  '${e.totalCredit - e.totalDebit}'),
              PdfApi.coloredText(e.totalCredit.toString(), PdfColors.green),
              PdfApi.coloredText(e.totalDebit.toString(), PdfColors.red),
              PdfApi.paddedHeadingTextArabicCell(accGroupController.allAccGroups
                  .firstWhere((element) => element.id == e.accgroupId)
                  .name),
              PdfApi.paddedHeadingTextArabicCell(customerController.allCustomers
                  .firstWhere((element) => element.id == e.customerId)
                  .name),
            ]);
          }).toList()
        ]);
  }

  static Widget curencyName() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              curencyController.allCurency
                  .firstWhere((element) =>
                      element.id ==
                      customerAccountReportController.curencyId.value)
                  .name,
              style: TextStyle(
                font: PdfApi.globalCustomFont,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 30),
          ],
        ),
      )
    ]);
  }

  static Widget customerAccountTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              " الحسابات",
              style: TextStyle(
                font: PdfApi.globalCustomFont,
                fontSize: 14,
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

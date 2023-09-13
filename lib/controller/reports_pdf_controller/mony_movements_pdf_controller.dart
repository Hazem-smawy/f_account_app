import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/customers_controller.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_formater;
import 'package:open_file/open_file.dart';

import 'package:pdf/pdf.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';

import '../accgroup_controller.dart';
import '../curency_controller.dart';
import '../pdf_controller.dart';
import '../reports/account_move_controller.dart';

class MoneyMovementPdfController {
  static AccountMovemoentController accountMovemoentController = Get.find();
  static CustomerController customerController = Get.find();
  static AccGroupController accGourpController = Get.find();
  static CurencyController curencyController = Get.find();

  static Future<void> generateMoneyMovementReportPdf() async {
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
          buildMoneyMovementsTableReport(),
          PdfApi.sammaryFooterMoney(
              credit: accountMovemoentController.totalCredit.value,
              debit: accountMovemoentController.totalDebit.value),
        ],
        footer: (context) => Column(children: [Divider(), Text("footer here")]),
      ),
    );
    File file = await PdfApi.saveDocument(
        name: 'dialy_reports_${DateTime.now().toIso8601String()}.pdf',
        pdf: pdf);
    OpenFile.open(file.path);
  }

  static Widget buildMoneyMovementsTableReport() {
    final headers = ["التأريخ", "لك", "المبلغ", 'التفاصيل'];

    return Table(
        border: TableBorder.all(color: PdfColors.grey300),
        tableWidth: TableWidth.max,
        children: [
          TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: PdfApi.buildHeader(headers)),
          ...accountMovemoentController.customerAccountsJournals.map((e) {
            return TableRow(children: [
              PdfApi.paddedHeadingTextEnglishCell(
                date_formater.DateFormat.yMd().format(e.registeredAt),
              ),
              PdfApi.debitOrCreditView(e.credit > e.debit),
              PdfApi.paddedHeadingTextEnglishCell('${e.credit - e.debit}'),
              PdfApi.paddedHeadingTextArabicCell(e.details),
            ]);
          }).toList()
        ]);
  }

  static Widget customerAccountTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10),
            Text(
              customerController.allCustomers
                  .firstWhere((element) =>
                      element.id == accountMovemoentController.customerId.value)
                  .name,
              style: TextStyle(
                font: PdfApi.globalCustomFont,
                fontFallback: [PdfApi.enFont],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Text(
              accGourpController.allAccGroups
                  .firstWhere((element) =>
                      element.id == accountMovemoentController.accGroupId.value)
                  .name,
              style: TextStyle(
                  font: PdfApi.globalCustomFont,
                  fontSize: 12,
                  fontFallback: [PdfApi.enFont],
                  color: PdfColors.grey),
            ),
            Text(
              curencyController.allCurency
                  .firstWhere((element) =>
                      element.id == accountMovemoentController.curencyId.value)
                  .name,
              style: TextStyle(
                  font: PdfApi.globalCustomFont,
                  fontSize: 12,
                  fontFallback: [PdfApi.enFont],
                  color: PdfColors.grey),
            ),
            SizedBox(height: 30),
          ],
        ),
      )
    ]);
  }
}

import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/reports/daily_report_controller.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_formater;

import 'package:pdf/pdf.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';

import '../pdf_controller.dart';

class DailyPdfController {
  static DailyReportsController dailyReportsController = Get.find();
  static Future<File> generateDailyReportPdf() async {
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
          dailyPdfHeader(),
          buildDailyTableReport(),
          PdfApi.sammaryFooterMoney(
              credit: dailyReportsController.totalCredit.value,
              debit: dailyReportsController.totalDebit.value)
        ],
        footer: (context) => Column(children: [
          Divider(),
          PdfApi.documentFooter(
              '${context.pageNumber}  /  ${context.pagesCount}')
        ]),
      ),
    );
    return PdfApi.saveDocument(
      name:
          'E-smart_${date_formater.DateFormat.yMMMEd().format(DateTime.now())}_report.pdf',
      pdf: pdf,
    );
  }

  static Widget buildDailyTableReport() {
    final headers = [
      "التأريخ",
      "لك",
      "العملة",
      "المبلغ",
      'التفاصيل',
      "الأسم",
      'التصنيف',
    ];

    return Table(
        border: TableBorder.all(color: PdfColors.grey300),
        tableWidth: TableWidth.max,
        children: [
          TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: PdfApi.buildHeader(headers)),
          ...dailyReportsController.journalsReports.map((e) {
            return TableRow(children: [
              PdfApi.paddedHeadingTextEnglishCell(
                date_formater.DateFormat.yMd().format(
                  DateTime.parse(e['date']),
                ),
              ),
              PdfApi.debitOrCreditView(e['credit'] > e['debit']),
              PdfApi.paddedHeadingTextArabicCell(e['curencyName']),
              PdfApi.paddedHeadingTextEnglishCell(
                  '${e['credit'] - e['debit']}'),
              PdfApi.paddedHeadingTextArabicCell('${e['details']}'),
              PdfApi.paddedHeadingTextArabicCell('${e['name']}'),
              PdfApi.paddedHeadingTextArabicCell('${e['accName']}'),
            ]);
          }).toList()
        ]);
  }

  static Widget dailyPdfHeader() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              " القيود اليومية",
              style: TextStyle(
                font: PdfApi.globalCustomFont,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${date_formater.DateFormat.yMd().format(DateTime.parse(dailyReportsController.toDate.value))} --- ${date_formater.DateFormat.yMd().format(DateTime.parse(dailyReportsController.fromDate.value))}',
              style: TextStyle(
                font: PdfApi.enFont,
                fontSize: 14,
                color: PdfColors.grey700,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      )
    ]);
  }
}

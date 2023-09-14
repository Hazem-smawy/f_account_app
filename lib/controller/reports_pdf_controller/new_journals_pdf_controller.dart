import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/home_controller.dart';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import 'package:pdf/pdf.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart' as date_formater;
import 'dart:io';
import 'package:pdf/widgets.dart';

import '../pdf_controller.dart';

class NewDailyPdfController {
  static HomeController homeController = Get.find();
  static Future<void> generateTodayDailyReportPdf() async {
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
                Divider(color: PdfColors.grey),
                PdfApi.documentHeader(),
                SizedBox(height: 20),
                buildDailyTableReport(),
              ],
          footer: (context) {
            final pages = "${context.pageNumber}  / ${context.pagesCount}";
            return Column(children: [Divider(), PdfApi.documentFooter(pages)]);
          }),
    );
    File file = await PdfApi.saveDocument(
      name:
          'E-smart_${date_formater.DateFormat.yMMMEd().format(DateTime.now())}_report.pdf',
      pdf: pdf,
    );

    OpenFile.open(file.path);
  }

  static Widget buildDailyTableReport() {
    final headers = [
      "لك",
      "العملة",
      "المبلغ",
      'التصنيف',
      "الأسم",
    ];

    return Table(
        border: TableBorder.all(color: PdfColors.grey300),
        tableWidth: TableWidth.max,
        children: [
          TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: PdfApi.buildHeader(headers)),
          ...homeController.todaysJournals.map((e) {
            return TableRow(children: [
              PdfApi.debitOrCreditView(e['credit'] > e['debit']),
              PdfApi.paddedHeadingTextArabicCell(e['curencyName']),
              PdfApi.paddedHeadingTextEnglishCell(
                  '${e['credit'] - e['debit']}'),
              PdfApi.paddedHeadingTextArabicCell('${e['accName']}'),
              PdfApi.paddedHeadingTextArabicCell('${e['name']}'),
            ]);
          }).toList()
        ]);
  }
}

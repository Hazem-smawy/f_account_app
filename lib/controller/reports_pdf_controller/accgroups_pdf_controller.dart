import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/reports/accgroups_report_controller.dart';
import 'package:get/get.dart';

import 'package:open_file/open_file.dart';

import 'package:pdf/pdf.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';

import '../pdf_controller.dart';

class AccGroupsPdfContoller {
  static final AccGroupsReportController allAccGroupReportsController =
      Get.find();
  static final AccGroupController accGroupController = Get.find();

  static Future<void> generateAllAccGroupPdfReports() async {
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
                accGroupsTitle(),
                buildAccGroupTableReport(),
                PdfApi.sammaryFooterMoney(
                    credit: allAccGroupReportsController.totalCredit.value,
                    debit: allAccGroupReportsController.totalDebit.value)
              ],
          footer: (context) {
            final pages = "${context.pageNumber}  / ${context.pagesCount}";
            return Column(children: [Divider(), PdfApi.documentFooter(pages)]);
          }),
    );
    File file = await PdfApi.saveDocument(
        name: 'reports_${DateTime.now().toIso8601String()}.pdf', pdf: pdf);
    OpenFile.open(file.path);
  }

  static Widget buildAccGroupTableReport() {
    final headers = ["الحساب", "عليك", "لك", "التصنيف"];

    return Table(
        border: TableBorder.all(color: PdfColors.grey300),
        tableWidth: TableWidth.max,
        children: [
          TableRow(
              decoration: BoxDecoration(color: PdfColors.grey200),
              children: PdfApi.buildHeader(headers)),
          ...accGroupController.allAccGroups.map((e) {
            return TableRow(children: [
              PdfApi.coloredText(
                  (allAccGroupReportsController.getTotalDebit(e.id ?? 0).$1 -
                          allAccGroupReportsController
                              .getTotalDebit(e.id ?? 0)
                              .$2)
                      .toString(),
                  allAccGroupReportsController.getTotalDebit(e.id ?? 0).$1 <
                          allAccGroupReportsController
                              .getTotalDebit(e.id ?? 0)
                              .$2
                      ? PdfColors.red
                      : PdfColors.green),
              PdfApi.coloredText(
                  allAccGroupReportsController
                      .getTotalDebit(e.id ?? 0)
                      .$1
                      .toString(),
                  PdfColors.green),
              PdfApi.coloredText(
                  allAccGroupReportsController
                      .getTotalDebit(e.id ?? 0)
                      .$2
                      .toString(),
                  PdfColors.red),
              PdfApi.paddedHeadingTextArabicCell(e.name),
            ]);
          }).toList()
        ]);
  }

  static Widget accGroupsTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              " التصنيفات",
              style: TextStyle(
                font: PdfApi.globalCustomFont,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 30),
          ],
        ),
      )
    ]);
  }
}

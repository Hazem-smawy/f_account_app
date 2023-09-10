// import 'package:account_app/models/home_model.dart';
// import 'package:flutter/material.dart';

import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/daily_report_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as DateFormater;

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:external_path/external_path.dart' as ex;
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';

class PdfApi extends GetxController {
  /*
  // static Future<File> generatePdf({required HomeModel homeModel}) async {
  //   final document = PdfDocument();
  //   final page = document.pages.add();
  //   drowGrid(homeModel, page);
  //   drawPage(homeModel, page);

  //   return saveFile(document);
  // }

  // static void drowGrid(HomeModel homeModel, PdfPage page) {
  //   final grid = PdfGrid();
  //   grid.columns.add(count: 4);
  //   final headerRow = grid.headers.add(1)[0];

  //   grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable1LightAccent5);

  //   headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 144, 196));
  //   headerRow.style.textBrush = PdfBrushes.white;
  //   headerRow.cells[0].value = "id";
  //   headerRow.cells[1].value = "name";
  //   headerRow.cells[2].value = "price";
  //   headerRow.cells[3].value = "amount";

  //   headerRow.style.font =
  //       PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
  //   for (int i = 0; i < headerRow.cells.count; i++) {
  //     final row = grid.rows.add();
  //     row.cells[0].value = "${homeModel.name}--> $i";
  //     row.cells[1].value = "${homeModel.totalCredit}--> $i";
  //     row.cells[2].value = "${homeModel.totalDebit} --> $i";
  //     row.cells[3].value = "hel --> $i";
  //     for (int i = 0; i < row.cells.count; i++) {
  //       row.cells[i].style.cellPadding =
  //           PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  //     }
  //   }

  //   for (int i = 0; i < headerRow.cells.count; i++) {
  //     headerRow.cells[i].style.cellPadding =
  //         PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  //   }
  //   grid.draw(page: page, bounds: const Rect.fromLTWH(0, 40, 0, 0));
  // }

  // static Future<File> saveFile(PdfDocument document) async {
  //   final path = await getApplicationDocumentsDirectory();
  //   final fileName =
  //       '${path.path}/Invoices${DateTime.now().toIso8601String()}.pdf';

  //   final file = File(fileName);
  //   file.writeAsBytes(await document.save());
  //   document.dispose();

  //   return file;
  // }

  // static void drawPage(HomeModel homeModel, PdfPage page) {
  //   final pageSize = page.getClientSize();
  //   page.graphics.drawString(
  //     "home model",
  //     PdfStandardFont(PdfFontFamily.helvetica, 12),
  //     format: PdfStringFormat(alignment: PdfTextAlignment.center),
  //     bounds: Rect.fromLTWH(pageSize.width - 100, pageSize.height - 200, 0, 0),
  //   );
  // }
  */
/*
  static Future<File> generateCenterdText(String text) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (context) => Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );

    return saveDocument(name: 'centerd_text.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.absolute.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
  */
  /*

 ? Header
 ? UrlLink
 ? footer



 */
  static Font? globalCustomFont;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  static DailyReportsController dailyReportsController = Get.find();

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    if (Platform.isAndroid) {
      String path = await ex.ExternalPath.getExternalStoragePublicDirectory(
          ex.ExternalPath.DIRECTORY_DOWNLOADS);
      final file = File('${path}/$name');
      await file.writeAsBytes(bytes);

      return file;
    } else {
      final path = await getApplicationDocumentsDirectory();
      final file = File('${path.path}/$name');
      await file.writeAsBytes(bytes);
      return file;
    }
  }

  static Widget buildTitle(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("CustomerAccounts"),
          Text("hello from customerAccounts"),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildTable() {
    final headers = ["description", 'date', 'Quantity'];
    List arr = [1, 1, 3];
    final data = arr.map((item) {
      return [
        "descrip",
        "date here",
        10,
      ];
    }).toList();

    return TableHelper.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: const BoxDecoration(
          color: PdfColors.grey300,
        ),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
        });
  }

  static Future<File> generateDailyReportPdf() async {
    CopyController copyController = Get.find();
    if (Platform.isAndroid) {
      copyController.requestPermission();
    }

    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/Rubik-Regular.ttf'));
    // final customFont2 = Font.ttf(
    //     await rootBundle.load('assets/fonts/ScheherazadeNew-Regular.ttf'));
    final customFont3 =
        Font.ttf(await rootBundle.load('assets/fonts/Cairo-Regular.ttf'));
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: customFont3,
          fontFallback: [
            customFont,
            customFont3,
          ],
        ),
        build: (context) => [
          buildTitle("title"),
          buildDailyTableReport(customFont3),
        ],
        footer: (context) => Column(children: [Divider(), Text("footer here")]),
      ),
    );
    return PdfApi.saveDocument(name: 'mycustomerAccounts.pdf', pdf: pdf);
  }

  static Widget buildDailyTableReport(Font font) {
    final headers = ["التأريخ", "لك", "العملة", "المبلغ", "الأسم"];

    return Table(tableWidth: TableWidth.max, children: [
      TableRow(
        decoration: BoxDecoration(color: PdfColors.grey300),
        children: headers
            .map(
              (e) => paddedHeadingTextCell(e, font),
            )
            .toList(),
      ),
      ...dailyReportsController.journalsReports.map((e) {
        return TableRow(children: [
          paddedHeadingTextCell(
              DateFormater.DateFormat.yMd().format(
                DateTime.parse(e['date']),
              ),
              font),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(4),
              child: Center(
                child: Container(
                  //  margin: EdgeInsets.only(top: 10),

                  width: 10,
                  height: 5,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: e['credit'] > e['debit']
                        ? PdfColors.green500
                        : PdfColors.red500,
                  ),
                ),
              ),
            ),
          ]),
          paddedHeadingTextCell(e['curencyName'], font),
          paddedHeadingTextCell('${e['credit'] - e['debit']}', font),
          paddedHeadingTextCell('${e['name']}', font)
        ]);
      }).toList()
    ]);

    // return TableHelper.fromTextArray(
    //     headers: headers,
    //     data: data,
    //     border: null,
    //     headerStyle: TextStyle(fontWeight: FontWeight.bold),
    //     headerDecoration: const BoxDecoration(
    //       color: PdfColors.grey300,
    //     ),
    //     cellHeight: 30,
    //     cellAlignments: {
    //       0: Alignment.centerLeft,
    //       1: Alignment.centerRight,
    //       2: Alignment.centerRight,
    //     });
  }

  static Padding paddedHeadingTextCell(String textContent, Font? font) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(children: [
        Row(children: [
          Text(
            textContent,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ]),
      ]),
    );
  }
}

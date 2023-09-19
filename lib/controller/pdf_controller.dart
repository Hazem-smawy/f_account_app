// import 'package:account_app/models/home_model.dart';
// import 'package:flutter/material.dart';

import 'package:account_app/controller/image_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/utility/curency_format.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart' as date_formater;

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
  static late Font globalCustomFont;
  static late Font enFont;
  static late MemoryImage myLogo;

  static PersonalController personalController = Get.find();
  static ImageController imageController = Get.find();
  @override
  void onInit() async {
    super.onInit();
    globalCustomFont =
        Font.ttf(await rootBundle.load('assets/fonts/DroidKufi-Regular.ttf'));
    enFont =
        Font.ttf(await rootBundle.load('assets/fonts/Tajawal-Regular.ttf'));
    myLogo = MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    CustomDialog.customSnackBar(
        " تم حفظ الملف في ملف التنزيلات ", SnackPosition.TOP, false);

    final bytes = await pdf.save();
    if (Platform.isAndroid) {
      String path = await ex.ExternalPath.getExternalStoragePublicDirectory(
          ex.ExternalPath.DIRECTORY_DOWNLOADS);
      final file = File('$path/$name');
      await file.writeAsBytes(bytes);
      Future.delayed(const Duration(milliseconds: 200));

      return file;
    } else {
      final path = await getApplicationDocumentsDirectory();
      final file = File('${path.path}/$name');
      await file.writeAsBytes(bytes);

      return file;
    }
  }

  // static Widget buildTable() {
  //   final headers = ["description", 'date', 'Quantity'];
  //   List arr = [1, 1, 3];
  //   final data = arr.map((item) {
  //     return [
  //       "descrip",
  //       "date here",
  //       10,
  //     ];
  //   }).toList();

  //   return TableHelper.fromTextArray(
  //       headers: headers,
  //       data: data,
  //       border: null,
  //       headerStyle: TextStyle(fontWeight: FontWeight.bold),
  //       headerDecoration: const BoxDecoration(
  //         color: PdfColors.grey300,
  //       ),
  //       cellHeight: 30,
  //       cellAlignments: {
  //         0: Alignment.centerLeft,
  //         1: Alignment.centerRight,
  //         2: Alignment.centerRight,
  //       });
  // }

  static Padding paddedHeadingTextEnglishCell(String textContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(textContent,
                    style: TextStyle(
                      font: enFont,
                    )),
              )
            ]),
      ]),
    );
  }

  static List<Widget> buildHeader(List headers) {
    return headers
        .map(
          (e) => paddedHeadingTextCellHeader(e),
        )
        .toList();
  }

  static Padding paddedHeadingTextArabicCell(String textContent) {
    final isRTL = date_formater.Bidi.detectRtlDirectionality(textContent);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(children: [
        if (!isRTL) SizedBox(height: 5),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  textContent,
                  style: TextStyle(
                    font: globalCustomFont,
                    fontFallback: [enFont],
                    fontSize: 10,
                  ),
                ),
              )
            ]),
      ]),
    );
  }

  static Widget debitOrCreditView(bool forYou) =>
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Container(
              //  margin: EdgeInsets.only(top: 10),

              width: 15,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: forYou ? PdfColors.green500 : PdfColors.red500,
              ),
            ),
          ),
        )
      ]);

  static Padding paddedHeadingTextCellHeader(String textContent) {
    final isRTL = date_formater.Bidi.detectRtlDirectionality(textContent);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Directionality(
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: Text(
                textContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    font: globalCustomFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    fontFallback: [enFont]),
              ),
            )
          ]),
    );
  }

  static Padding paddedHeadingTextCellRegular(String textContent) {
    final isRTL = date_formater.Bidi.detectRtlDirectionality(textContent);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Directionality(
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: Text(
                textContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  font: globalCustomFont,
                  color: PdfColors.grey,
                  fontSize: 10,
                  fontFallback: [enFont],
                ),
              ),
            )
          ]),
    );
  }

  static Padding coloredText(String textContent, PdfColor color) {
    final isRTL = date_formater.Bidi.detectRtlDirectionality(textContent);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: Text(textContent,
                    style: TextStyle(
                      color: color,
                      font: enFont,
                    )),
              )
            ]),
      ]),
    );
  }

  static Padding coloredArabicText(String textContent, PdfColor color) {
    final isRTL = date_formater.Bidi.detectRtlDirectionality(textContent);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: Text(textContent,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      font: globalCustomFont,
                      fontFallback: [enFont],
                    )),
              )
            ]),
      ]),
    );
  }

  static Widget documentHeader() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "العمليات الحديثة",
              style: TextStyle(
                font: globalCustomFont,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Text(
              date_formater.DateFormat.yMd().format(DateTime.now()),
              style: TextStyle(
                font: enFont,
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
  // global header and footer

  static Widget documentFooter(String page) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date_formater.DateFormat.yMd().format(DateTime.now()),
            style: TextStyle(
              font: enFont,
              color: PdfColors.grey900,
            ),
          ),
          Text(page),
          Row(children: [
            paddedHeadingTextEnglishCell('e-smart'),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: myLogo,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ])
        ],
      ),
    );
  }

  static Widget companyInfHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (imageController.customImage['image'] != null)
            Column(children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(imageController.customImage['image']),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 5),
              paddedHeadingTextCellHeader(
                  personalController.newPersonal['address'] ?? ""),
            ]),
          Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            paddedHeadingTextCellHeader(
                personalController.newPersonal['name'] ?? ""),
            paddedHeadingTextCellRegular(
                personalController.newPersonal['email'] ?? ""),
            paddedHeadingTextCellRegular(
                personalController.newPersonal['phone'] ?? "")
          ])
        ],
      ),
    );
  }

  static Widget sammaryFooterMoney(
      {required double credit, required double debit}) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: PdfColors.grey300,
        ),
      ),
      child: Column(
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            coloredText(GlobalUtitlity.formatNumberDouble(number: credit),
                PdfColors.green),
            SizedBox(width: 20),
            Container(
                width: 2,
                height: 20,
                decoration: const BoxDecoration(color: PdfColors.grey300)),
            SizedBox(width: 20),
            coloredText(GlobalUtitlity.formatNumberDouble(number: debit),
                PdfColors.red),
          ]),
          Divider(color: PdfColors.grey300, height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            coloredText(
                GlobalUtitlity.formatNumberDouble(number: (credit - debit)),
                credit > debit ? PdfColors.green : PdfColors.red),
            SizedBox(width: 10),
            paddedHeadingTextArabicCell("الإ جمالي :"),
          ]),
        ],
      ),
    );
  }
}

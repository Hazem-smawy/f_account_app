// import 'package:account_app/models/home_model.dart';
// import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
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
}

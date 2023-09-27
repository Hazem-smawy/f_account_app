import 'dart:io';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/widget/custom_btns_widges.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FolderCopyWidget extends StatefulWidget {
  const FolderCopyWidget({super.key});

  @override
  State<FolderCopyWidget> createState() => _FolderCopyWidgetState();
}

class _FolderCopyWidgetState extends State<FolderCopyWidget> {
  CopyController copyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const FaIcon(FontAwesomeIcons.folderClosed),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "النسخ الإحتياطي الى الملفات",
                    style: MyTextStyles.title2,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCopyBtnWidget(
              color: Colors.green,
              icon: FontAwesomeIcons.upload,
              topIcon: FontAwesomeIcons.upload,
              label: "عمل نسخة جد يد ة",
              action: () => Platform.isAndroid
                  ? copyController.selectFolder()
                  : copyController.selectFolderIos(),
              description:
                  "قم بعمل نسخة إحتياطية جديدة , لحفظ كل بياناتك في ملفات الجهاز وإستعادتها في وقت لاحق",
            ),
            CustomCopyBtnWidget(
              topIcon: FontAwesomeIcons.download,
              color: const Color.fromARGB(197, 149, 7, 7),
              icon: FontAwesomeIcons.download,
              label: "فتح نسخة سابقة",
              //  action: () {},
              action: () => copyController.openDatabaseFile(),

              description:
                  'عند استعادة اي نسخة سابقة سيتم حذف جميع البيانات الحالية , تأكد من عمل نسخة إحتياطية للبيانات الحالية',
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

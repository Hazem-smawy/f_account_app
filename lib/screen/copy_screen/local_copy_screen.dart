import 'package:account_app/screen/copy_screen/folder_copy_widget.dart';

import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';

class LocalCopyScreen extends StatelessWidget {
  const LocalCopyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomBackBtnWidget(title: " النسخ الإ حتياطي"),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  FolderCopyWidget(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

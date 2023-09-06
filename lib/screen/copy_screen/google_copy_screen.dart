import 'package:account_app/screen/copy_screen/google_drive_copy.dart';

import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';

class GoogleCopyScreen extends StatelessWidget {
  const GoogleCopyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomBackBtnWidget(title: " النسخ الإ حتياطي"),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  GoogleDriveCopyWidget(),
                  SizedBox(
                    height: 20,
                  ),
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

import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';

import 'package:intl/intl.dart';

class ShowAllFiles extends StatefulWidget {
  const ShowAllFiles({super.key});

  @override
  State<ShowAllFiles> createState() => _ShowAllFilesState();
}

class _ShowAllFilesState extends State<ShowAllFiles> {
  List<File>? files = [];
  bool isLoading = false;

  CopyController copyController = Get.find();

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Future<void> loadFiles() async {
    setState(() {
      isLoading = true;
    });

    List<File>? fileCopy = await copyController.getAllFiles();

    setState(() {
      files = fileCopy;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const CustomBackBtnWidget(
                title: " كل الملفات",
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: !isLoading
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.bg,
                        ),
                        child: files?.length != null && files!.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1 / 1.2),
                                itemCount: files!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ShowFileItemWidget(
                                    file: files![index],
                                    action: () async {
                                      await loadFiles();
                                    },
                                  );
                                },
                              )
                            : const EmptyWidget(
                                imageName: 'assets/images/accGroup.png',
                                label: "لاتوجد أي نسخة ",
                              ),
                      )
                    : const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowFileItemWidget extends StatelessWidget {
  final File file;
  final VoidCallback action;

  ShowFileItemWidget({super.key, required this.file, required this.action});

  final CopyController copyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomDialog.showDialog(
          title: "إستعادة",
          description: "هل انت متأكد من إستعادة هذه النسخة",
          icon: FontAwesomeIcons.circleInfo,
          color: Colors.green,
          action: () {
            Get.back();
            copyController.getSlelectedCopy(file);
          },
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColors.containerColor,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  //  padding: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.bg,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.database,
                    size: 40,
                    color: MyColors.lessBlackColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    file.name ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.lessBlackColor,
                  ),
                  child: FittedBox(
                    child: Text(
                      DateFormat.yMd()
                          .format(file.modifiedTime ?? DateTime.now()),
                      style: const TextStyle(
                        color: MyColors.bg,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Text(
                    DateFormat.Hm().format(file.modifiedTime ?? DateTime.now()),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 5,
            bottom: 5,
            child: GestureDetector(
              onTap: () {
                if (Get.isSnackbarOpen != true) {
                  CustomDialog.showDialog(
                    title: "حذف",
                    description: "هل انت متأكد من حذف هذه النسخة",
                    icon: FontAwesomeIcons.circleInfo,
                    color: Colors.red,
                    action: () async {
                      Get.back();
                      CustomDialog.loadingProgress();

                      await copyController.deleteDriveFile(file);
                      action();
                      Get.back();
                      CustomDialog.customSnackBar(
                          "تم الحذف بنجاح", SnackPosition.TOP, false);
                    },
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.bg.withOpacity(0.5),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.trash,
                  size: 15,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

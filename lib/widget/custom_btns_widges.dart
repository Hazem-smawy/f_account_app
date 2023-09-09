import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomBackBtnWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  CustomBackBtnWidget({
    required this.title,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: MyColors.bg,
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () async {
                  CustomDialog.loadingProgress();

                  Get.back();
                },
                child: const FaIcon(
                  FontAwesomeIcons.filePdf,
                  size: 20,
                  color: MyColors.lessBlackColor,
                ),
              ),
            ),
          if (icon == null) const SizedBox(width: 20),
          Expanded(
              child: Center(
            child: Text(
              title,
              style: myTextStyles.title2,
            ),
          )),
          GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: FaIcon(
                FontAwesomeIcons.arrowRightLong,
                color: MyColors.secondaryTextColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomDeleteBtnWidget extends StatelessWidget {
  final String lable;
  final VoidCallback action;
  const CustomDeleteBtnWidget(
      {super.key, required this.lable, required this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.red.withOpacity(0.15),
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        action();
      },
      child: Text(
        lable,
        style: myTextStyles.title1.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}

class CustomSheetBackBtnWidget extends StatelessWidget {
  const CustomSheetBackBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: Get.width / 5,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.secondaryTextColor,
        ),
      ),
    );
  }
}

class CustomBtnWidget extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback action;

  const CustomBtnWidget({
    Key? key,
    required this.color,
    required this.action,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => action(),
        child: Text(
          label,
          style: myTextStyles.subTitle.copyWith(
            color: MyColors.background,
          ),
        ));
  }
}

class CustomCopyBtnWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final IconData topIcon;
  final description;
  final VoidCallback action;
  CustomCopyBtnWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.description,
      required this.action,
      required this.topIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color.withOpacity(0.08),
            ),
            child: FaIcon(
              topIcon,
              size: 20,
              color: MyColors.secondaryTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: myTextStyles.body,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: myTextStyles.subTitle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FaIcon(
                    icon,
                    size: 17,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

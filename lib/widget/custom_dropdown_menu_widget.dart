import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDownMenu extends StatefulWidget {
  final List<GroupCurency> curences;
  const CustomDropDownMenu({super.key, required this.curences});

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  HomeController homeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.setCurency(widget.curences.first);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(bottom: 0, top: 3, left: 3, right: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyColors.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (homeController.isCurenciesOpen.value)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: widget.curences
                    .map((e) => GestureDetector(
                          onTap: () {
                            homeController.curency.addAll(e.toMap());
                            homeController.isCurenciesOpen.toggle();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 3, left: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.bg),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 5),
                                Text(
                                  e.symbol,
                                  style: myTextStyles.body.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.lessBlackColor,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Container(
                                  width: 1,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: MyColors.secondaryTextColor
                                        .withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  e.name,
                                  style: myTextStyles.body.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.lessBlackColor,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            GestureDetector(
              onTap: () {
                homeController.isCurenciesOpen.toggle();
              },
              child: Container(
                height: 33,
                // width: Get.width / 5,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: const EdgeInsets.only(left: 20, bottom: 20, top: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.bg,
                  // boxShadow: [myShadow.blackShadow]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      homeController.curency['symbol'] ?? "",
                      style: myTextStyles.body.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: MyColors.lessBlackColor,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      width: 1,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: MyColors.secondaryTextColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      homeController.curency['name'] ?? "",
                      style: myTextStyles.body.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: MyColors.lessBlackColor,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

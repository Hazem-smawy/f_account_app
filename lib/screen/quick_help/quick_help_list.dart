import 'package:account_app/utility/curency_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/home_controller.dart';

class JournalListWidget extends StatefulWidget {
  const JournalListWidget({
    super.key,
  });

  @override
  State<JournalListWidget> createState() => _JournalListWidgetState();
}

class _JournalListWidgetState extends State<JournalListWidget> {
  HomeController homeController = Get.find();
  @override
  void initState() {
    super.initState();
    homeController.getTheTodaysJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.todaysJournals.isEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.bg.withOpacity(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 50,
                    color: MyColors.lessBlackColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "لا توجد أي عمليات اليوم",
                    style: MyTextStyles.subTitle,
                  )
                ],
              ))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: homeController.todaysJournals.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: MyColors.bg.withOpacity(0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: homeController.todaysJournals[index]
                                        ['debit'] >
                                    homeController.todaysJournals[index]
                                        ['credit']
                                ? MyColors.creditColor
                                : MyColors.debetColor),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        homeController.todaysJournals[index]['symbol'],
                        style: MyTextStyles.body.copyWith(fontSize: 9),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        width: Get.width / 8,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            GlobalUtitlity.formatNumberDouble(
                                number: (homeController.todaysJournals[index]
                                            ['debit'] -
                                        homeController.todaysJournals[index]
                                            ['credit'])
                                    .abs()),
                            style: MyTextStyles.title2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: Get.width / 6,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    homeController.todaysJournals[index]
                                        ['accName'],
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: MyTextStyles.subTitle.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.folder,
                                size: 12,
                                color: MyColors.secondaryTextColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const Spacer(),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                // width: Get.width / 2.7,
                                child: FittedBox(
                                  child: Text(
                                    homeController.todaysJournals[index]
                                        ['name'],
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: MyTextStyles.subTitle.copyWith(
                                        overflow: TextOverflow.ellipsis),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

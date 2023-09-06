import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/main.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyEntroScreen extends StatefulWidget {
  const MyEntroScreen({super.key});

  @override
  State<MyEntroScreen> createState() => _MyEntroScreenState();
}

class _MyEntroScreenState extends State<MyEntroScreen> {
  List pages = [
    {
      "id": 2,
      "image": "assets/images/intro2.png",
      "title": "العنوان",
      "desc":
          "الله في الإسلام هو الإله الواحد الأحد وهو وصف لغوي للذات الإلهية. وله أسماء تسمى أسماء الله الحسنى وهي أكثر من أن تعد"
    },
    {
      "id": 1,
      "image": "assets/images/intro3.png",
      "title": "العنوان",
      "desc":
          "الله في الإسلام هو الإله الواحد الأحد وهو وصف لغوي للذات الإلهية. وله أسماء تسمى أسماء الله الحسنى وهي أكثر من أن تعد"
    },
    {
      "id": 0,
      "image": "assets/images/intro4.png",
      "title": "العنوان",
      "desc": ". أكثر من أن تعد إغلاق التطبيق"
    },
  ];
  int i = 0;

  final controller = PageController();
  IntroController introController = Get.find();

  //drive

  CopyController copyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lessBlackColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  onPageChanged: (value) {
                    setState(() {
                      i = value;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index == pages.length - 1)
                          Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.bounceInOut,
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      top: 20,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "رجوع",
                                          style: myTextStyles.subTitle,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const FaIcon(
                                          FontAwesomeIcons.arrowRightLong,
                                          color: MyColors.secondaryTextColor,
                                          size: 15,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        FirstPage(
                          lastPage: pages.length - 1 == index,
                          page: pages[index],
                        ),
                        const Spacer(),

                        //TODO: download copy btns
                        if (index == pages.length - 1)
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  introController.updateIntro();
                                  Get.to(() => ShowMyMainScreen());
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        const Color.fromARGB(255, 64, 203, 143)
                                            .withOpacity(0.7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.arrowLeftLong,
                                        size: 18,
                                        color: MyColors.containerColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "الصفحة الرئيسية",
                                        style: myTextStyles.title2.copyWith(
                                          color: MyColors.bg,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetBuilder<CopyController>(
                                      builder: (controller) {
                                    return GestureDetector(
                                      onTap: () async {
                                        try {
                                          final res =
                                              await controller.getTheLastFile();

                                          if (res != null) {
                                            await introController
                                                .updateIntro()
                                                .then((value) {
                                              Get.offAll(
                                                  () => ShowMyMainScreen());
                                            });
                                          } else {
                                            CustomDialog.customSnackBar(
                                                "حدث خطأ عند إستعادة النسخة",
                                                SnackPosition.TOP);
                                          }
                                        } catch (e) {
                                          CustomDialog.customSnackBar(
                                              "حدث خطأ عند إستعادة النسخة",
                                              SnackPosition.TOP);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color:
                                                  MyColors.secondaryTextColor,
                                            )),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.googleDrive,
                                              size: 15,
                                              color: MyColors.containerColor,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                        await copyController
                                            .requestPermission();
                                        final result = await copyController
                                            .openDatabaseFile();
                                        if (result == true) {
                                          await introController
                                              .updateIntro()
                                              .then((value) {
                                            Get.offAll(
                                                () => ShowMyMainScreen());
                                          });
                                        } else {
                                          CustomDialog.customSnackBar(
                                              "حدث خطأ عند إستعادة النسخة",
                                              SnackPosition.TOP);
                                        }
                                      } catch (e) {
                                        CustomDialog.customSnackBar(
                                            "حدث خطأ عند إستعادة النسخة",
                                            SnackPosition.TOP);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: MyColors.secondaryTextColor,
                                          )),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.solidFolderClosed,
                                            size: 15,
                                            color: MyColors.containerColor,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (i == pages.length - 1)
                          const SizedBox(
                            height: 100,
                          ),
                      ],
                    );
                  }),
            ),
            if (i != pages.length - 1)
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MyColors.secondaryTextColor),
                            shape: BoxShape.circle),
                        child: const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: pages
                              .map(
                                (e) => AnimatedContainer(
                                  duration: const Duration(microseconds: 200),
                                  margin: const EdgeInsets.only(left: 5),
                                  width: e['id'] == i ? 15 : 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: e['id'] == i
                                        ? const Color.fromARGB(
                                            255, 88, 223, 162)
                                        : Colors.white,
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MyColors.secondaryTextColor),
                            shape: BoxShape.circle),
                        child: const FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  final page;
  FirstPage({super.key, required this.page, required this.lastPage});
  bool lastPage;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          SizedBox(
            height: Get.height / 8,
          ),
          //if (lastPage)
          Image.asset(
            page['image'],
            width: lastPage ? Get.width : Get.width - 100,
            //  height: lastPage ? Get.width / 5 : null,
            fit: BoxFit.cover,
          ),

          SizedBox(
            height: lastPage ? 30 : Get.height / 9,
          ),
          // if (!lastPage)
          Text(
            page['title'],
            style: myTextStyles.title2.copyWith(
              color: MyColors.containerColor,
              fontWeight: FontWeight.normal,
              fontSize: 23,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (!lastPage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                page['desc'],
                textAlign: TextAlign.center,
                style: myTextStyles.body.copyWith(
                  color: MyColors.containerSecondColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

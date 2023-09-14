import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/screen/home/home_row.dart';
import 'package:account_app/screen/home/summary_item_widget.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:account_app/constant/colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final AccGroup accGroup;
  bool stauts;
  Curency? curency;
  List? rows;

  HomeScreen(
      {super.key,
      required this.accGroup,
      required this.stauts,
      required this.curency,
      required this.rows});
  HomeController homeController = Get.find();

  CurencyController curencyController = Get.find();

  CustomerAccountController customerAccountController = Get.find();
  double onYou = 0.0;
  double forYou = 0.0;

  void calculateResultMoneyForYou() {
    onYou = 0.0;
    forYou = 0.0;
    rows?.forEach((e) {
      double res = e.totalCredit - e.totalDebit;

      if (res > 0) {
        onYou += res;
      } else {
        forYou += res;
      }
    });
    onYou = onYou;
    forYou = forYou < 0 ? forYou * -1 : forYou * 1;
  }

  @override
  Widget build(BuildContext context) {
    calculateResultMoneyForYou();
    return curency != null
        ? Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: rows != null
                  ? HomePrivateSammaryWidget(
                      forYou: forYou,
                      onYou: onYou,
                      curency: curency ??
                          Curency(
                            name: "",
                            symbol: "",
                            status: true,
                            createdAt: DateTime.now(),
                            modifiedAt: DateTime.now(),
                          ),
                    )
                  : const SizedBox(),
            ),

            Expanded(
              child: rows != null
                  ? ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 30, right: 20, left: 20, top: 10),
                      itemCount: rows?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeRowView(
                          homeModel: rows?[index],
                          status: stauts,
                        );
                      },
                    )
                  : SizedBox(child: PlaceHolderWidget()),
            ),

            // curency menu
            if (curency != null)
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, left: 5, top: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.bg,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          curency?.symbol ?? " ",
                          style: MyTextStyles.body.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: MyColors.lessBlackColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 1,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: MyColors.secondaryTextColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          curency?.name ?? "",
                          style: MyTextStyles.body.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: MyColors.lessBlackColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),

            // end curency menu
          ])
        : PlaceHolderWidget();
  }
}

class HomePrivateSammaryWidget extends StatelessWidget {
  final double onYou;
  final double forYou;
  final Curency curency;
  const HomePrivateSammaryWidget({
    super.key,
    required this.onYou,
    required this.forYou,
    required this.curency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HomeSammaryWidget(
          curency: curency,
          icon: FontAwesomeIcons.angleDown,
          title: "$forYou ",
          subTitle: " لك",
          color: MyColors.creditColor,
        ),
        const SizedBox(
          width: 10,
        ),
        HomeSammaryWidget(
          curency: curency,
          icon: FontAwesomeIcons.angleUp,
          title: "$onYou ",
          subTitle: "عليك",
          color: MyColors.debetColor,
        )
      ],
    );
  }
}

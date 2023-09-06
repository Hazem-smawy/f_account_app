import 'package:get/get.dart';

class Responsive extends GetxController {
  static  bool isMobile = true;
  static late double iconSize;
  static late double space;
  static late double myPadding;

  @override
  void onInit() {
    isMobile = true;
    if (Get.width > 700) {
      isMobile = false;
      iconSize = 25;
      space = 20;
      myPadding = 30;
    } else {
      isMobile = true;
      iconSize = 20;
      space = 10;
      myPadding = 20;
    }
    super.onInit();
  }
}

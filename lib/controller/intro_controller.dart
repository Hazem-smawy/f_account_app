import 'package:account_app/service/database/intro_data.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final introShow = false.obs;
  IntroData introData = IntroData();

  @override
  void onInit() {
    super.onInit();
    createIntro();
    readIntro();
  }

  Future<void> createIntro() async {
    await introData.create();
  }

  Future<bool> readIntro() async {
    introShow.value = await introData.read();

    return introShow.value;
  }

  Future<void> updateIntro() async {
    await introData.update();
    update();
  }
}

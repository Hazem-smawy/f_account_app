import 'package:account_app/controller/detail_controller.dart';
import 'package:account_app/controller/image_controller.dart';
import 'package:account_app/controller/sitting_controller.dart';
import 'package:get/get.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/controller/personal_controller.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    intializedApp();
  }

  Future<void> intializedApp() async {
    Get.put(DetailController());
    Get.put(IntroController());
    Get.put(AccGroupCurencyController());
    Get.put(CustomerController());
    Get.put(AccGroupController());
    Get.put(CurencyController());
    Get.put(JournalController());
    Get.put(CustomerAccountController());

    Get.put(HomeController());
    Get.put(NewAccountController());

    Get.put(PersonalController());

    Get.put(CopyController());
    Get.put(SittingController());
    Get.put(ImageController());
  }
}

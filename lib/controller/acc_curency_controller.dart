import 'package:account_app/models/acc_and_cur_model.dart';
import 'package:account_app/service/database/home_data.dart';
import 'package:get/get.dart';

class AccGroupCurencyController extends GetxController {
  var allAccgroupsAndCurency = <AccCurencyModel>[].obs;
  HomeData homeData = HomeData();
  var pageViewCount = 0.obs;
  var homeReportShow = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllAccGroupAndCurency();
  }

  Future<void> getAllAccGroupAndCurency() async {
    allAccgroupsAndCurency.value = await homeData.getAccGroupsAndCurencies();
  }
}

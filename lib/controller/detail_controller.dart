import 'package:account_app/service/database/details_data.dart';
import 'package:get/get.dart';

import '../widget/custom_dialog.dart';

class DetailController extends GetxController {
  RxList allDetails = [].obs;
  DetailData detailData = DetailData();
  @override
  void onInit() {
    super.onInit();
    readAll();
  }

  Future<void> readAll() async {
    allDetails.value = await detailData.readAll() ?? [];
  }

  Future<void> create(String details) async {
    try {
      await detailData.create(details);
      await readAll();
    } catch (e) {
      // CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
    }
  }
}

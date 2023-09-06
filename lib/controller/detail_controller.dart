import 'package:account_app/service/database/details_data.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  RxList allDetails = [].obs;
  DetailData detailData = DetailData();
  @override
  void onInit() {
    // TODO: implement onInit
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
      print(e);
    }
  }
}

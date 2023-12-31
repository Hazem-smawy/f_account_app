import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/service/database/accgroup_data.dart';
import 'package:get/get.dart';

import '../service/database/sitting_data.dart';

class AccGroupController extends GetxController {
  AccGroupData accGroupData = AccGroupData();
  AccGroupCurencyController accGroupCurencyController = Get.find();
  final allAccGroups = <AccGroup>[].obs;
  final newAccGroup = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */
  @override
  void onInit() {
    readAllAccGroup();
    super.onInit();
  }

  Future<void> crFike() async {
    final a = AccGroup(
        id: 2,
        name: "الموضفين",
        status: true,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now());
    accGroupData.create(a);
    readAllAccGroup();
  }

  Future<void> readAllAccGroup() async {
    allAccGroups.value = await accGroupData.readAllAccGroups();
    await accGroupCurencyController.getAllAccGroupAndCurency();
  }

  Future<void> createAccGroup(AccGroup accGroup) async {
    await accGroupData.create(accGroup);
    await readAllAccGroup();
    SittingData sittingData = SittingData();
    await sittingData.updateNewData(1);
  }

  Future<void> updateAccGroup(AccGroup accGroup) async {
    accGroupData.updateAccGroup(accGroup);
    await readAllAccGroup();
    SittingData sittingData = SittingData();
    await sittingData.updateNewData(1);
  }

  Future<void> deleteAccGroup(int id) async {
    await accGroupData.delete(id);
    await accGroupCurencyController.getAllAccGroupAndCurency();
    await readAllAccGroup();
  }
}

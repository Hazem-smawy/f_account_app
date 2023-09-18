import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/service/database/accgroup_data.dart';
import 'package:get/get.dart';

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
    accGroupData.create(accGroup);
    readAllAccGroup();
  }

  Future<void> updateAccGroup(AccGroup accGroup) async {
    accGroupData.updateAccGroup(accGroup);
    readAllAccGroup();
  }

  Future<void> deleteAccGroup(int id) async {
    await accGroupData.delete(id);
    await accGroupCurencyController.getAllAccGroupAndCurency();
    await readAllAccGroup();
  }
}

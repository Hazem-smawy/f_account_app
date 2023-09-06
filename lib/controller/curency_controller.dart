import 'package:account_app/models/curency_model.dart';
import 'package:account_app/service/database/curency_data.dart';
import 'package:get/get.dart';

class CurencyController extends GetxController {
  CurencyData curencyData = CurencyData();
  final allCurency = <Curency>[].obs;
  final newCurency = {}.obs;
  final editCurency = {}.obs;
  final selectedCurency = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */
  @override
  void onInit() {
    readAllCurency();

    super.onInit();
  }

  Future<List<Curency>> readAllCurency() async {
    allCurency.value = await curencyData.readAllCurencies();
    allCurency.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
    if (allCurency.isNotEmpty) {
      selectedCurency.addAll(allCurency.last.toEditMap());
    }

    return allCurency;
  }

  Future<void> createCurency(Curency curency) async {
    curencyData.create(curency);
    readAllCurency();
  }

  Future<void> updateCurency(Curency curency) async {
    curencyData.updateCurency(curency);
    readAllCurency();
  }

  Future<void> deleteCurency(int id) async {
    curencyData.delete(id);
    readAllCurency();
  }
}

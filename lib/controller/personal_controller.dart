import 'package:account_app/models/personal_model.dart';
import 'package:account_app/service/database/personal_data.dart';
import 'package:get/get.dart';

class PersonalController extends GetxController {
  PersonalData personalData = PersonalData();
  var newPersonal = {}.obs;
  @override
  void onInit() {
    super.onInit();
    getPersonal();
  }

  Future<PersonalModel?> getPersonal() async {
    PersonalModel? newPer = await personalData.readPersonal();
    newPersonal.addAll(newPer?.toMap() ?? {});
    return newPer;
  }

  Future<void> createPersona(PersonalModel personalModel) async {
    personalData.create(personalModel);
  }

  Future<void> updatePersonal(PersonalModel persoanl) async {
    personalData.updatePersonal(persoanl);
  }
}

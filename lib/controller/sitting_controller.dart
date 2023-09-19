import 'dart:async';

import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/models/sitting_model.dart';
import 'package:account_app/service/database/sitting_data.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:get/get.dart';

import '../widget/custom_dialog.dart';

class SittingController extends GetxController {
  final every = 0.obs;
  final everyArray = [1, 2, 7, 30];
  final toggleAsyncGoogleDrive = false.obs;
  CopyController copyController = Get.find();
  SittingData sittingData = SittingData();
  final newData = true.obs;

  @override
  void onInit() {
    super.onInit();
    readSitting();
    // toogleIsCopyOn(toggleAsyncGoogleDrive.value);
  }

  Future<SittingModel?> createSitting() async {
    var sittingModel =
        SittingModel(id: 1, every: 0, isCopyOn: false, newData: false);
    try {
      var res = await sittingData.create(sittingModel);
      return res;
    } catch (e) {
      // CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<void> readSitting() async {
    var res = await sittingData.read(1);

    if (res == null) {
      res = await createSitting();
      every.value = res?.every ?? 0;
      toggleAsyncGoogleDrive.value = res?.isCopyOn ?? false;
    } else {
      every.value = res.every;
      toggleAsyncGoogleDrive.value = res.isCopyOn;
    }
  }

  Future<void> updateSitting(bool isCopyOn, int every) async {
    var sittingModel = SittingModel(
        id: 1, every: every, isCopyOn: isCopyOn, newData: newData.value);

    await sittingData.update(sittingModel);
  }

  Future<void> deleteSitting() async {
    await sittingData.delete(1);
  }

  Future<void> toogleIsCopyOn(bool isOn) async {
    toggleAsyncGoogleDrive.value = isOn;
    await updateSitting(toggleAsyncGoogleDrive.value, every.value);

    if (isOn) {
      BackgroundFetch.start().then((int status) {}).catchError((e) {
        CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM, false);
      });
    } else {
      BackgroundFetch.stop();
    }
  }

  Future<void> setEvery() async {
    await updateSitting(toggleAsyncGoogleDrive.value, every.value);
    //setCopyToGoogleDriveEvery();
  }

  // Future<void> increemint() async {
  //   if (every < everyArray.length - 1) {
  //     every.value++;

  //     await updateSitting(toggleAsyncGoogleDrive.value, every.value);
  //     FlutterBackgroundService().invoke("stopService");
  //     Future.delayed(const Duration(seconds: 3)).then(
  //       (value) {
  //         toogleIsCopyOn(toggleAsyncGoogleDrive.value);
  //       },
  //     );
  //   }
  // }

  // Future<void> decreemint() async {
  //   if (every > 0) {
  //     every.value--;

  //     await updateSitting(toggleAsyncGoogleDrive.value, every.value);
  //     FlutterBackgroundService().invoke("stopService");
  //     Future.delayed(const Duration(seconds: 3)).then(
  //       (value) {
  //         toogleIsCopyOn(toggleAsyncGoogleDrive.value);
  //       },
  //     );
  //   }
  // }

  // void setCopyToGoogleDriveEvery() {
  //   FlutterBackgroundService().invoke("stopService");
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) {
  //       FlutterBackgroundService().startService();
  //     },
  //   );
  // }
}

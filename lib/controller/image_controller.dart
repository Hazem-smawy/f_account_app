import 'dart:io';
import 'dart:typed_data';

import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/service/database/image_data.dart';
import 'package:account_app/widget/custom_dialog.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageController extends GetxController {
  ImageData imageData = ImageData();
  CopyController copyController = Get.find();
  var customImage = {}.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    readImage();
  }

  Future<void> createImage() async {
    try {
      if (Platform.isAndroid) {
        copyController.requestPermission();
      }
      var status = await Permission.photosAddOnly.status;
      if (status.isDenied) {
        // Here you can open app settings so that the user can give permission
        await openAppSettings();
      }
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        await imageData.create(image: image);
        readImage();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Uint8List?> readImage() async {
    final res = await imageData.read();
    final imageRes = res?['image'];
    final id = res?['id'];

    if (imageRes != null) {
      customImage.update(
        'image',
        (value) => imageRes,
        ifAbsent: () => imageRes,
      );
      customImage.update(
        'id',
        (value) => id,
        ifAbsent: () => id,
      );
    }

    return imageRes;
  }

  Future<void> updateImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null && customImage['id'] != null) {
        CustomDialog.loadingProgress();
        await imageData.update(image: image, id: customImage['id']);
        await readImage();
        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }
}

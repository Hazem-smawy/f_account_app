import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';

class SelectContactController extends GetxController {
  final FlutterContactPicker contactPicker = FlutterContactPicker();
  final customerName = "".obs;
  final customerNumber = "".obs;
  Contact? contact;
}

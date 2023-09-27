import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/select_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widget/custom_dialog.dart';

class SelectContactWidget extends StatelessWidget {
  SelectContactWidget({super.key, required this.action});
  Function(String contactName, String contactNumber) action;

  SelectContactController selectContactController =
      Get.put(SelectContactController());

  Future<void> _askContactPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Contact? contact =
          await selectContactController.contactPicker.selectContact();
      if (contact != null) {
        selectContactController.contact = contact;
        action(contact.fullName ?? "", contact.phoneNumbers?.first ?? "");
        contact.phoneNumbers?.first ?? "";
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  // ignore: unused_element
  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      CustomDialog.customSnackBar('hello', SnackPosition.TOP, true);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      CustomDialog.customSnackBar(
        'Contact data not available on device',
        SnackPosition.TOP,
        true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _askContactPermissions();
      },
      child: Container(
        height: 48,
        //  width: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.lessBlackColor.withOpacity(0.8),
        ),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.addressBook,
            color: MyColors.containerColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}

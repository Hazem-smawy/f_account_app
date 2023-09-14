import 'dart:io' as io;

import 'package:account_app/service/http_service/google_drive_data_auth.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveAppData {
  /// sign in with google
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      drive.DriveApi.driveAppdataScope,
    ],
  );

  Future<GoogleSignInAccount?> getCurentUser() async {
    final user = googleSignIn.currentUser;
    return user;
  }

  Future<GoogleSignInAccount?> signInGoogle() async {
    GoogleSignInAccount? googleUser;
    try {
      googleUser =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
    } catch (e) {
      debugPrint(e.toString());
    }
    return googleUser;
  }

  ///sign out from google
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }

  ///get google drive client
  Future<drive.DriveApi?> getDriveApi(GoogleSignInAccount googleUser) async {
    drive.DriveApi? driveApi;
    try {
      Map<String, String> headers = await googleUser.authHeaders;
      GoogleAuthClient client = GoogleAuthClient(headers);
      driveApi = drive.DriveApi(client);
    } catch (e) {
      debugPrint(e.toString());
    }
    return driveApi;
  }

  /// upload file to google drive
  Future<drive.File?> uploadDriveFile({
    required drive.DriveApi driveApi,
    required io.File file,
    String? driveFileId,
  }) async {
    try {
      drive.File fileMetadata = drive.File();
      fileMetadata.name =
          "account_app_${DateTime.now().millisecondsSinceEpoch}.db";

      late drive.File response;
      if (driveFileId != null) {
        /// [driveFileId] not null means we want to update existing file
        response = await driveApi.files.update(
          fileMetadata,
          driveFileId,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      } else {
        /// [driveFileId] is null means we want to create new file
        fileMetadata.parents = ['appDataFolder'];
        fileMetadata.createdTime = DateTime.now();
        response = await driveApi.files.create(
          fileMetadata,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> deleteDriveFile({
    required drive.DriveApi driveApi,
    required drive.File driveFile,
  }) async {
    try {
      await driveApi.files.delete(driveFile.id!);
    } catch (e) {
      CustomDialog.customSnackBar("حدث خطأ", SnackPosition.BOTTOM);
    }
  }

  /// download file from google drive
  Future<io.File?> restoreDriveFile({
    required drive.DriveApi driveApi,
    required drive.File driveFile,
    required String targetLocalPath,
  }) async {
    try {
      drive.Media media = await driveApi.files.get(driveFile.id!,
          downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      List<int> dataStore = [];

      await media.stream.forEach((element) {
        dataStore.addAll(element);
      });

      io.File file = io.File(targetLocalPath);
      file.writeAsBytesSync(dataStore);

      return file;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// get drive file info
  Future<drive.File?> getDriveFile(
      drive.DriveApi driveApi, String filename) async {
    try {
      drive.FileList fileList = await driveApi.files.list(
          spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
      List<drive.File>? files = fileList.files;
      drive.File? driveFile =
          files?.firstWhere((element) => element.name == filename);
      return driveFile;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// get drive file info
  Future<List<drive.File>?> getAllDriveFiles(drive.DriveApi driveApi) async {
    try {
      drive.FileList fileList = await driveApi.files.list(
          spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
      List<drive.File>? files = fileList.files;
      files = files
          ?.where((element) => element.name?.contains("account_app") ?? false)
          .toList();
      // drive.File? driveFile =
      //     files?.firstWhere((element) => element.name == filename);
      return files;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

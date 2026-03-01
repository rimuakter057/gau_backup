import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/features/complain/models/create_complain_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ComplainController extends GetxController {
  RxBool inProgressCreateComplain = false.obs;
  Rx<CreateComplainModel?> createdComplain = Rx<CreateComplainModel?>(null);
  RxList<File> attachmentFiles = <File>[].obs;

  //============================= PICK IMAGE =================================
  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    final picked = await ImagePicker().pickImage(source: source, imageQuality: 80);
    if (picked != null) attachmentFiles.add(File(picked.path));
  }

  //============================= PICK FILE (PDF etc.) =======================
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
      allowMultiple: true,
    );
    if (result != null) {
      for (var file in result.files) {
        if (file.path != null) attachmentFiles.add(File(file.path!));
      }
    }
  }

  //============================= REMOVE ATTACHMENT ==========================
  void removeAttachment(int index) => attachmentFiles.removeAt(index);

  //============================= CREATE COMPLAIN ============================
  Future<bool> createComplain({
    required String category,
    required String priority,
    required String subject,
    required String description,
  }) async {
    inProgressCreateComplain.value = true;

    final response = await ApiClient.postMultipartData(
      ApiUrl.createComplain,
      {
        "category": category,
        "priority": priority,
        "subject": subject,
        "description": description,
      },
      multipartBody: attachmentFiles
          .map((file) => MultipartBody( "attachments",  file))
          .toList(),
    );

    inProgressCreateComplain.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      createdComplain.value = CreateComplainModel.fromJson(
        response.body['data'] ?? response.body,
      );
      attachmentFiles.clear();
      return true;
    }

    Get.snackbar(
      'Error',
      response.body['message'] ?? 'Failed to create complain',
      snackPosition: SnackPosition.BOTTOM,
    );
    return false;
  }
}






// ///otp verification================================================
// RxBool inProgressVerification = false.obs;
// Future<bool> verifyOtp({required String email, required int otp}) async {
//   inProgressVerification.value = true;
//   final Response response = await ApiClient.postData(ApiUrl.verifyOtp, {
//     "email": email,
//     "resetCode": otp,
//   });
//
//   inProgressVerification.value = false;
//
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     errorMessage.value = response.body?["message"] ?? "email does not exit";
//     return false;
//   }
// }

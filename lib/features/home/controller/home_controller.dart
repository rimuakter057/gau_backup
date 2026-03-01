import 'package:flutter/cupertino.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/features/complain/models/create_complain_model.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../core/service/datasource/remote/api_client.dart';

class HomeController extends GetxController {




  RxnString selectedCategory = RxnString();
  RxnString selectedPriority = RxnString();

  void setCategory(String value) {
    selectedCategory.value = value;
  }

  void setPriority(String value) {
    selectedPriority.value = value;
  }









  var selectedFile = Rx<File?>(null);

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'doc'],
      withData: true,
    );

    if (result == null) return;

    final file = result.files.first;

    // Size check (5 MB)
    final fileSizeInMB = file.size / (1024 * 1024);
    if (fileSizeInMB > 5) {
      Get.snackbar('Error', 'File size must be under 5 MB');
      return;
    }

    selectedFile.value = File(file.path!);
  }






  // ================= Create Complain =================

  RxBool inProgressCreateComplain = false.obs;
  Rx<CreateComplainModel?> createdComplain =
  Rx<CreateComplainModel?>(null);

  Future<bool> createComplain({
    required String subject,
    required String description,
    required BuildContext context
  }) async {

    if (selectedCategory.value == null ||
        selectedPriority.value == null) {

      CustomSnackbar.error(context, "Please select category and priority");
      return false;
    }

    inProgressCreateComplain.value = true;

    try {
      final response = await ApiClient.postMultipartData(
        ApiUrl.createComplain,
        {
          "category": selectedCategory.value!,
          "priority": selectedPriority.value!,
          "subject": subject,
          "description": description,
        },
        multipartBody: selectedFile.value != null
            ? [MultipartBody("attachments", selectedFile.value!)]
            : [],
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        createdComplain.value = CreateComplainModel.fromJson(
          response.body['data'] ?? response.body,
        );

        // Reset after success
        selectedFile.value = null;
        selectedCategory.value = null;
        selectedPriority.value = null;

        return true;
      }



      CustomSnackbar.error(context,     response.body['message'] ??
          'Failed to create complain',);
      return false;

    } finally {
      inProgressCreateComplain.value = false;
    }
  }


}
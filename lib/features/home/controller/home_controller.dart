import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class HomeController extends GetxController {
  // var selectedCategory = ''.obs;
  // var priorityLevel = ''.obs;
  // var subject = ''.obs;
  // var description = ''.obs;



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


}
import 'package:flutter/cupertino.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/features/complain/models/complain_model.dart';
import 'package:gau_app/features/complain/models/create_complain_model.dart';
import 'package:gau_app/features/home/models/academic_progress_model.dart';
import 'package:gau_app/features/home/models/upcoming_deadline_model.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../core/service/datasource/remote/api_client.dart';

class HomeController extends GetxController {


  ///get all complain==============================================

  var complaintsList = <ComplainModel>[].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var currentPage = 1.obs;
  var hasMore = true.obs;

  final int limit = 10;
  var status = "".obs;



  // ================== fetch complaints ==================
// ================== fetch complaints ==================
  Future<void> fetchAllComplaints({
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      currentPage.value = 1;   // ✅ reset to page 1
      complaintsList.clear();  // ✅ পুরনো data clear
      hasMore.value = true;
    }

    if (!hasMore.value) return;

    try {
      isLoading.value = currentPage.value == 1;
      isMoreLoading.value = currentPage.value > 1;

      final uri = ApiUrl.getAllComplain(
        status: status.value.isEmpty ? AppText.pendingServer : status.value,
        page: currentPage.value,
        limit: limit,
      );

      final response = await ApiClient.getData(uri);

      if (response.statusCode == 200) {
        List data = response.body['data'] ?? [];
        final list = data.map((e) => ComplainModel.fromJson(e)).toList();

        complaintsList.addAll(list);

        // ✅ Bug 3 Fix: !isRefresh guard সরানো হয়েছে —
        // refresh হোক বা scroll, fetch সফল হলে সবসময় page increment হবে
        if (list.isNotEmpty) {
          currentPage.value++;
        }

        if (list.length < limit) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

// ================== scroll থেকে load more ==================
  void loadMore() {
    // ✅ isLoading চেক যোগ হয়েছে — initial load চলাকালীন loadMore call হবে না
    if (!isLoading.value && !isMoreLoading.value && hasMore.value) {
      fetchAllComplaints();
    }
  }




  void addComplaint(ComplainModel newComplain) {
    complaintsList.insert(0, newComplain); // list top e add
  }












///add complain






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
  Rx<CreateComplainModel?> createdComplain = Rx<CreateComplainModel?>(null);

  Future<bool> createComplain({
    required String subject,
    required String description,
    required BuildContext context,
  }) async {
    if (selectedCategory.value == null || selectedPriority.value == null) {
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        createdComplain.value = CreateComplainModel.fromJson(
          response.body['data'] ?? response.body,
        );

        // Reset after success
        selectedFile.value = null;
        selectedCategory.value = null;
        selectedPriority.value = null;
      //  fetchAllComplaints();
        return true;

      }

      CustomSnackbar.error(
        context,
        response.body['message'] ?? 'Failed to create complain',
      );
      return false;
    } finally {
      inProgressCreateComplain.value = false;
    }
  }



  // ///get single complain==============================================
  //
  // // Observable list to hold single complaint
  // var complainDetails = <ComplainModel>[].obs;
  //
  // /// Fetch single complaint by ID==================================
  // Future<void> fetchComplainDetails({required String id}) async {
  //   final uri = ApiUrl.getSingleComplain(complainId: id);
  //
  //   final response = await ApiClient.getData(uri);
  //
  //   if (response.statusCode == 200) {
  //     final data = response.body['data'];
  //     if (data != null) {
  //       final complain = ComplainModel.fromJson(data);
  //       complainDetails.clear();
  //       complainDetails.add(complain);
  //     }
  //   } else {
  //     print("Failed to fetch complaint. Status: ${response.statusCode}");
  //   }
  // }

///get single model=================================


  Rxn<ComplainModel> complainDetails = Rxn<ComplainModel>();
  RxBool isDetailsLoading = false.obs;

  Future<void> fetchComplainDetails({required String id}) async {

    isDetailsLoading.value = true;
    complainDetails.value = null;

    final uri = ApiUrl.getSingleComplain(complainId: id);
    final response = await ApiClient.getData(uri);

    if (response.statusCode == 200) {
      final data = response.body['data'];

      if (data != null) {
        complainDetails.value = ComplainModel.fromJson(data);
      }
    }

    isDetailsLoading.value = false;
  }


///fetch upcoming data==================================================


  RxList<UpcomingDeadlineModel> upcomingDeadlines = <UpcomingDeadlineModel>[].obs;
  RxBool isDeadlineLoading = false.obs;

  Future<void> fetchUpcomingDeadlines() async {
    isDeadlineLoading.value = true;

    final response = await ApiClient.getData(ApiUrl.upcomingDeadline);

    if (response.statusCode == 200) {
      List data = response.body['data'] ?? [];


      upcomingDeadlines.value =
          data.map((e) => UpcomingDeadlineModel.fromJson(e)).toList();
    }

    isDeadlineLoading.value = false;
  }

///academic progress===============================================

  /// Academic Progress =====================================================

  Rxn<ProgressModel> academicProgress = Rxn<ProgressModel>();
  RxBool isProgressLoading = false.obs;

  Future<void> fetchAcademicProgress() async {
    isProgressLoading.value = true;

    final response = await ApiClient.getData(ApiUrl.academicProgress);

    if (response.statusCode == 200) {
      final data = response.body['data'];
      if (data != null) {
        academicProgress.value = ProgressModel.fromJson(data);
      }
    }

    isProgressLoading.value = false;
  }






}

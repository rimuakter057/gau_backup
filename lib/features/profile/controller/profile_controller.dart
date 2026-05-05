import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController {
  // Observables
  final RxString name = ''.obs;
  final RxString userId = ''.obs;
  final RxString profileImage = ''.obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.profile); // your endpoint
      if (response.statusCode == 200) {
        final data = response.body['data'];
        name.value         = data['fullName']      ?? '';
        userId.value       = data['studentId']     ?? '';
        profileImage.value = data['profile_image'] ?? '';
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to load profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }
}
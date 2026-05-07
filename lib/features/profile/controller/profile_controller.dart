import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:gau_app/utils/app_const/app_const.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';


class ProfileController extends GetxController {
  // Observables
  final RxString name = ''.obs;
  final RxString userId = ''.obs;
  final RxString profileImage = ''.obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.profile);
      if (response.statusCode == 200) {
        final data = response.body['data'];
        name.value   = data['fullName']  ?? '';
        userId.value = data['studentId'] ?? '';

        final rawImage = data['profile_image'] ?? '';
        profileImage.value = rawImage.isEmpty
            ? ''
            : rawImage.startsWith('http')
            ? rawImage
            : 'https://$rawImage';
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to load profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }








  /// Patch profile picture
  /// Patch profile picture
  Future<void> pickAndUploadImage({required BuildContext context}) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked == null) return;

    isLoading.value = true;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(AppConstants.bearerToken)!;

      final uri = Uri.parse(ApiUrl.baseUrl + ApiUrl.updateProfile);

      // PNG → JPEG convert
      final imageBytes = await picked.readAsBytes();
      final img.Image? decodedImage = img.decodeImage(imageBytes);
      final jpegBytes = img.encodeJpg(decodedImage!, quality: 80);

      final tempDir = await getTemporaryDirectory();
      final jpegFile = File('${tempDir.path}/profile_upload.jpg')
        ..writeAsBytesSync(jpegBytes);

      var request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            jpegFile.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('📥 STATUS CODE: ${response.statusCode}');
      print('📥 RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        await fetchProfile();
        CustomSnackbar.success(context: context, message: 'Profile image updated!');
      } else {
        CustomSnackbar.error(context: context, message: 'Failed to update image');
      }
    } catch (e, stackTrace) {
      print('❌ ERROR: $e');
      print('❌ STACKTRACE: $stackTrace');
      CustomSnackbar.error(context: context, message: 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }


}
import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/helper/shared_prefe/shared_prefe.dart';
import 'package:get/get.dart';
import '../../../utils/app_const/app_const.dart';

class AuthController extends GetxController {

  RxBool inProgress = false.obs;
  RxString errorMessage = ''.obs;

  Future<bool> login({required String email, required String password}) async {
    inProgress.value = true;

    final Response response = await ApiClient.postData(
      ApiUrl.login,
      {
        "email": email,
        "password": password,
      },
    );

    inProgress.value = false;

    if (response.statusCode == 200) {
      final data = response.body;

      // ✅ Save token
      await SharePrefsHelper.setString(
        AppConstants.bearerToken,
        data['data']['accessToken'], // token thik path
      );

      return true;
    } else {
      // ✅ Properly set RxString
      final msg = response.body['message'] ?? 'Something went wrong';
      errorMessage.value = msg;

      return false;
    }
  }


  }















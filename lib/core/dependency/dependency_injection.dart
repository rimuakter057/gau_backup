

import 'package:gau_app/features/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    //Get.put(NetworkCaller());

    //Get.put(AuthController());

    //auth================================
    // Get.lazyPut(() => SignUpController(), fenix: true);
    // Get.lazyPut(() => LogInController(), fenix: true);
    // Get.lazyPut(() => VerifyAccountOtpController(), fenix: true);
    // Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    // Get.lazyPut(() => VerifyIdentityOtpController(), fenix: true);
    // Get.lazyPut(() => ResetPasswordController(), fenix: true);
    // Get.lazyPut(() => ResendOtpController(), fenix: true);
    // Get.lazyPut(() => UserResendOtpController(), fenix: true);
    // Get.lazyPut(() => ChangePasswordController(), fenix: true);

    ///==========================Community section==================

    //Get.lazyPut(() => AddPostController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);


  }
}

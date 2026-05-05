import 'package:gau_app/features/auth/controller/auth_controller.dart';
import 'package:gau_app/features/chat/controller/chat_controller.dart';
import 'package:gau_app/features/grade/controller/semistar_controller.dart';
import 'package:gau_app/features/home/controller/home_controller.dart';
import 'package:gau_app/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => AuthController(), fenix: true);

    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => SemistarController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);


  }
}
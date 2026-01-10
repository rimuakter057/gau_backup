import 'package:get/get.dart';

class NavController extends GetxController {
  ///user nav
 var currentIndex = 0.obs;
  void changeIndex(int index) {
    currentIndex.value = index;
  }
  ///seller nav
 var currentIndexSeller= 0.obs;
  void changeIndexSeller(int index) {
    currentIndexSeller.value = index;
  }

}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:gau_app/core/di/injection.dart';
// import 'package:gau_app/core/router/route_path.dart';
// import 'package:gau_app/features/common/controller/main_nav_controller.dart';
//
// import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
// import 'package:gau_app/utils/app_assets/app_assets.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
//
// class MainNavBar extends StatelessWidget {
//   final Widget child;
//
//   MainNavBar({super.key, required this.child});
//
//   final NavController navController = sl<NavController>();
//
//   final List<String> routes = [
//     RoutePath.homeScreen.addBasePath,
//     RoutePath.cartScreen.addBasePath,
//     RoutePath.productScreen.addBasePath,
//     RoutePath.chatScreen.addBasePath,
//     RoutePath.orderScreen.addBasePath,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         body: child,
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: AppColors.backgroundColor,
//           type: BottomNavigationBarType.fixed,
//           currentIndex: navController.currentIndex.value,
//
//           selectedItemColor: AppColors.white,
//           unselectedItemColor: AppColors.navUnselectedColor,
//
//           selectedLabelStyle: context.bodySmall.copyWith(
//             color: AppColors.white,
//           ),
//
//           unselectedLabelStyle: context.bodySmall.copyWith(
//             color: AppColors.navUnselectedColor,
//           ),
//
//           onTap: (index) {
//             navController.changeIndex(index);
//             context.go(routes[index]);
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: CustomImage(
//                 imageSrc: AppAssets.homeNav,
//                 height: 24.h,
//                 width: 24.w,
//                 imageColor: navController.currentIndex.value == 0
//                     ? AppColors.white
//                     : AppColors.navUnselectedColor,
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: CustomImage(
//                 imageSrc: AppAssets.cartNav,
//                 height: 24.h,
//                 width: 24.w,
//                 imageColor: navController.currentIndex.value == 1
//                     ? AppColors.white
//                     : AppColors.navUnselectedColor,
//               ),
//               label: 'Cart',
//             ),
//             BottomNavigationBarItem(
//               icon: CustomImage(
//                 imageSrc: AppAssets.productNav,
//                 height: 24.h,
//                 width: 24.w,
//                 imageColor: navController.currentIndex.value == 2
//                     ? AppColors.white
//                     : AppColors.navUnselectedColor,
//               ),
//               label: 'Product',
//             ),
//             BottomNavigationBarItem(
//               icon: CustomImage(
//                 imageSrc: AppAssets.chatNav,
//                 height: 24.h,
//                 width: 24.w,
//                 imageColor: navController.currentIndex.value == 3
//                     ? AppColors.white
//                     : AppColors.navUnselectedColor,
//               ),
//               label: 'Chat',
//             ),
//             BottomNavigationBarItem(
//               icon: CustomImage(
//                 imageSrc: AppAssets.orderNav,
//                 height: 24.h,
//                 width: 24.w,
//                 imageColor: navController.currentIndex.value == 4
//                     ? AppColors.white
//                     : AppColors.navUnselectedColor,
//               ),
//               label: 'Order',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

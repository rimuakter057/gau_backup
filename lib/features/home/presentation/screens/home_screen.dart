// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gau_app/core/router/route_path.dart';
// import 'package:gau_app/core/router/routes.dart';
// import 'package:gau_app/features/common/auth/presentation/widgets/title_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/add_to_cart_button_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/home_app_bar.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/home_category_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/home_product_card_widget.dart';
// import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
// import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
// import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
// import 'package:gau_app/share/widgets/custom_search_bar/custom_search_bar.dart';
// import 'package:gau_app/utils/app_assets/app_assets.dart';
// import 'package:gau_app/utils/app_const/app_const.dart';
// import 'package:gau_app/utils/app_text/app_text.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/config/app_config.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     final width = MediaQuery.of(context).size.width;
//     print('width===============================$width');
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: HomeAppBar(
//         profileName: "user",
//         profileSubtitle: "Great Falls, Marylan",
//
//         onNotificationTap: (){
//           context.pushNamed(RoutePath.notificationScreen);
//         },
//
//         onDrawerTap: () {
//           _scaffoldKey.currentState?.openEndDrawer();
//         },
//       ),
//       endDrawer: Drawer(
//         backgroundColor: AppColors.drawerBgColor,
//
//
//
//         child: _buildDrawer(context),
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomSearchBar(),
//               SizedBox(height: 16.h),
//               TitleWidget(title: AppText.selectCategory),
//               SizedBox(height: 16.h),
//               ///select category=======================================================
//               SizedBox(
//                 height:40.h,
//
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return         Padding(
//                       padding: const EdgeInsets.symmetric(horizontal:4),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: AppColors.buttonGradient,
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(Icons.directions_run, color: Colors.white, size: 20),
//                             SizedBox(width: 8),
//                             Text(
//                               "Shoes",
//                               style: TextStyle(color: Colors.white, fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               SizedBox(height: 16.h),
//
//               ///brand category=======================================================
//               TitleWidget(title: AppText.selectBrand),
//               SizedBox(height: 8.h),
//               ///category home================================================
//               HomeCategoryWidget(image:AppConstant.unknown, name: 'Starbucks',),
//
//               SizedBox(height: 16.h),
//               _buildHomeTitle(context, title: AppText.exclusive,
//               onTap: (){
//
//                   context.pushNamed(RoutePath.exclusiveProductScreen);}
//
//               ),
//               SizedBox(height: 8.h),
//
//               ///exclusive=======================
//               SizedBox(
//                 height:
//                     (width == 360)
//                         ? 290.h
//                         : (width > 360)
//                         ? 210.h
//                         : 220.h,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return HomeProductCardWidget();
//                   },
//                 ),
//               ),
//
//               SizedBox(height: 24.h),
//
//               _buildHomeTitle(context, title: AppText.featureProduct,
//                   onTap: (){
//
//                     context.pushNamed(RoutePath.featureProductScreen);}
//               ),
//               SizedBox(height: 8.h),
//
//               ///featureProduct=======================
//               SizedBox(
//                 height:
//                     (width == 360)
//                         ? 290.h
//                         : (width > 360)
//                         ? 210.h
//                         : 220.h,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return HomeProductCardWidget();
//                   },
//                 ),
//               ),
//
//               SizedBox(height: 24.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// ///drawer==================================================
//   Column _buildDrawer(BuildContext context) {
//     return Column(
//         crossAxisAlignment:CrossAxisAlignment.start,
//         children: [
//
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               height: 150.h,
//               child: DrawerHeader(
//
//                 margin: EdgeInsets.zero,
//                 padding: EdgeInsets.zero,
//                 child:CustomImage(imageSrc: AppAssets.appLogoImage)
//               ),
//             ),
//           ),
//
//           const CustomDivider(
//             color: AppColors.dividerColor,
//           ),
//
//
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildDrawerTitle(context, title: AppText.myOrder, onTap: () {
//                   context.pushNamed(RoutePath.orderScreen);
//                 }),
//                 SizedBox(height: 16.h,),
//                 _buildDrawerTitle(context, title: AppText.privacyPolicy, onTap: () {
//                   context.pushNamed(RoutePath.privacyPolicyScreen);
//                 }),
//                 SizedBox(height: 16.h,),
//                 _buildDrawerTitle(context, title: AppText.termsAndConditions, onTap: () {
//                   context.pushNamed(RoutePath.termsOfConditionScreen);
//                 }),
//                 SizedBox(height: 16.h,),
//                 _buildDrawerTitle(context, title: AppText.profile, onTap: () {
//                   context.pushNamed(RoutePath.profileScreen);
//                 }),
//               ],
//             ),
//           ),
//         ],);
//   }
// ///drawer title=============================================================================
//   GestureDetector _buildDrawerTitle(BuildContext context,{required String title,required VoidCallback onTap}) {
//     return GestureDetector(
//               onTap: onTap,
//               child: Text(title,style: context.titleLarge,));
//   }
//
//
//
//   ///home title=============================================================================
//
//   Row _buildHomeTitle(
//     BuildContext context, {
//     required String title,
//     VoidCallback? onTap,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: context.titleLarge),
//         GestureDetector(
//           onTap: onTap,
//           child: Text(
//             AppText.viewAll,
//             style: TextStyle(
//               fontFamily: AppConfig.questrial,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.white,
//               decoration: TextDecoration.underline,
//               decorationColor: AppColors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gau_app/features/common/auth/presentation/widgets/title_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/add_to_cart_button_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/home_category_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/home_product_card_widget.dart';
//
//
// import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
// import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
// import 'package:gau_app/share/widgets/custom_search_bar/custom_search_bar.dart';
// import 'package:gau_app/utils/app_assets/app_assets.dart';
// import 'package:gau_app/utils/app_const/app_const.dart';
// import 'package:gau_app/utils/app_text/app_text.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
//
//
//
//
// class FeatureProductScreen extends StatelessWidget {
//   const FeatureProductScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.of(context).size.width;
//     print(MediaQuery.of(context).size.width );
//     return Scaffold(
//
//       appBar: CustomAppBar(title: AppText.featureProducts),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomSearchBar(),
//               SizedBox(height: 16.h),
//               ///select category=======================================================
//               TitleWidget(title: AppText.selectCategory),
//               SizedBox(height: 8.h),
//
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
//               SizedBox(height: 16.h,),
//               ///select brand=======================================================
//               TitleWidget(title: AppText.selectBrand),
//               SizedBox(height: 8.h,),
//               ///category home================================================
//               HomeCategoryWidget(image:AppConstant.unknown, name: 'Starbucks',),
//               SizedBox(height: 4.h),
//               TitleWidget(title: AppText.exclusive),
//               ///product home card======================================
//
//
//               GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 4,
//                   crossAxisSpacing: 4,
//                   childAspectRatio: (width == 360)
//                       ? 0.78
//                       : (width > 360)
//                       ? 0.78
//                       : 0.88,
//                 ),
//                 itemBuilder: (context, index) {
//                   return HomeProductCardWidget();
//                 },
//               ),
//
//               TitleWidget(title: AppText.featureProduct),
//
//
//             ],),
//         ),
//       ),
//
//     );
//   }
// }
//

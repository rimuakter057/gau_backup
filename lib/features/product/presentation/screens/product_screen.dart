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
// class ProductScreen extends StatelessWidget {
//   const ProductScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.of(context).size.width;
//     print(MediaQuery.of(context).size.width );
//     return Scaffold(
//
//       appBar: CustomAppBar(title: AppText.allChats),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomSearchBar(),
//               SizedBox(height: 16.h,),
//               TitleWidget(title: AppText.selectCategory),
//               ///category home================================================
//               HomeCategoryWidget(image:AppConstant.unknown, name: 'Starbucks',),
//               SizedBox(height: 4.h),
//               TitleWidget(title: AppText.exclusive),
//               ///product home card======================================
//
//
//             GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: 10,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 4,
//                 crossAxisSpacing: 4,
//                 childAspectRatio: (width == 360)
//                     ? 0.78
//                     : (width > 360)
//                     ? 0.78
//                     : 0.88,
//               ),
//               itemBuilder: (context, index) {
//                 return HomeProductCardWidget();
//               },
//             ),
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

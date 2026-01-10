// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:gau_app/core/router/route_path.dart';
// import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
// import 'package:gau_app/utils/app_assets/app_assets.dart';
// import 'package:gau_app/utils/app_text/app_text.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
//
// import 'add_to_cart_button_widget.dart';
//
//
// class HomeProductCardWidget extends StatelessWidget {
//   const HomeProductCardWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       color: AppColors.productBgColor,
//      // 1` color: AppColors.red,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomImage(
//               imageSrc: AppAssets.productImage,
//               height: 107.h,
//               //width: double.infinity,
//             ),
//
//             SizedBox(height: 8.h),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(AppText.price, style: context.bodyMedium),
//                 Text(
//                     "\$850",
//                     style: context.bodyLarge.copyWith(color: AppColors.priceTextColor)
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 8.h),
//             Center(child: GestureDetector(
//                 onTap: (){
//                   context.pushNamed(RoutePath.cartScreen);
//
//                 },
//                 child: AddToCartButtonWidget())),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gau_app/features/common/widgets/small_gradient_outline_button_widget.dart';
// import 'package:gau_app/features/user/home/presentation/widgets/category_button.dart';
// import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
// import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
// import 'package:gau_app/share/widgets/custom_profile_image.dart';
// import 'package:gau_app/utils/app_assets/app_assets.dart';
// import 'package:gau_app/utils/app_text/app_text.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   const ProductDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Nike Epic React"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16.h),
//
//             ///image ======================================
//             ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(6.r)),
//               child: Container(
//                 height: 190,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(AppAssets.productDetailsImage),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.h),
//
//             /// price text =================================================
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Nike Epic React", style: context.titleLarge),
//                 Text(
//                   "\$850",
//                   style: context.titleLarge.copyWith(
//                     color: AppColors.priceTextColor,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//
//             /// quantity text =================================================
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(AppText.quantity, style: context.bodyLarge),
//                 Row(
//                   children: [
//                     CustomContainer(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 13.w,
//                         vertical: 4.h,
//                       ),
//                       backgroundColor: AppColors.containerGreyBgColor,
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Text("-", style: context.bodyLarge),
//                       ),
//                     ),
//                     SizedBox(width: 6.w),
//                     CustomContainer(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 13.w,
//                         vertical: 4.h,
//                       ),
//                       backgroundColor: AppColors.containerGreyBgColor,
//                       child: Text("1", style: context.bodyLarge),
//                     ),
//                     SizedBox(width: 6.w),
//                     CustomContainer(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 13.w,
//                         vertical: 4.h,
//                       ),
//                       backgroundColor: AppColors.containerGreyBgColor,
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Text("+", style: context.bodyLarge),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             Text("${AppText.brand}Nike", style: context.bodyMedium),
//             SizedBox(height: 8.h),
//             Text("${AppText.selectCategory}Shoes", style: context.bodyMedium),
//             SizedBox(height: 8.h),
//             Text(
//               "${AppText.availableSizes}(e.g 7, 8, 9 ,10)",
//               style: context.bodyMedium,
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               "${AppText.description}Nike Epic React is designed for runners and everyday wear lovers who want lightweight comfort with responsive cushioning. Built with Nike’s innovative React foam, this shoe delivers a soft yet energetic feel with every step, helping reduce fatigue during long runs or daily use",
//               style: context.bodyMedium,
//             ),
//             SizedBox(height: 16.h),
//             _buildUserProfile(context),
//             SizedBox(height: 32.h),
//
//             ///  SmallGradientOutlineButtonRow=================================================================
//             SmallOutlineGradientButtonRow(
//               outlineTitle: AppText.addToCart,
//               gradientTitle: AppText.buyNow,
//
//               gradientOnTap: () {},
//               outlineOnTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   ///user profile======================================================
//   CustomContainer _buildUserProfile(BuildContext context) {
//     return CustomContainer(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       backgroundColor: AppColors.containerGreyBgColor.withAlpha(48),
//       child: Row(
//         children: [
//           Row(
//             children: [
//               CustomProfileAvatar(),
//               const SizedBox(width: 8),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "MD. Ahmed",
//                     style: context.titleLarge.copyWith(fontFamily: "Poppins"),
//                   ),
//                   Text(
//                     "Great Falls, Marylan",
//                     style: context.bodyMedium.copyWith(
//                       fontFamily: "Poppins",
//                       color: AppColors.greyTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {},
//             child: CustomContainer(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//               radius: 24.r,
//               backgroundColor: AppColors.blueColor,
//               child: Text(
//                 AppText.chat,
//                 style: context.bodyMedium.copyWith(color: AppColors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

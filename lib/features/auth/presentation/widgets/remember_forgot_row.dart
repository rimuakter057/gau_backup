// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gau_app/utils/app_text/app_text.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
//
// class RememberForgotRow extends StatelessWidget {
//   final bool rememberMe;
//   final ValueChanged<bool> onChanged;
//   final VoidCallback onForgotPassword;
//
//   final TextStyle? textStyle;
//
//   const RememberForgotRow({
//     super.key,
//     required this.rememberMe,
//     required this.onChanged,
//     required this.onForgotPassword,
//
//     this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         /// Remember Me
//         Row(
//           children: [
//             Switch(
//               value: rememberMe,
//               onChanged: onChanged,
//               activeColor: AppColors.primaryColor,
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             SizedBox(width: 4.w,),
//             Text(AppText.rememberMe, style: context.bodyMedium),
//           ],
//         ),
//
//         const Spacer(),
//
//         /// Forgot Password
//         GestureDetector(
//           onTap: onForgotPassword,
//           child: Text(
//             "Forgot Password?",
//             style: GoogleFonts.poppins(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.primaryColor,
//               decoration: TextDecoration.underline,
//               decorationColor: AppColors.primaryColor,
//               decorationThickness: 2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

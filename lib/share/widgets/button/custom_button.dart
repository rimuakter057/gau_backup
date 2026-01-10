import 'package:flutter/material.dart';
import 'package:gau_app/share/widgets/loading/loading_widget.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  const CustomButton({
    required this.text,
    this.onTap,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {




    return Material(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget(color: AppColors.white);
    } else {
      return Text(
        text,
        style: context.titleMedium.copyWith(color: AppColors.white),
      );
    }
  }
}
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zegify/utils/color/app_colors.dart';
//
// import 'package:flutter/material.dart';
// import 'package:zegify/utils/color/app_colors.dart';
//
// class GradientElevatedButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onPressed;
//   final LinearGradient? gradient;
//
//   const GradientElevatedButton({
//     super.key,
//     required this.title,
//     required this.onPressed,
//     this.gradient,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     final TextStyle? themeTextStyle =
//     Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({});
//
//     return SizedBox(
//       width: double.infinity,
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           gradient: gradient ?? AppColors.buttonGradient,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//
//             textStyle: themeTextStyle, // centralized theme text style
//
//           ),
//           onPressed: onPressed,
//           child: Text(
//             title,
//             style: themeTextStyle, // theme থেকে style apply
//           ),
//         ),
//       ),
//     );
//   }
// }
//

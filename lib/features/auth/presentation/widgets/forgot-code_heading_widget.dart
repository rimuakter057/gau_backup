import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';




class ForgotCodeHeadingWidget extends StatelessWidget {
  const ForgotCodeHeadingWidget({
    super.key, required this.title, required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
            style: context.titleLarge,
          ),
          SizedBox(height: 8.h,),
          Text(subtitle,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(color: AppColors.black),

          ),
        ],
      ),
    );
  }
}
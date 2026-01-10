import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class GradGpaContainerWidget extends StatelessWidget {
  const GradGpaContainerWidget({
    super.key,
    required this.borderColor,
    required this.bgColor,
    required this.title,
    required this.number,
  });

  final Color borderColor;
  final Color bgColor;
  final String title;
  final double number;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      backgroundColor: bgColor,
      borderColor: borderColor,
      child: Column(
        children: [
          Text(
            title,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkRed,
              height: 1,
            ),
          ),
          Text(number.toString(), style: context.titleLarge),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/utils/color/app_colors.dart';


class SoftRedContainerWidget extends StatelessWidget {
  const SoftRedContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.softRed,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/utils/color/app_colors.dart';


class SoftRedContainerWidget extends StatelessWidget {
  const SoftRedContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  ResponsiveHelper.height(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.softRed,
        borderRadius: BorderRadius.circular( ResponsiveHelper.borderRadius(6)),
      ),

      child: Padding(
        padding:  ResponsiveHelper.all(4),
        child: Row(
          children: [


        Expanded(
          child: Container(
          height:  ResponsiveHelper.height(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular( ResponsiveHelper.borderRadius(6)),
          ),
              ),
        ),


        Expanded(
          child: Container(
          height:  ResponsiveHelper.height(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.softRed,
            borderRadius: BorderRadius.circular( ResponsiveHelper.borderRadius(6)),
          ),
              ),
        ),

          ],




        ),
      ),

    );
  }
}
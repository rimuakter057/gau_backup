import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/loading/spin_kit_circle.dart';
import 'package:gau_app/utils/color/app_colors.dart';



class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context)
  {
    return SpinKitCircle(
      color: AppColors.white,
      // color: AppColors.appBarBackground,
      size: ResponsiveHelper.height(60),
    );
  }
}

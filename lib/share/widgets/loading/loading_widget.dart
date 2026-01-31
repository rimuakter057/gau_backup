import 'package:flutter/material.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';

import 'package:gau_app/utils/color/app_colors.dart';
import 'spin_kit_circle.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(color: color ?? AppColors.black, size: ResponsiveHelper.iconSize(40),),
    );
  }
}

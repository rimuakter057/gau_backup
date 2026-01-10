import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/utils/app_const/app_const.dart';
import 'package:gau_app/utils/color/app_colors.dart';

class CustomProfileAvatar extends StatelessWidget {
  const CustomProfileAvatar({
    super.key, this.height, this.width, this.image,
  });

  final double?height;
  final double?width;
  final String?image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width?? 38.r, // avatar size
      height:height?? 38.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.greyTextColor,
          width: 2.r,
        ),
        image: DecorationImage(
          image: NetworkImage(image??AppConstant.unknown),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 48.h,
      width: double.infinity,
      radius: 12.r, // rounded corners,
      backgroundColor: AppColors.searchBarBgColor,
      child: TextField(
        decoration: InputDecoration(
          fillColor: AppColors.searchBarBgColor,
          filled: true,
          hintText: "Search here...", // placeholder text
          hintStyle: context.bodyMedium.copyWith(color: AppColors.searchTextColor),
          prefixIcon: CustomImage(imageSrc: AppAssets.search,
            height: 20.h,
            width: 20.w,
            fit: BoxFit.contain,
          ),
          prefixIconConstraints: BoxConstraints(
            minHeight: 20.h,
            minWidth: 20.w,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16.w,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
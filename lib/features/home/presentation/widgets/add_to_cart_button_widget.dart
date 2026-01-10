import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';


class AddToCartButtonWidget extends StatelessWidget {
  const AddToCartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      radius: 50,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
      backgroundColor: AppColors.red,
      child: Text(
        AppText.addToCart,
        style: context.bodyMedium,
      ),
    );
  }
}

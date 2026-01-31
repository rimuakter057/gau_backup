import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart' show AppText;
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class CancelSaveRowButtonWidget extends StatelessWidget {
  const CancelSaveRowButtonWidget({
    super.key,
    this.title,
    this.icon,
    required this.onTapTitle,
  });

  final String? title;
  final String? icon;

  final VoidCallback onTapTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: CustomContainer(
              // padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              borderColor: AppColors.primaryColor,
              borderWidth: ResponsiveHelper.width(2),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  AppText.cancel,
                  style: context.bodyLarge.copyWith(
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(12)),
        Expanded(
          child: GestureDetector(
            onTap: onTapTitle,
            child: CustomContainer(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(4),
                vertical: ResponsiveHelper.height(12),
              ),
              backgroundColor: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImage(imageSrc: icon ?? AppAssets.submitReq),
                  SizedBox(width: ResponsiveHelper.width(4)),
                  Text(
                    title ?? AppText.submitRequest,
                    style: context.bodyMedium.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

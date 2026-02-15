import 'package:flutter/material.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';



class SecurityWidget extends StatelessWidget {
  const SecurityWidget({
    super.key,
    required this.gap,
    required this.controller,
  });

  final Widget gap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          AppText.passwordAuthentication,
          style: context.titleMedium.copyWith(
            fontFamily: 'inter',
          ),
        ),
        gap,

        ///current password field==============================================================
        InputPassFieldWidget(
          title: AppText.currentPassword,
          hint: AppText.enterPassword,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),

        gap,

        ///new password field==============================================================
        InputPassFieldWidget(
          title: AppText.newPassword,
          hint: AppText.enterPassword,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),

        gap,

        ///confirmed password field==============================================================
        InputPassFieldWidget(
          title: AppText.confirmNewPassword,
          hint: AppText.enterPassword,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        gap,
        SizedBox(height: ResponsiveHelper.height(8)),
        CustomDivider(),
        SizedBox(height: ResponsiveHelper.height(4)),
        OutlinedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              CustomImage(
                imageSrc: AppAssets.updatePass,
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Text(AppText.updatePassword),
            ],
          ),
        ),
        gap,
        SizedBox(height: ResponsiveHelper.height(8)),
        CustomDivider(),
        SizedBox(height: ResponsiveHelper.height(4)),

        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            padding: EdgeInsets.all(ResponsiveHelper.padding(6)),
            decoration: BoxDecoration(
              color: AppColors.twoFactorBg,
            ),
            child: CustomImage(
              imageSrc: AppAssets.twoFactor,
            ),
          ),
          title: Text(
            AppText.twoFactorAuthentication,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
          ),
          subtitle: Text(
            AppText.twoFADescription,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodySmall,
          ),
          trailing: Text(
            AppText.enable2FA,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
          ),
        ),
      ],
    );
  }
}
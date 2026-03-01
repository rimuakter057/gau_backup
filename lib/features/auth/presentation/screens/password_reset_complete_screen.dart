import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/auth/controller/auth_controller.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PasswordResetCompleteScreen extends StatefulWidget {
  const PasswordResetCompleteScreen({super.key,});

  @override
  State<PasswordResetCompleteScreen> createState() =>
      _PasswordResetCompleteScreenState();
}

class _PasswordResetCompleteScreenState
    extends State<PasswordResetCompleteScreen> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AuthController authController =Get.find<AuthController>();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(16));
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: ResponsiveHelper.width(16),
          right: ResponsiveHelper.width(16),
          top: ResponsiveHelper.height(120),
          bottom: ResponsiveHelper.height(16),
        ),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              /// heading logo and text==================================================
              Column(
                children: [
                  CustomImage(
                    imageSrc: AppAssets.appLogoImage,
                    height: ResponsiveHelper.height(76),
                    width: ResponsiveHelper.width(76),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    AppText.passwordResetComplete,
                    style: context.titleMedium,
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    AppText.passwordUpdatedSuccess,
                    style: context.labelMedium,
                  ),
                ],
              ),
              gap,
              gap,

              Card(
                color: AppColors.cardBgColor,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: ResponsiveHelper.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        gap,
                        gap,
                        gap,

                        Container(
                          padding: ResponsiveHelper.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColors.softGreenBg, // background color
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CustomImage(imageSrc: AppAssets.complete),
                          ),
                        ),

                        gap,
                        gap,

                        Text(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          AppText.passwordResetSuccessful,
                          style: context.titleMedium,
                        ),
                        SizedBox(height: ResponsiveHelper.height(8)),
                        Text(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          AppText.passwordUpdatedMessage,
                          style: context.labelMedium,
                        ),

                        gap,
                        gap,

                        /// sign in button==========================================================================
                        ElevatedButton(
                          onPressed: () {
                            context.pushNamed(RoutesPath.loginScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppText.continueToSignIn),
                              SizedBox(width: ResponsiveHelper.width(12)),
                              CustomImage(imageSrc: AppAssets.next),
                            ],
                          ),
                        ),

                        gap,
                        gap,
                        gap,
                        CustomContainer(
                          borderColor: AppColors.blueColor,
                          backgroundColor: AppColors.softBlueBg,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImage(imageSrc: AppAssets.security),

                              SizedBox(width: ResponsiveHelper.width(4)),

                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Security Tip : ",
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.blueColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppText.contactSupport,
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.blueColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppText.supportEmail,
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.blueColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        gap,
                        gap,
                        gap,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }










  //
  // Future<void> onTapResetPassword() async {
  //   // check new password
  //   if (newPassword.text.trim().isEmpty) {
  //     CustomSnackbar.error(context, "New password cannot be empty");
  //     return;
  //   }
  //
  //   // check confirm password
  //   if (confirmedPasswordController.text.trim().isEmpty) {
  //     CustomSnackbar.error(context, "Confirm password cannot be empty");
  //     return;
  //   }
  //
  //   // check if passwords match
  //   if (newPassword.text.trim() != confirmedPasswordController.text.trim()) {
  //     CustomSnackbar.error(context, "Passwords do not match");
  //     return;
  //   }
  //
  //   if (!_key.currentState!.validate()) return;
  //
  //   bool success = await authController.resetPassword(
  //     email: widget.email, // use email passed from previous screen
  //     newPassword: newPassword.text.trim(),
  //     confirmedPassword: confirmedPasswordController.text.trim(),
  //   );
  //
  //   if (success) {
  //     CustomSnackbar.success(context, "Password reset successful");
  //     context.pushNamed(RoutesPath.loginScreen);
  //
  //     newPassword.clear();
  //     confirmedPasswordController.clear();
  //   } else {
  //     CustomSnackbar.error(
  //       context,
  //       authController.errorMessage.value,
  //     );
  //   }
  // }




}

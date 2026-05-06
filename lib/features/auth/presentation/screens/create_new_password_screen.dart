import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/auth/controller/auth_controller.dart';

import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/password_requirement_widget.dart';
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

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key, required this.email});

  final String email;
  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();
  final AuthController authController =Get.find<AuthController>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(16));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: ResponsiveHelper.width(50),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Center(child: CustomImage(imageSrc: AppAssets.back)),
        ),
      ),

      body: Padding(
        padding: ResponsiveHelper.all(16),
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
                    AppText.createNewPassword,
                    style: context.titleMedium,
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    AppText.chooseStrongPassword,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          borderColor: AppColors.inputBorderColor,
                          backgroundColor: AppColors.white,
                          child: Column(
                            children: [
                              PasswordRequirementWidget(
                                title: AppText.atLeast8Chars,
                              ),
                              gap,
                              PasswordRequirementWidget(
                                title: AppText.includeUpperLower,
                              ),
                              gap,
                              PasswordRequirementWidget(
                                title: AppText.includeNumber,
                              ),
                              gap,
                              PasswordRequirementWidget(
                                title: AppText.includeSpecialChar,
                              ),
                            ],
                          ),
                        ),
                        gap,
                        gap,

                        ///new password field==============================================================
                        InputPassFieldWidget(
                          title: AppText.newPassword,
                          hint: AppText.enterNewPassword,
                          controller: newPassword,

                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your new password';
                            }
                            return null;
                          },
                        ),
                        gap,

                        ///confirmed password field==============================================================
                        InputPassFieldWidget(
                          title: AppText.confirmNewPassword,
                          hint: AppText.enterPassword,
                          controller: confirmedPasswordController,

                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        gap,
                        gap,

                        /// sign in button==========================================================================
                        ElevatedButton(
                          onPressed:onTapResetPassword,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppText.resetPassword),
                              SizedBox(width: ResponsiveHelper.width(12)),
                              CustomImage(imageSrc: AppAssets.reset),
                            ],
                          ),
                        ),

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








  Future<void> onTapResetPassword() async {
    // check new password
    if (newPassword.text.trim().isEmpty) {
      CustomSnackbar.error(context:context,message:  "New password cannot be empty");
      return;
    }

    // check confirm password
    if (confirmedPasswordController.text.trim().isEmpty) {
      CustomSnackbar.error(context:context,message:  "Confirm password cannot be empty");
      return;
    }

    // check if passwords match
    if (newPassword.text.trim() != confirmedPasswordController.text.trim()) {
      CustomSnackbar.error(context:context,message:  "Passwords do not match");
      return;
    }

    if (!_key.currentState!.validate()) return;

    bool success = await authController.resetPassword(
      email: widget.email, // use email passed from previous screen
      newPassword: newPassword.text.trim(),
      confirmedPassword: confirmedPasswordController.text.trim(),
    );

    if (success) {
      CustomSnackbar.success(context, "Password reset successful");
      context.pushNamed(RoutesPath.passwordResetCompleteScreen);

      newPassword.clear();
      confirmedPasswordController.clear();
    } else {
      CustomSnackbar.error(
        context:context,
       message:  authController.errorMessage.value,
      );
    }
  }

}

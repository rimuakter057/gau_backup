import 'package:flutter/material.dart';
import 'package:gau_app/features/auth/controller/auth_controller.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';

class SecurityWidget extends StatefulWidget {
  const SecurityWidget({
    super.key,
    required this.gap,
  });

  final Widget gap;

  @override
  State<SecurityWidget> createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await authController.changePassword(
      oldPassword: oldPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
      confirmNewPassword: confirmPasswordController.text.trim(),
    );

    if (success) {
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();


      CustomSnackbar.success(context, 'Password updated successfully');
    } else {

      CustomSnackbar.error(context:context, message:authController.errorMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.passwordAuthentication,
            style: context.titleMedium.copyWith(fontFamily: 'inter'),
          ),
          widget.gap,

          // ✅ Current password
          InputPassFieldWidget(
            title: AppText.currentPassword,
            hint: AppText.enterPassword,
            controller: oldPasswordController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your current password';
              }
              return null;
            },
          ),
          widget.gap,

          // ✅ New password
          InputPassFieldWidget(
            title: AppText.newPassword,
            hint: AppText.enterPassword,
            controller: newPasswordController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a new password';
              }
              if (value.trim().length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          widget.gap,

          // ✅ Confirm password
          InputPassFieldWidget(
            title: AppText.confirmNewPassword,
            hint: AppText.enterPassword,
            controller: confirmPasswordController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please confirm your password';
              }
              if (value.trim() != newPasswordController.text.trim()) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          widget.gap,

          SizedBox(height: ResponsiveHelper.height(38)),

          // ✅ Button-এ loading indicator
          Obx(() => SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: authController.inProgressChangePass.value
                  ? null
                  : _onUpdatePassword,
              child: authController.inProgressChangePass.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImage(imageSrc: AppAssets.updatePass),
                  SizedBox(width: ResponsiveHelper.width(12)),
                  Text(AppText.updatePassword),
                ],
              ),
            ),
          )),

          widget.gap,

        ],
      ),
    );
  }
}
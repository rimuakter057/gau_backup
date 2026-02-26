import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/auth/controller/auth_controller.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/features/home/presentation/screens/home_screen.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';

import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(16));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: ResponsiveHelper.width(16),
            right: ResponsiveHelper.width(16),
            top: ResponsiveHelper.height(56),
            bottom: ResponsiveHelper.height(16),
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                /// heading logo and text==================================================
                _buildHeadingLogoText(context),
                gap,
                gap,

                ///email field===================================================
                InputFieldWidget(
                  title: AppText.email,
                  hint: AppText.enterEmail,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                ),
                gap,

                ///password field==============================================================
                InputPassFieldWidget(
                  title: AppText.password,
                  hint: AppText.enterPassword,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                gap,

                ///forgot  password text==============================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RoutesPath.forgotScreen);
                      },
                      child: Text(
                        AppText.forgotPassword,
                        style: context.bodySmall.copyWith(
                          color: AppColors.darkRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                gap,
                gap,

                /// sign in button==========================================================================
                ElevatedButton(

                  onPressed: onTapLogin,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppText.signIn),
                      SizedBox(width: ResponsiveHelper.width(12)),
                      CustomImage(imageSrc: AppAssets.next),
                    ],
                  ),
                ),

                gap,
                gap,

                ///note text====================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.note,
                      style: context.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.width(12)),
                    Expanded(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        AppText.studentLoginInfo,
                        style: context.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.height(48)),

                /// footerLegalText==========================================================================
                Text(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  AppText.footerLegalText,
                  style: context.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildHeadingLogoText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomImage(
            imageSrc: AppAssets.appLogoImage,
            height: ResponsiveHelper.height(76),
            width: ResponsiveHelper.width(76),
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            AppText.universityName,
            style: context.titleMedium,
          ),
          SizedBox(height: ResponsiveHelper.height(8)),
          Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            AppText.signInSubtitle,
            style: context.labelMedium,
          ),
        ],
      ),
    );
  }

Future <void> onTapLogin()async{

  debugPrint("===================click sign in=====================");
  // ✅ CHECK EMAIL
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  // email empty check
  if (email.isEmpty) {
    CustomSnackbar.error(context, "Please enter your email");
    return;
  }

  // email format check
  final emailRegex = RegExp(
      r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');
  if (!emailRegex.hasMatch(email)) {
    CustomSnackbar.error(context, "Please enter a valid email address");
    return;
  }

  // password empty check
  if (password.isEmpty) {
    CustomSnackbar.error(context, "Please enter your password");
    return;
  }

  debugPrint("===================authcontroller=======================================");
  bool success = await authController.login(
    email: emailController.text,
    password: passwordController.text,
  );

  if (success) {
    Get.offAll(() => HomeScreen());
  } else {
    CustomSnackbar.error(context, authController.errorMessage.value);
  }

}



}



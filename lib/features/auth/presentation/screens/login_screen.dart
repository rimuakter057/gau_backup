import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/auth/presentation/widgets/action_text_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';

import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';

import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: 16.h);
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:16.w,right:16.w,top: 56.h,bottom: 16.h   ),
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
                    Text(
                      AppText.forgotPassword,
                      style: context.bodySmall.copyWith(
                        color: AppColors.darkRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                gap,
                gap,

                /// sign in button==========================================================================
                ElevatedButton(

                  onPressed: () {
                    context.pushNamed(RoutePath.homeScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppText.signIn),
                      SizedBox(width: 12.w),
                      CustomImage(imageSrc: AppAssets.next),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                /// registration==========================================================================
                ActionTextWidget(
                  prefixText: AppText.staffWithoutAccount,
                  actionText: AppText.registerHere,
                  onActionTapped: () {
                    // context.pushNamed(RoutePath.selectedScreen);
                  },
                ),
                gap,
                gap,

                /// divider==========================================================================
                CustomDivider(color: AppColors.dividerColor),

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
                    SizedBox(width: 12.w),
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
                SizedBox(height: 48.h),

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
            height: 76.h,
            width: 76.w,
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            AppText.universityName,
            style: context.titleMedium,
          ),
          SizedBox(height: 8.h),
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
}

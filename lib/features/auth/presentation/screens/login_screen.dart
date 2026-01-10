import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/auth/presentation/widgets/action_text_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/remember_forgot_row.dart';
import 'package:gau_app/share/widgets/button/custom_button.dart';


import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';

import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: 24.h);
    return Scaffold(
      appBar: CustomAppBar(title: AppText.login),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ///login image
              Center(
                child: CustomImage(
                  imageSrc: AppAssets.appLogoImage,
                  height: 196.h,
                  width: 243.w,
                ),
              ),
              gap,
              gap,

              ///email field
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

              ///password field
              InputPassFieldWidget(
                title: AppText.password,
                hint: AppText.enterPassword,
                controller: passwordController,
              ),
        SizedBox(height: 16.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(

                    AppText.forgotPassword,style: context.bodySmall.copyWith(color: AppColors.darkRed,fontWeight: FontWeight.w700),),
                ],
              ),



              gap,

              gap,

          ElevatedButton(onPressed: (){}, child: Row(children: [

          ],)),

// CustomButton(text: "text"),
              ActionTextWidget(

                prefixText: AppText.staffWithoutAccount,
                actionText: AppText.registerHere,
                onActionTapped: () {
                  // context.pushNamed(RoutePath.selectedScreen);

                },

              ),
              SizedBox(height: 12.h,),

            ],
          ),
        ),
      ),
    );
  }
}

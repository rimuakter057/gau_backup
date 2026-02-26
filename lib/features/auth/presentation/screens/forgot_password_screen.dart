import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/auth/controller/auth_controller.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_loader/custom_loader.dart';
import 'package:gau_app/share/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                    AppText.resetYourPassword,
                    style: context.titleMedium,
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    AppText.enterYourEmailInstruction,
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
                    padding:  ResponsiveHelper.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                        text: "Security Notice : ",
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.blueColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppText.securityNotice,
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.blueColor,
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
                  
                        ///email field===================================================
                        InputFieldWidget(
                          title: AppText.universityEmailAddress,
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
                         gap,
                        gap,
                  
                        /// sign in button==========================================================================
                        // ElevatedButton(
                        //   onPressed: () {
                        //     context.pushNamed(RoutesPath.verificationScreen);
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(AppText.sendResetCode),
                        //       SizedBox(width: ResponsiveHelper.width(12)),
                        //       CustomImage(imageSrc: AppAssets.next),
                        //     ],
                        //   ),
                        // ),

                        Obx(() => ElevatedButton(

                          onPressed: authController.inProgressForgot.value
                              ? null
                              : onTapForgot,

                          child: authController.inProgressForgot.value
                              ? SizedBox(
                              height: ResponsiveHelper.iconSize(30),
                              width: ResponsiveHelper.iconSize(30),
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.white,
                              ))
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppText.sendResetCode),
                              SizedBox(width: ResponsiveHelper.width(12)),
                              CustomImage(imageSrc: AppAssets.next),
                            ],
                          ),

                        )),











                  
                        gap,
                        GestureDetector(
                          onTap: (){

                            context.pop();

                          },
                          child: Row(
                            children: [
                              CustomImage(imageSrc: AppAssets.backAuth),
                              SizedBox(width: ResponsiveHelper.width(12)),
                              Text(AppText.backToSignIn),
                            ],
                          ),
                        ),
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






  Future<void> onTapForgot() async {

    // email empty check
    if (emailController.text.trim().isEmpty) {

      CustomSnackbar.error(context, "Email cannot be empty");

      return;

    }

    if (!_key.currentState!.validate()) return;



    bool success = await authController.forgot(
      email: emailController.text.trim(),
    );

    if (success) {

      context.pushNamed(RoutesPath.verificationScreen,
        extra: emailController.text.trim(),
      );

      emailController.clear();

    } else {

      CustomSnackbar.error(
        context,
        authController.errorMessage.value,
      );

    }

  }



}

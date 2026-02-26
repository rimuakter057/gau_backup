import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/auth/controller/auth_controller.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
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

class VerificationScreenScreen extends StatefulWidget {
  const VerificationScreenScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationScreenScreen> createState() =>
      _VerificationScreenScreenState();
}

class _VerificationScreenScreenState extends State<VerificationScreenScreen> {

  final AuthController authController =Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    debugPrint("============================${widget.email}=================================================");


  }

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(16));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                      AppText.checkYourEmail,
                      style: context.titleMedium,
                    ),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    Text(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      AppText.verificationCodeSent,
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
        
        
        
                          Center(
                            child: Column(
                              children: [
        
                                Container(
                                  padding:ResponsiveHelper.all(8.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBlueBg,    // background color
                                    shape: BoxShape.circle,
        
                                  ),
                                  child: Center(
                                    child: CustomImage(
                                      imageSrc: AppAssets.email,       // তোমার icon
        
                                    ),
                                  ),
                                ),
        
        
        
                                gap,
                                Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  AppText.weSent6DigitCode,
                                  style: context.labelMedium,
                                ),
                                SizedBox(height: ResponsiveHelper.height(8)),
                                Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  "example@gmail.com",
                                  style: context.bodyMedium,
                                ),
                              ],
                            ),
                          ),
        
        
                          gap,
        
                          /// OTP field ===================================================
                          InputFieldWidget(
                            title: AppText.verificationCode,
                            hint: "000000",
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter the verification code';
                              }
        
        
                              // check 6 digits exactly
                              if (value.trim().length != 6) {
                                return 'Code must be 6 digits';
                              }
        
                              return null;
                            },
                          ),
        
                          gap,
                          gap,
                          gap,
        
                          /// sign in button==========================================================================


                          ElevatedButton(
                            onPressed: onTapVerification,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppText.verifyCode),
                                SizedBox(width: ResponsiveHelper.width(12)),
                                CustomImage(imageSrc: AppAssets.next),
                              ],
                            ),
                          ),
        
                          gap,
        
                          CustomContainer(
                            borderColor: AppColors.softBlueBg,
                            backgroundColor: AppColors.softYellowBg,
                            padding: ResponsiveHelper.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// icon
                                CustomImage(
                                  imageSrc: AppAssets.time,
                                  width: ResponsiveHelper.width(18),
                                  height: ResponsiveHelper.height(18),
                                ),
        
                                SizedBox(width: ResponsiveHelper.width(8)),
        
                                /// main text
                                Expanded(
                                  child: Text(
                                    AppText.codeExpireNotice,
                                    style: context.bodySmall.copyWith(
                                      color: AppColors.brown,
                                    ),
                                  ),
                                ),
        
                                SizedBox(width: ResponsiveHelper.width(8)),
        
                                /// resend code button text
                                GestureDetector(
                                  onTap: () {
                                    /// resend code action
                                  },
                                  child: Text(
                                    AppText.resendCode,
        
                                    style: context.bodySmall.copyWith(
                                      color: AppColors.brown,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.brown,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
        
                          gap,
        
                          GestureDetector(
                            onTap: (){
                              context.pop();
                            },
                            child: Row(
                              children: [
                                CustomImage(imageSrc: AppAssets.backAuth),
                                SizedBox(width: ResponsiveHelper.width(12)),
                                Text(AppText.useDifferentEmail),
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
      ),
    );
  }







  Future<void> onTapVerification() async {

    // email empty check
    if (otpController.text.trim().isEmpty) {

      CustomSnackbar.error(context, "Otp cannot be empty");

      return;

    }

    if (!_key.currentState!.validate()) return;



    bool success = await authController.verifyOtp(
      email: widget.email,
      otp: int.tryParse(otpController.text.trim()) ?? 0, // convert string to int
    );

    if (success) {

      context.pushNamed(RoutesPath.createNewPassScreen,
      extra:   widget.email,
      );

      otpController.clear();

    } else {

      CustomSnackbar.error(
        context,
        authController.errorMessage.value,
      );

    }

  }





}

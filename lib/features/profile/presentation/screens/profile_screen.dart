import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/title_widget.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: 16.h);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        // Add SingleChildScrollView here
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // ================= PROFILE CONTAINER =================
            CustomContainer(
              padding: EdgeInsets.all(24),
              width: double.infinity,
              backgroundColor: AppColors.containerGreyBgColor,
              borderColor: AppColors.inputBorderColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppText.profileSettings, style: context.titleMedium),
                  SizedBox(height: 4.h),
                  Text(AppText.manageAccountSubtitle, style: context.bodySmall),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ================= TAB SECTION =================
            DefaultTabController(
              length: 2,
              child: CustomContainer(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                backgroundColor: AppColors.white,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Add this
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CustomProfileAvatar(),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 3,
                                  ),
                                ),
                                child: CustomImage(imageSrc: AppAssets.camera),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("User Name", style: context.bodyMedium),
                            Text("message", style: context.bodySmall),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),
                    CustomDivider(),

                    // TabBar
                    TabBar(
                      dividerColor: AppColors.dividerColor,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: AppColors.labelTextColor,
                      indicatorColor: AppColors.primaryColor,
                      tabs: [
                        Tab(text: AppText.personalInfo),

                        Tab(text: AppText.security),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: 500.h, // Adjust this height as needed
                          child: TabBarView(
                            children: [
                              // Tab 1
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///first name===================================================
                                    InputFieldWidget(
                                      title: AppText.firstName,
                                      hint: AppText.subjectHint,
                                      controller: controller,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your ';
                                        }
                                        return null;
                                      },
                                    ),
                                    gap,

                                    ///last name===================================================
                                    InputFieldWidget(
                                      title: AppText.lastName,
                                      hint: AppText.descriptionHint,
                                      controller: controller,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your ';
                                        }
                                        return null;
                                      },
                                    ),
                                    gap,

                                    ///student Id field===================================================
                                    InputFieldWidget(
                                      title: AppText.studentId,
                                      hint: AppText.descriptionHint,
                                      controller: controller,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your ';
                                        }
                                        return null;
                                      },
                                    ),
                                    gap,

                                    ///email field===================================================
                                    InputFieldWidget(
                                      title: AppText.email,
                                      hint: AppText.descriptionHint,
                                      controller: controller,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your email';
                                        }

                                        final emailRegex = RegExp(
                                          r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
                                        );

                                        if (!emailRegex.hasMatch(
                                          value.trim(),
                                        )) {
                                          return 'Please enter a valid email address';
                                        }

                                        return null;
                                      },
                                    ),
                                    gap,

                                    ///number field===================================================
                                    InputFieldWidget(
                                      title: AppText.phoneNumber,
                                      hint: AppText.descriptionHint,
                                      controller: controller,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your ';
                                        }
                                        return null;
                                      },
                                    ),
                                    gap,

                                    ///address field===================================================
                                    InputFieldWidget(
                                      title: AppText.dormAddress,
                                      hint: AppText.descriptionHint,
                                      controller: controller,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your ';
                                        }
                                        return null;
                                      },
                                    ),

                                    gap,
                                    gap,

                                    CancelSaveRowButtonWidget(
                                      icon: AppAssets.save,
                                      onTapTitle: () {},
                                      title: AppText.saveChanges,
                                    ),
                                    gap,
                                    gap,
                                  ],
                                ),
                              ),

                              // Tab 2
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(AppText.passwordAuthentication,style: context.titleMedium.copyWith(fontFamily: 'inter'),),
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

                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

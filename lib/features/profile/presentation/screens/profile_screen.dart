import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_pass_field_widget.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.height(16));
    return Scaffold(
      appBar: CustomAppBar(),

      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),

      body: Column(
        children: [
          // ================= PROFILE CONTAINER =================
          CustomContainer(
            padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
            width: double.infinity,
            backgroundColor: AppColors.containerGreyBgColor,
            borderColor: AppColors.inputBorderColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppText.profileSettings, style: context.titleMedium),
                SizedBox(height:ResponsiveHelper.height(4)),
                Text(AppText.manageAccountSubtitle, style: context.bodySmall),
              ],
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(20)),

          // ================= TAB SECTION =================
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(8)),
                color: AppColors.containerGreyBgColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(ResponsiveHelper.padding(16)),
                  child: Column(
                   // mainAxisSize: MainAxisSize.min,
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
                                  padding: EdgeInsets.all(ResponsiveHelper.width(4)),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: ResponsiveHelper.width(2),
                                    ),
                                  ),
                                  child: CustomImage(
                                    imageSrc: AppAssets.camera,
                                    height: ResponsiveHelper.iconSize(6),
                                    width:ResponsiveHelper.iconSize(6),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: ResponsiveHelper.width(8)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User Name", style: context.bodyMedium),
                              Text("message", style: context.bodySmall),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: ResponsiveHelper.height(4)),
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

                      Expanded(
                        child: TabBarView(
                          children: [
                            // Tab 1
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                                ],
                              ),
                            ),

                            // Tab 2
                            SingleChildScrollView(
                              child: Column(
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
                              ),
                            ),
                          ],
                        ),
                      ),




                    ],
                  ),
                ),
              ),


            ),
          ),

          SizedBox(height: ResponsiveHelper.height(38)),
        ],
      ),
    );
  }
}

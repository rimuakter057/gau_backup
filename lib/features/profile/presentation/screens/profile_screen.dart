import 'package:flutter/material.dart';

import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/profile/presentation/widgets/personal_info_widget.dart';
import 'package:gau_app/features/profile/presentation/widgets/security_widget.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';

import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';

import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int selectedTab = 0;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final gap = SizedBox(height: ResponsiveHelper.height(16));

    return Scaffold(

      appBar: CustomAppBar(),

      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),

      body: SingleChildScrollView(

        child: Column(

          children: [

            /// ================= PROFILE CONTAINER =================

            CustomContainer(

              padding: EdgeInsets.all(ResponsiveHelper.padding(24)),

              width: double.infinity,

              backgroundColor: AppColors.containerGreyBgColor,

              borderColor: AppColors.inputBorderColor,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(AppText.profileSettings,
                      style: context.titleMedium),

                  SizedBox(height: 4),

                  Text(AppText.manageAccountSubtitle,
                      style: context.bodySmall),

                ],

              ),

            ),

            SizedBox(height: 20),

            /// ================= CARD =================

            Card(

              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(8)),

              color: AppColors.containerGreyBgColor,

              elevation: 10,

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadius(12)),

              ),

              child: Padding(

                padding: EdgeInsets.all(ResponsiveHelper.padding(16)),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    /// PROFILE ROW

                    Row(

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

                        SizedBox(width: 8),

                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text("User Name",
                                style: context.bodyMedium),

                            Text("message",
                                style: context.bodySmall),

                          ],

                        ),

                      ],

                    ),

                    SizedBox(height: 8),

                    CustomDivider(),

                    /// ================= TAB ROW =================

                    Row(

                      children: [

                        Expanded(

                          child: GestureDetector(

                            onTap: () {
                              setState(() {
                                selectedTab = 0;
                              });
                            },

                            child: Column(

                              children: [

                                Text(
                                  AppText.personalInfo,
                                  style: context.bodyMedium.copyWith(
                                    color: selectedTab == 0
                                        ? AppColors.primaryColor
                                        : AppColors.labelTextColor,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Container(
                                  height: 2,
                                  color: selectedTab == 0
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                )

                              ],

                            ),

                          ),

                        ),

                        Expanded(

                          child: GestureDetector(

                            onTap: () {
                              setState(() {
                                selectedTab = 1;
                              });
                            },

                            child: Column(

                              children: [

                                Text(
                                  AppText.security,
                                  style: context.bodyMedium.copyWith(
                                    color: selectedTab == 1
                                        ? AppColors.primaryColor
                                        : AppColors.labelTextColor,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Container(
                                  height: 2,
                                  color: selectedTab == 1
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                )

                              ],

                            ),

                          ),

                        ),

                      ],

                    ),

                    SizedBox(height: 16),

                    /// ================= CONTENT =================

                    IndexedStack(

                      index: selectedTab,

                      children: [

                        /// PERSONAL INFO

                        PersonalInfoWidget(controller: controller, gap: gap),

                        /// SECURITY

                        SecurityWidget(gap: gap, ),

                      ],

                    ),

                  ],

                ),

              ),

            ),

            SizedBox(height: 40),

          ],

        ),

      ),

    );

  }

}





import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int selectedIndex = -1;
  int hoveredIndex = -1;

  final drawerItems = [
    {
      "title": AppText.dashboard,
      "icon": AppAssets.dashBoard,
      "route": RoutesPath.homeScreen.addBasePath,
    },
    {
      "title": AppText.myGradesMenu,
      "icon": AppAssets.grade,
      "route": RoutesPath.gradeScreen.addBasePath,
    },
    {
      "title": AppText.transcriptMenu,
      "icon": AppAssets.transcript,
      "route": RoutesPath.transcriptScreen.addBasePath,
    },
    {
      "title": AppText.complaintsMenu,
      "icon": AppAssets.complain,
      "route": RoutesPath.complainScreen.addBasePath,
    },
    {
      "title": AppText.messageMenu,
      "icon": AppAssets.message,
      "route": RoutesPath.chatScreen.addBasePath,
    },
    {
      "title": AppText.profileMenu,
      "icon": AppAssets.profileDrawer,
      "route": RoutesPath.profileScreen.addBasePath,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerBgColor,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: ResponsiveHelper.height(150),
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: CustomImage(imageSrc: AppAssets.appLogoImage),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.studentPortal,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(16)),
                ...List.generate(drawerItems.length, (index) {
                  final item = drawerItems[index];
                  bool isSelected = selectedIndex == index;
                  bool isHovered = hoveredIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: ResponsiveHelper.height(16),
                    ),
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() => hoveredIndex = index);
                      },
                      onExit: (_) {
                        setState(() => hoveredIndex = -1);
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                          context.push(item["route"]!);
                        },
                        child: CustomContainer(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(8),
                            vertical: ResponsiveHelper.height(12),
                          ),
                          backgroundColor: (isSelected || isHovered)
                              ? AppColors.primaryColor
                              : AppColors.containerGreyBgColor,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                item["icon"]!,
                                color: (isSelected || isHovered)
                                    ? Colors.white
                                    : AppColors.labelTextColor,
                                height: ResponsiveHelper.iconSize(20),
                                width: ResponsiveHelper.iconSize(20),
                              ),
                              SizedBox(width: ResponsiveHelper.width(8)),
                              Text(
                                item["title"]!,
                                style: context.bodyMedium.copyWith(
                                  color: (isSelected || isHovered)
                                      ? Colors.white
                                      : AppColors.labelTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const Spacer(),
          const CustomDivider(color: AppColors.dividerColor),
          // Logout
          _buildDrawerItem(
            title: AppText.signOut,
            icon: AppAssets.logOut,
            onTap: () {
              context.push(RoutesPath.loginScreen.addBasePath);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        backgroundColor: AppColors.containerGreyBgColor,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: AppColors.labelTextColor,
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: context.bodyMedium.copyWith(
                color: AppColors.labelTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

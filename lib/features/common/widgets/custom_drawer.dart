import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: 16.h);
    return Drawer(
      backgroundColor: AppColors.drawerBgColor,
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 150.h,
                    child: DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: CustomImage(imageSrc: AppAssets.appLogoImage),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.studentPortal,
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _DrawerItem(
                        image: AppAssets.dashBoard,
                        title: AppText.dashboard,
                        onTap: () {
                          context.push(RoutesPath.homeScreen.addBasePath);
                        },
                      ),
                      gap,
                      _DrawerItem(
                        image: AppAssets.grade,
                        title: AppText.myGradesMenu,
                        onTap: () {
                          context.push(RoutesPath.gradeScreen.addBasePath);
                        },
                      ),
                      gap,
                      _DrawerItem(
                        image: AppAssets.transcript,
                        title: AppText.transcriptMenu,
                        onTap: () {
                          context.push(RoutesPath.transcriptScreen.addBasePath);
                        },
                      ),
                      gap,
                      _DrawerItem(
                        image: AppAssets.complain,
                        title: AppText.complaintsMenu,
                        onTap: () {
                          context.push(RoutesPath.complainScreen.addBasePath);
                        },
                      ),
                      gap,
                      _DrawerItem(
                        image: AppAssets.message,
                        title: AppText.messageMenu,
                        onTap: () {
                          context.push(RoutesPath.chatScreen.addBasePath);
                        },
                      ),

                      gap,
                      _DrawerItem(
                        image: AppAssets.profileDrawer,
                        title: AppText.profileMenu,
                        onTap: () {
                          context.push(RoutesPath.profileScreen.addBasePath);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                const CustomDivider(color: AppColors.dividerColor),
                _DrawerItem(
                  image: AppAssets.logOut,
                  title: AppText.signOut,
                  onTap: () {
                    context.push(RoutesPath.loginScreen.addBasePath);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String image;
  const _DrawerItem({
    required this.title,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        backgroundColor: AppColors.containerGreyBgColor,

        child: Row(
          children: [
            SvgPicture.asset(
              image,
              color: AppColors.labelTextColor,
              height: 20.h,
              width: 20.w,
              fit: BoxFit.cover,
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

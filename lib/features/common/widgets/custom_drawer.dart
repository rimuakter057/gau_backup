import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerBgColor,
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
                child: CustomImage(
                  imageSrc: AppAssets.appLogoImage,
                ),
              ),
            ),
          ),

          const CustomDivider(color: AppColors.dividerColor),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DrawerItem(
                  title: AppText.dashboard,
                  onTap: () {
                    // navigate
                  },
                ),
                SizedBox(height: 16.h),
                _DrawerItem(
                  title: AppText.myGradesMenu,
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _DrawerItem(
                  title: AppText.transcriptMenu,
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _DrawerItem(
                  title: AppText.complaintsMenu,
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _DrawerItem(
                  title: AppText.messageMenu,
                  onTap: () {},
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

  const _DrawerItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: context.titleLarge,
      ),
    );
  }
}

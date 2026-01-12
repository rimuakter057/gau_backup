import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileName;
  final String profileSubtitle;

  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;

  const HomeAppBar({
    super.key,
    required this.profileName,
    required this.profileSubtitle,

    this.onNotificationTap,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 1,
      titleSpacing: 0,
      leading: IconButton(
        icon: CustomImage(imageSrc: AppAssets.drawer),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),

      actions: [
        badges.Badge(
          badgeContent: Text(
            '3',
            style: context.bodySmall.copyWith(color: AppColors.white),
          ),
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.red,
            padding: EdgeInsets.all(3),
          ),
          child: CustomImage(
            imageSrc: AppAssets.notification,
            height: 20,
            width: 20,
          ),
        ),
        SizedBox(width: 24.w),
        Container(height: 24.h, width: 1.w, color: AppColors.dividerColor),
        SizedBox(width: 24.w),
        CustomProfileAvatar(height: 28.h, width: 28.w),

        SizedBox(width: 8.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

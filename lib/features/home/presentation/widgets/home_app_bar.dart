import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final VoidCallback? onDrawerTap;

  const HomeAppBar({
    super.key,
    required this.profileName,
    required this.profileSubtitle,

    this.onNotificationTap,
    this.onCartTap,
    this.onDrawerTap,

  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 1,
      titleSpacing: 0,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(
          children: [
            CustomProfileAvatar(),

            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileName,
                  style: context.bodyLarge.copyWith(
                      fontFamily: "Poppins"
                  )
                ),
                Text(
                  profileSubtitle,
                  style: context.bodyMedium.copyWith(
                    fontFamily: "Poppins"
                  )
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: CustomImage(imageSrc: AppAssets.notification)
        ),

        IconButton(
          onPressed: onCartTap,
            icon: CustomImage(imageSrc: AppAssets.cart)
        ),
        IconButton(
          onPressed: onDrawerTap,
            icon: CustomImage(imageSrc: AppAssets.drawer)
        ),
         SizedBox(width: 8.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

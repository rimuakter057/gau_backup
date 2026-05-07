import 'package:gau_app/helper/image_handler/image_handler.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:get/get.dart';
import 'package:gau_app/features/profile/controller/profile_controller.dart'; // adjust path
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;
  final bool? isBack;

  const CustomAppBar({super.key, this.onNotificationTap, this.onCartTap, this.isBack = false});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 1,
      titleSpacing: 0,
      leading: isBack!
          ? IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_outlined),
      )
          : IconButton(
        icon: CustomImage(imageSrc: AppAssets.drawer),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        SizedBox(width: ResponsiveHelper.width(24)),
        Obx(
              () => CustomProfileAvatar(
            height: ResponsiveHelper.height(28),
            width: ResponsiveHelper.width(28),
            image: profileController.profileImage.value,
          ),
        ),
        SizedBox(width: ResponsiveHelper.width(24)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
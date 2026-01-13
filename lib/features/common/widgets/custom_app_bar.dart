import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;

  const CustomAppBar({super.key, this.onNotificationTap, this.onCartTap});

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
        GestureDetector(
          onTap: (){
            context.push(RoutesPath.notificationScreen.addBasePath);

          },

          child: Stack(
            children: [

              CustomImage(
                imageSrc: AppAssets.notification,
                height: 20,
                width: 20,
              ),

              Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                minRadius: 5,
                backgroundColor: AppColors.primaryColor,)),

            ],
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

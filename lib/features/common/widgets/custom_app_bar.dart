import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
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
                  right: 0.w,
                  top: 0,
                  child: CircleAvatar(
                minRadius: 5,
                backgroundColor: AppColors.primaryColor,)),

            ],
          ),
        ),


        SizedBox(width:  ResponsiveHelper.width(24),),
        Container(height:  ResponsiveHelper.height(24), width: ResponsiveHelper.width(1), color: AppColors.dividerColor),
        SizedBox(width: ResponsiveHelper.width(24),),
        CustomProfileAvatar(height:  ResponsiveHelper.height(28), width:  ResponsiveHelper.width(28),),

        SizedBox(width:  ResponsiveHelper.width(16),),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

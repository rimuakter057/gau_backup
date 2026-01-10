import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
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
    final Widget gap= SizedBox(height: 16.h);
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
                      child: CustomImage(
                        imageSrc: AppAssets.appLogoImage,
                      ),
                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppText.studentPortal,style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),),
                  SizedBox(height: 16.h),
                      _DrawerItem(
                        image: AppAssets.dashBoard,
                        title: AppText.dashboard,
                        onTap: () {
                          // navigate
                        },
                      ),
                     gap,
                      _DrawerItem(
                        image: AppAssets.grade,
                        title: AppText.myGradesMenu,
                        onTap: () {},
                      ),
                      gap,
                      _DrawerItem(
                        image: AppAssets.transcript,
                        title: AppText.transcriptMenu,
                        onTap: () {},
                      ),
                    gap,
                      _DrawerItem(
                        image: AppAssets.complain,
                        title: AppText.complaintsMenu,
                        onTap: () {},
                      ),
                   gap,
                      _DrawerItem(
                        image: AppAssets.message,
                        title: AppText.messageMenu,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(children: [
              const CustomDivider(color: AppColors.dividerColor),
              _DrawerItem(
                image: AppAssets.message,
                title: AppText.messageMenu,
                onTap: () {},
              ),
            ],

            ),
          )
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
    required this.onTap, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,vertical: 12.h
        ),
        backgroundColor: AppColors.softRed,

        child: Row(

          children: [
            CustomImage(imageSrc: image),
            SizedBox(width: 8.w,),
            Text(
              title,
              style: context.bodyMedium.copyWith(
                color: AppColors.labelTextColor,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}

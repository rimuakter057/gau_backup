import 'package:flutter/material.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';

import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class UserChatListWidget extends StatelessWidget {
  const UserChatListWidget({
    super.key,
    required this.name,
    required this.message,
    required this.time,
   // required this.count,
    required this.onTap,
  });

  final String name;
  final String message;
  final String time;
 // final String count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        backgroundColor: AppColors.backgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Avatar ──
            CustomProfileAvatar(),
            SizedBox(width: ResponsiveHelper.width(8)),

            // ── Name + Message ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: AppColors.titleColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(8)),

            // ── Count + Time ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: context.bodySmall,
                ),
                SizedBox(height: ResponsiveHelper.height(4)),
                // if (count.isNotEmpty && count != '0')
                //   Container(
                //     padding: EdgeInsets.all(ResponsiveHelper.borderRadius(6)),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: AppColors.primaryColor,
                //     ),
                //     child: Text(
                //       count,
                //       style: context.bodySmall.copyWith(
                //         color: AppColors.white,
                //         fontWeight: FontWeight.w700,
                //         fontSize: ResponsiveHelper.fontSize(10),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

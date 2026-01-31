import 'package:flutter/material.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';

import 'package:gau_app/utils/extension/base_extension.dart';

import 'package:gau_app/utils/color/app_colors.dart';

class ActionTextWidget extends StatelessWidget {
  final String prefixText; // Normal text
  final String actionText; // Clickable text
  final VoidCallback onActionTapped; // Function when link tapped

  const ActionTextWidget({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onActionTapped,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(prefixText,
          style: context.bodySmall.copyWith(
              color: AppColors.greyTextColor
          ),
          )
        ),
        GestureDetector(
          onTap: onActionTapped,
          child: Padding(
            padding:  EdgeInsets.only(left: ResponsiveHelper.width(12)),
            child:Text(
              actionText,
              style:context.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkRed
              ),


            ),

          ),
        ),
      ],
    );
  }
}

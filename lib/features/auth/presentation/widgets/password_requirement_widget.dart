import 'package:flutter/material.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class PasswordRequirementWidget extends StatelessWidget {
  const PasswordRequirementWidget({
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              height: ResponsiveHelper.height(10),
              width:  ResponsiveHelper.width(10),

              decoration: BoxDecoration(
                shape:BoxShape.circle,
                color: AppColors.greyTextColor,
              ),

            ),
            SizedBox(width: ResponsiveHelper.width(8),),
            Text(title,style: context.bodySmall,),
          ],
        ),


      ],

    );
  }
}
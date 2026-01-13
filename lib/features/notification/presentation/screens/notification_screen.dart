import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart'; // ❗ flutter_html import

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back_ios)),

        title: Text("Notification",
          style:   GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.titleColor,
              fontWeight: FontWeight.w600
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            children: [

              Row(
                children: [
                  CustomContainer(
                    radius: 50,
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 12.w),
                    backgroundColor: AppColors.softBlueBg,
                      child: Text("2 New",style: context.bodySmall.copyWith(
                        color: AppColors.blueColor
                      ),))
                ],

              ),
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    width: double.infinity,
                    backgroundColor: AppColors.containerGreyBgColor.withAlpha(48),
                   // padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Razco Food reply on your feedback",
                          style: context.bodyMedium,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Razco Food reply on your feedback Razco Food reply on your feedback Razco Food reply on your feedback Razco Food reply on your feedback",
                          style: context.bodySmall,
                        ),
                        SizedBox(height: 12.h),
                        Row(

                          children: [
                         CustomImage(imageSrc:AppAssets.notificationTime),
                            SizedBox(width: 8.w,),
                            Text(
                              "2 days ago",
                              style: context.bodySmall.copyWith(
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        CustomDivider()
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

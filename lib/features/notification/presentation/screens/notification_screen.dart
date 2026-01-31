import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart'; // ❗ flutter_html import

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
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
              fontSize:  ResponsiveHelper.height(14),
              color: AppColors.titleColor,
              fontWeight: FontWeight.w600
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomContainer(
                    radius: ResponsiveHelper.borderRadius(50),
                    padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(2),horizontal:  ResponsiveHelper.width(12)),
                    backgroundColor: AppColors.softBlueBg,
                      child: Text("2 New",style: context.bodySmall.copyWith(
                        color: AppColors.blueColor
                      ),)),

                  CustomContainer(
                      radius: ResponsiveHelper.borderRadius(50),
                      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(2),horizontal: ResponsiveHelper.width(12)),
                      backgroundColor: AppColors.containerGreyBgColor,
                      child:  Row(

                        children: [
                          CustomImage(imageSrc:AppAssets.notificationMark),
                          SizedBox(width: ResponsiveHelper.width(8),),
                          Text(
                            "Mark all read",
                            style: context.bodySmall.copyWith(
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),

                  ),
                ],

              ),
              SizedBox(height: ResponsiveHelper.height(6)),
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {


                  return CustomContainer(
                    width: double.infinity,
                    backgroundColor: AppColors.containerGreyBgColor.withAlpha(48),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(ResponsiveHelper.padding(6)),
                              decoration: BoxDecoration(
                                color: AppColors.twoFactorBg,
                                shape: BoxShape.circle
                              ),
                              child:Icon(Icons.message_outlined,color: AppColors.blueColor,)
                              // CustomImage(
                              //   imageSrc: AppAssets.twoFactor,
                              // ),
                            ),
                            SizedBox(width:ResponsiveHelper.width(4)),
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "Razco Food reply on your feedback",
                                style: context.bodyMedium,
                              ),
                            ),
                          ],
                        ),


                        Padding(
                          padding:  EdgeInsets.only(left: ResponsiveHelper.padding(38)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: ResponsiveHelper.height(12)),
                              Text(
                                "Razco Food reply on your feedback Razco Food reply on your feedback Razco Food reply on your feedback Razco Food reply on your feedback",
                                style: context.bodySmall,
                              ),
                              SizedBox(height: ResponsiveHelper.height(12)),
                              Row(

                                children: [
                               CustomImage(imageSrc:AppAssets.notificationTime),
                                  SizedBox(width: ResponsiveHelper.width(8),),
                                  Text(
                                    "2 days ago",
                                    style: context.bodySmall.copyWith(
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ResponsiveHelper.height(12)),
                            ],
                          ),
                        ),
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

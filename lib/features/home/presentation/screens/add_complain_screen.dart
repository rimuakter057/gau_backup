import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class AddComplainScreen extends StatelessWidget {
  const AddComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomContainer(

                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.submitAComplaint, style: context.titleMedium),
                    SizedBox(height: 4.h),
                    Text(AppText.trackStatusAndUpdates, style: context.bodySmall),

                  ],
                ),
              ),

              SizedBox(height: 24.h),
              CustomContainer(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 33.h),
                backgroundColor: AppColors.containerGreyBgColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.roommateIssue, style: context.titleMedium),
                    SizedBox(height: 4.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        CustomContainer(
                          radius: 50.r,
                          backgroundColor: AppColors.softBlueBg,
                          borderColor: AppColors.softBlueBorder,
                          child: Text(
                            AppText.roommateIssue,
                            style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.blueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ///details column============================================================
                    SizedBox(height: 4.h),
                    _buildRowText(context, title: AppText.idLabel, text: "02"),
                    SizedBox(height: 8.h),
                    _buildRowText(
                      context,
                      title: AppText.categoryLabel,
                      text: "Housing",
                    ),
                    SizedBox(height: 8.h),
                    _buildRowText(
                      context,
                      title: AppText.submittedLabel,
                      text: "01/11/2026",
                    ),
                    ///complain description===========================================================================
                    CustomContainer(
                      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      backgroundColor: AppColors.containerGreyBgColor,
                      width: double.infinity,
                      borderColor: AppColors.softBlueBorder,
                      child: Text(
                        maxLines: 5,
                        AppText.complaintDescription,
                        style: context.bodySmall,
                      ),
                    ),
                    ///status timeline------------------------------------------------------
                    Text(AppText.statusTimeline, style: context.titleMedium),
                    SizedBox(height: 8.h),

                    ///status pending===================================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.pendingBgColor,
                                ),
                                child: CustomImage(imageSrc: AppAssets.pending)
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              AppText.pending,
                              style: context.bodyLarge,
                            ),
                          ],
                        ),
                        Text(
                          "01/11/2026",
                          style: context.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 26.h),
                    ///status In Progress===================================================================
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueColor,
                        ),
                        child: CustomImage(
                          imageSrc: AppAssets.inProgress,
                        ),
                      ),
                      title: Text(
                        AppText.inProgress,
                        style: context.bodyLarge,
                      ),
                      subtitle: Text(
                        AppText.inProgressStatus,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodySmall,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "01/11/2026",
                            style: context.bodySmall,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            AppText.bySystem,
                            style: context.bodySmall,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildRowText(
      BuildContext context, {
        required String title,
        required String text,
      }) {
    return Row(
      children: [
        Text(
          title,
          style: context.bodyMedium.copyWith(color: AppColors.greyTextColor),
        ),
        SizedBox(width: 2.w),
        Text(
          text,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

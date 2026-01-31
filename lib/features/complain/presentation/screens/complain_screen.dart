import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/home/controller/home_controller.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ComplainScreen extends StatelessWidget {
   ComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(


        onNotificationTap: () {
          // context.pushNamed(RoutePath.notificationScreen);
        },
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.height(16)),
          child: Column(
            children: [
              CustomContainer(
                padding: EdgeInsets.all( ResponsiveHelper.padding(24)),
                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.myComplaints, style: context.titleMedium),
                    SizedBox(height:  ResponsiveHelper.height(4)),
                    Text(AppText.trackStatusAndUpdates, style: context.bodySmall),
                    SizedBox(height:  ResponsiveHelper.height(24)),
        
                    ElevatedButton(
                      onPressed: () {

                        context.push(RoutesPath.addComplainScreen.addBasePath);

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppAssets.add),
        
                          SizedBox(width:  ResponsiveHelper.width(12)),
                          Text(AppText.complaint),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
              SizedBox(height:  ResponsiveHelper.height(24)),
              CustomContainer(
                padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.width(16),
                    vertical: ResponsiveHelper.height(33)
                ),
                backgroundColor: AppColors.containerGreyBgColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.roommateIssue, style: context.titleMedium),
                    SizedBox(height:  ResponsiveHelper.height(4)),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        CustomContainer(
                          radius: ResponsiveHelper.height(50),
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
                    SizedBox(height:  ResponsiveHelper.height(4)),
                    _buildRowText(context, title: AppText.idLabel, text: "02"),
                    SizedBox(height:  ResponsiveHelper.height(8)),
                    _buildRowText(
                      context,
                      title: AppText.categoryLabel,
                      text: "Housing",
                    ),
                    SizedBox(height:  ResponsiveHelper.height(8)),
                    _buildRowText(
                      context,
                      title: AppText.submittedLabel,
                      text: "01/11/2026",
                    ),
                  ///complain description===========================================================================
                    CustomContainer(
                      margin: EdgeInsets.symmetric(
                          horizontal:  ResponsiveHelper.padding(16),
                          vertical:  ResponsiveHelper.padding(32)
                      ),
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
                SizedBox(height:  ResponsiveHelper.height(8)),
                
                ///status pending===================================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all( ResponsiveHelper.borderRadius(6)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.pendingBgColor,
                          ),
                          child: CustomImage(imageSrc: AppAssets.pending)
                        ),
                        SizedBox(width: ResponsiveHelper.width(12)),
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
                    SizedBox(height: ResponsiveHelper.height(26)),
                    ///status In Progress===================================================================
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all( ResponsiveHelper.borderRadius(6)),
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
                          SizedBox(height:  ResponsiveHelper.height(2)),
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
        SizedBox(width:  ResponsiveHelper.width(2)),
        Text(
          text,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

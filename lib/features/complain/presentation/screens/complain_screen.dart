import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class ComplainScreen extends StatelessWidget {
  ComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onNotificationTap: () {
          context.pushNamed(RoutesPath.notificationScreen);
        },
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.height(16),
          ),
          child: Column(
            children: [
              CustomContainer(
                padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.myComplaints, style: context.titleMedium),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Text(
                      AppText.trackStatusAndUpdates,
                      style: context.bodySmall,
                    ),
                    SizedBox(height: ResponsiveHelper.height(24)),

                    ElevatedButton(
                      onPressed: () {
                        context.push(RoutesPath.addComplainScreen.addBasePath);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppAssets.add),

                          SizedBox(width: ResponsiveHelper.width(12)),
                          Text(AppText.complaint),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(24)),

              ListView.builder(
                itemCount: 15,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(RoutesPath.complainDetailsScreen);
                      },
                      child: Card(
                        color: AppColors.white,
                        child: Padding(
                          padding: ResponsiveHelper.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Roommate Issue"),

                                  CustomContainer(
                                    padding: ResponsiveHelper.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    backgroundColor: AppColors.white,
                                    borderColor: AppColors.primaryColor,
                                    child: Text(
                                      AppText.inProgress,
                                      style: context.bodySmall.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ResponsiveHelper.spacing(6)),
                              Text(
                                "Description Description Description Description Description Description",
                                style: context.bodySmall.copyWith(
                                  color: AppColors.greyTextColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
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

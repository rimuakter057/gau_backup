import 'package:flutter/material.dart';

import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/profile/controller/profile_controller.dart';
import 'package:gau_app/features/profile/presentation/widgets/personal_info_widget.dart';
import 'package:gau_app/features/profile/presentation/widgets/security_widget.dart';
import 'package:gau_app/helper/image_handler/image_handler.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';

import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';

import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  int selectedTab = 0;

  final TextEditingController controller = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchProfile();
    });

  }

  @override
  Widget build(BuildContext context) {

    final gap = SizedBox(height: ResponsiveHelper.height(16));

    return Scaffold(

      appBar: CustomAppBar(),

      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),

      body: SingleChildScrollView(

        child: Column(

          children: [

            /// ================= PROFILE CONTAINER =================

            CustomContainer(

              padding: EdgeInsets.all(ResponsiveHelper.padding(24)),

              width: double.infinity,

              backgroundColor: AppColors.containerGreyBgColor,

              borderColor: AppColors.inputBorderColor,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(AppText.profileSettings,
                      style: context.titleMedium),

                  SizedBox(height: 4),

                  Text(AppText.manageAccountSubtitle,
                      style: context.bodySmall),

                ],

              ),

            ),

            SizedBox(height: 20),

            /// ================= CARD =================

            Card(

              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(8)),

              color: AppColors.containerGreyBgColor,

              elevation: 10,

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadius(12)),

              ),

              child: Padding(

                padding: EdgeInsets.all(ResponsiveHelper.padding(16)),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    /// PROFILE ROW






                    Obx(() {
                      if (profileController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Row(
                        children: [
                          Stack(
                            children: [
                              CustomProfileAvatar(
                                image:ImageHandler.imagesHandle( profileController.profileImage.value,)
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(ResponsiveHelper.width(4)),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: ResponsiveHelper.width(2),
                                    ),
                                  ),
                                  child: CustomImage(
                                    imageSrc: AppAssets.camera,
                                    height: ResponsiveHelper.iconSize(6),
                                    width: ResponsiveHelper.iconSize(6),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 8),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileController.name.value,
                                style: context.bodyMedium,
                              ),
                              Text(
                                profileController.userId.value,
                                style: context.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    
                    
                    
                    
                    // Row(
                    //
                    //   children: [
                    //
                    //     Stack(
                    //       children: [
                    //         CustomProfileAvatar(
                    //           image:ImageHandler.imagesHandle(url) ,
                    //         ),
                    //         Positioned(
                    //           bottom: 0,
                    //           right: 0,
                    //           child: Container(
                    //             padding: EdgeInsets.all(ResponsiveHelper.width(4)),
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: AppColors.white,
                    //               border: Border.all(
                    //                 color: AppColors.primaryColor,
                    //                 width: ResponsiveHelper.width(2),
                    //               ),
                    //             ),
                    //             child: CustomImage(
                    //               imageSrc: AppAssets.camera,
                    //               height: ResponsiveHelper.iconSize(6),
                    //               width:ResponsiveHelper.iconSize(6),
                    //               fit: BoxFit.contain,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //
                    //     SizedBox(width: 8),
                    //
                    //     Column(
                    //
                    //       crossAxisAlignment:
                    //       CrossAxisAlignment.start,
                    //
                    //       children: [
                    //
                    //         Text("Aroshi Rusha",
                    //             style: context.bodyMedium),
                    //
                    //         Text("id",
                    //             style: context.bodySmall),
                    //
                    //       ],
                    //
                    //     ),
                    //
                    //   ],
                    //
                    // ),

                    SizedBox(height: 8),

                    CustomDivider(),

                    /// ================= TAB ROW =================

                    SecurityWidget(gap: gap, ),



                  ],

                ),

              ),

            ),

            SizedBox(height: 40),

          ],

        ),

      ),

    );

  }

}





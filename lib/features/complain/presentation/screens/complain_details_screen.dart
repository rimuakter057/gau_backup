import 'package:flutter/material.dart';
import 'package:gau_app/features/complain/models/complain_model.dart';
import 'package:get/get.dart';
import 'package:gau_app/features/home/controller/home_controller.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/utils/app_text/app_text.dart';

class ComplainDetailsScreen extends StatefulWidget {
  final String complainId;
  ComplainDetailsScreen({super.key, required this.complainId});

  @override
  State<ComplainDetailsScreen> createState() => _ComplainDetailsScreenState();
}

class _ComplainDetailsScreenState extends State<ComplainDetailsScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch complaint when screen builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchComplainDetails(id: widget.complainId);
    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        leading: Padding(
          padding: EdgeInsets.only(left: ResponsiveHelper.padding(16)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CustomImage(
                imageSrc: AppAssets.back,
                height: ResponsiveHelper.iconSize(24),
                width: ResponsiveHelper.iconSize(24),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: Text("Complain Details", style: context.bodyMedium.copyWith(fontSize: 18)),
      ),
      // body: Obx(() {
      //   if (controller.complainDetails.isEmpty) {
      //     return const Center(child: CircularProgressIndicator());
      //   }
      //
      //   final complain = controller.complainDetails.first;
      //
      //   return SingleChildScrollView(
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(
      //         horizontal: ResponsiveHelper.height(16),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           SizedBox(height: ResponsiveHelper.height(24)),
      //
      //           CustomContainer(
      //             padding: EdgeInsets.symmetric(
      //               horizontal: ResponsiveHelper.width(16),
      //               vertical: ResponsiveHelper.height(33),
      //             ),
      //             backgroundColor: AppColors.containerGreyBgColor,
      //             width: double.infinity,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   complain.subject ?? "",
      //                   style: context.bodyMedium.copyWith(
      //                     fontFamily: "inter",
      //                     fontWeight: FontWeight.w500,
      //                     fontSize: ResponsiveHelper.fontSize(16),
      //                   ),
      //                 ),
      //                 SizedBox(height: ResponsiveHelper.height(4)),
      //
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     SizedBox(),
      //                     CustomContainer(
      //                       radius: ResponsiveHelper.height(50),
      //                       backgroundColor: AppColors.softBlueBg,
      //                       borderColor: AppColors.softBlueBorder,
      //                       child: Text(
      //                         complain.status ?? "",
      //                         style: context.bodySmall.copyWith(
      //                           fontWeight: FontWeight.w700,
      //                           color: AppColors.blueColor,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: ResponsiveHelper.height(8)),
      //                 _buildRowText(
      //                   context,
      //                   title: AppText.idLabel,
      //                   text: complain.id ?? "",
      //                 ),
      //                 SizedBox(height: ResponsiveHelper.height(8)),
      //                 _buildRowText(
      //                   context,
      //                   title: AppText.categoryLabel,
      //                   text: complain.category ?? "",
      //                 ),
      //                 SizedBox(height: ResponsiveHelper.height(8)),
      //                 _buildRowText(
      //                   context,
      //                   title: AppText.submittedLabel,
      //                   text: complain.createdAt?.split("T").first ?? "",
      //                 ),
      //
      //                 SizedBox(height: ResponsiveHelper.height(16)),
      //                 CustomContainer(
      //                   margin: EdgeInsets.symmetric(
      //                     horizontal: ResponsiveHelper.padding(0),
      //                     vertical: ResponsiveHelper.padding(16),
      //                   ),
      //                   backgroundColor: AppColors.containerGreyBgColor,
      //                   width: double.infinity,
      //                   borderColor: AppColors.softBlueBorder,
      //                   child: Text(
      //                     complain.description ?? "",
      //                     maxLines: 5,
      //                     style: context.bodySmall,
      //                   ),
      //                 ),
      //
      //                 SizedBox(height: ResponsiveHelper.height(16)),
      //                 Text(AppText.statusTimeline,
      //                   style: context.bodyMedium.copyWith(
      //                     fontFamily: "inter",
      //                     fontWeight: FontWeight.w500,
      //                     fontSize: ResponsiveHelper.fontSize(16),
      //                     color: AppColors.black
      //                   ),
      //                 ),
      //                 SizedBox(height: ResponsiveHelper.height(8)),
      //                 ..._buildStatusTimeline(
      //                   complain: complain,
      //                   context: context,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // }),


      body: Obx(() {

        if (controller.isDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final complain = controller.complainDetails.value;

        if (complain == null) {
          return const Center(child: Text("No Data Found"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.height(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveHelper.height(24)),

                CustomContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(16),
                    vertical: ResponsiveHelper.height(33),
                  ),
                  backgroundColor: AppColors.containerGreyBgColor,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// SUBJECT (same design)
                      Text(
                        complain.subject ?? "",
                        style: context.bodyMedium.copyWith(
                          fontFamily: "inter",
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveHelper.fontSize(16),
                        ),
                      ),

                      SizedBox(height: ResponsiveHelper.height(4)),

                      /// STATUS (same design)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          CustomContainer(
                            radius: ResponsiveHelper.height(50),
                            backgroundColor: AppColors.softBlueBg,
                            borderColor: AppColors.softBlueBorder,
                            child: Text(
                              complain.status ?? "",
                              style: context.bodySmall.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: ResponsiveHelper.height(8)),

                      _buildRowText(
                        context,
                        title: AppText.idLabel,
                        text: complain.id ?? "",
                      ),

                      SizedBox(height: ResponsiveHelper.height(8)),

                      _buildRowText(
                        context,
                        title: AppText.categoryLabel,
                        text: complain.category ?? "",
                      ),

                      SizedBox(height: ResponsiveHelper.height(8)),

                      _buildRowText(
                        context,
                        title: AppText.submittedLabel,
                        text: complain.createdAt?.split("T").first ?? "",
                      ),

                      SizedBox(height: ResponsiveHelper.height(16)),

                      /// DESCRIPTION (same)
                      CustomContainer(
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.padding(0),
                          vertical: ResponsiveHelper.padding(16),
                        ),
                        backgroundColor: AppColors.containerGreyBgColor,
                        width: double.infinity,
                        borderColor: AppColors.softBlueBorder,
                        child: Text(
                          complain.description ?? "",
                          maxLines: 5,
                          style: context.bodySmall,
                        ),
                      ),

                      SizedBox(height: ResponsiveHelper.height(16)),

                      /// STATUS TIMELINE TITLE
                      Text(
                        AppText.statusTimeline,
                        style: context.bodyMedium.copyWith(
                          fontFamily: "inter",
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveHelper.fontSize(16),
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: ResponsiveHelper.height(8)),

                      ..._buildStatusTimeline(
                        complain: complain,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),






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
        SizedBox(width: ResponsiveHelper.width(2)),
        Text(
          text,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  List<Widget> _buildStatusTimeline({
    required ComplainModel complain,
    required BuildContext context,
  }) {
    return complain.statusTimeline?.map((status) {
          Color statusColor;
          String statusIcon;

          switch ((status.status ?? "").toLowerCase()) {
            case 'pending':
              statusColor = AppColors.pendingBgColor;
              statusIcon = AppAssets.pending;
              break;
            case 'in progress':
              statusColor = AppColors.blueColor;
              statusIcon = AppAssets.inProgress;
              break;
            case 'resolved':
              statusColor = AppColors.primaryColor;
              statusIcon = AppAssets.pending;
              break;
            default:
              statusColor = AppColors.greyTextColor;
              statusIcon = AppAssets.pending;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(ResponsiveHelper.borderRadius(6)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                    child: CustomImage(imageSrc: statusIcon),
                  ),
                  SizedBox(width: ResponsiveHelper.width(12)),
                  Text(status.status ?? "", style: context.bodyLarge),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status.changedAt?.split("T").first ?? "",
                    style: context.bodySmall,
                  ),
                  SizedBox(height: ResponsiveHelper.height(2)),
                  Text(status.changedBy ?? "", style: context.bodySmall),
                ],
              ),
            ],
          );
        }).toList() ??
        [];
  }
}

// import 'package:flutter/material.dart';
// import 'package:gau_app/features/home/controller/home_controller.dart';
// import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
// import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
// import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
// import 'package:gau_app/utils/app_assets/app_assets.dart';
// import 'package:gau_app/utils/app_text/app_text.dart';
// import 'package:gau_app/utils/color/app_colors.dart';
// import 'package:gau_app/utils/extension/base_extension.dart';
// import 'package:get/get.dart';
//
//
// class ComplainDetailsScreen extends StatelessWidget {
//   ComplainDetailsScreen({super.key});
//   final HomeController controller = Get.find<HomeController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//
//       appBar: AppBar(
//         leadingWidth: 40,
//         leading: Padding(
//           padding:  EdgeInsets.only(left:ResponsiveHelper.padding(16)),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: CustomImage(
//                 imageSrc: AppAssets.back,
//                 height: ResponsiveHelper.iconSize(24), // ekdom fixed value use koro test er jonno
//                 width: ResponsiveHelper.iconSize(24),
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ),
//         title: Text(
//           "Complain Details",
//           style: context.bodyMedium,
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.height(16)),
//           child: Column(
//             children: [
//
//
//               SizedBox(height:  ResponsiveHelper.height(24)),
//               CustomContainer(
//                 padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.width(16),
//                     vertical: ResponsiveHelper.height(33)
//                 ),
//                 backgroundColor: AppColors.containerGreyBgColor,
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(AppText.roommateIssue, style: context.titleMedium),
//                     SizedBox(height:  ResponsiveHelper.height(4)),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(),
//                         CustomContainer(
//                           radius: ResponsiveHelper.height(50),
//                           backgroundColor: AppColors.softBlueBg,
//                           borderColor: AppColors.softBlueBorder,
//                           child: Text(
//                             AppText.roommateIssue,
//                             style: context.bodySmall.copyWith(
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.blueColor,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ///details column============================================================
//                     SizedBox(height:  ResponsiveHelper.height(4)),
//                     _buildRowText(context, title: AppText.idLabel, text: "02"),
//                     SizedBox(height:  ResponsiveHelper.height(8)),
//                     _buildRowText(
//                       context,
//                       title: AppText.categoryLabel,
//                       text: "Housing",
//                     ),
//                     SizedBox(height:  ResponsiveHelper.height(8)),
//                     _buildRowText(
//                       context,
//                       title: AppText.submittedLabel,
//                       text: "01/11/2026",
//                     ),
//                     ///complain description===========================================================================
//                     CustomContainer(
//                       margin: EdgeInsets.symmetric(
//                           horizontal:  ResponsiveHelper.padding(16),
//                           vertical:  ResponsiveHelper.padding(32)
//                       ),
//                       backgroundColor: AppColors.containerGreyBgColor,
//                       width: double.infinity,
//                       borderColor: AppColors.softBlueBorder,
//                       child: Text(
//                         maxLines: 5,
//                         AppText.complaintDescription,
//                         style: context.bodySmall,
//                       ),
//                     ),
//                     ///status timeline------------------------------------------------------
//                     Text(AppText.statusTimeline, style: context.titleMedium),
//                     SizedBox(height:  ResponsiveHelper.height(8)),
//
//                     ///status pending===================================================================
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                                 padding: EdgeInsets.all( ResponsiveHelper.borderRadius(6)),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: AppColors.pendingBgColor,
//                                 ),
//                                 child: CustomImage(imageSrc: AppAssets.pending)
//                             ),
//                             SizedBox(width: ResponsiveHelper.width(12)),
//                             Text(
//                               AppText.pending,
//                               style: context.bodyLarge,
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "01/11/2026",
//                           style: context.bodySmall,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: ResponsiveHelper.height(26)),
//                     ///status In Progress===================================================================
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: Container(
//                         padding: EdgeInsets.all( ResponsiveHelper.borderRadius(6)),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColors.blueColor,
//                         ),
//                         child: CustomImage(
//                           imageSrc: AppAssets.inProgress,
//                         ),
//                       ),
//                       title: Text(
//                         AppText.inProgress,
//                         style: context.bodyLarge,
//                       ),
//                       subtitle: Text(
//                         AppText.inProgressStatus,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: context.bodySmall,
//                       ),
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "01/11/2026",
//                             style: context.bodySmall,
//                           ),
//                           SizedBox(height:  ResponsiveHelper.height(2)),
//                           Text(
//                             AppText.bySystem,
//                             style: context.bodySmall,
//                           ),
//                         ],
//                       ),
//                     ),
//
//
//
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row _buildRowText(
//       BuildContext context, {
//         required String title,
//         required String text,
//       })
//   {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: context.bodyMedium.copyWith(color: AppColors.greyTextColor),
//         ),
//         SizedBox(width:  ResponsiveHelper.width(2)),
//         Text(
//           text,
//           style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }
// }

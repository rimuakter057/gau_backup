import 'package:flutter/material.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/features/home/controller/home_controller.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddComplainScreen extends StatelessWidget {
  AddComplainScreen({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),

        title: Text(
          AppText.complaint,
          style: GoogleFonts.poppins(
            fontSize: ResponsiveHelper.fontSize(14),
            color: AppColors.titleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
          child: Column(
            children: [
              CustomContainer(
                padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
                width: double.infinity,
                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.submitAComplaint, style: context.titleMedium),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Text(AppText.complaintSubtitle, style: context.bodySmall),
                  ],
                ),
              ),

              /// add complain form =======================================================================================
              SizedBox(height: ResponsiveHelper.height(20)),
              CustomContainer(
                padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
                width: double.infinity,
                backgroundColor: AppColors.white,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Selection
                    Text(AppText.category, style: context.bodyMedium),
                    SizedBox(height: ResponsiveHelper.height(8)),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectCategory,
                      list: AppText.categoryList,
                      selectedValue: controller.selectedCategory,
                      onChanged: controller.setCategory,
                    ),

                    SizedBox(height: ResponsiveHelper.height(16)),

                    // Complaint Details
                    Text(AppText.priorityLevel, style: context.bodyMedium),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectLevel,
                      list: AppText.priorityList,
                      selectedValue: controller.selectedPriority,
                      onChanged: controller.setPriority,
                    ),

                    SizedBox(height: ResponsiveHelper.height(16)),

                    Text(AppText.subjectLine, style: context.bodyMedium),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: AppText.subjectHint,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),
                    Text(AppText.description, style: context.bodyMedium),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),

                    // Attachment Section
                    Text(
                      AppText.attachmentsOptional,
                      style: context.titleSmall,
                    ),
                    SizedBox(height: ResponsiveHelper.height(8)),

                    ///add file =====================================
                    GestureDetector(
                      onTap: () {
                        controller.pickFile();
                      },
                      child: Obx(() {
                        return CustomContainer(
                          padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
                          width: double.infinity,
                          backgroundColor: AppColors.containerGreyBgColor,
                          borderColor: AppColors.inputBorderColor,
                          child: Column(
                            children: [
                              // যদি file select করা থাকে, নাম দেখাবে
                              if (controller.selectedFile.value != null)
                                Text(
                                  'Selected: ${controller.selectedFile.value!.path.split('/').last}',
                                  style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              else
                                CustomImage(
                                  imageSrc: AppAssets.updateDoc,
                                ), // default icon

                              SizedBox(height: ResponsiveHelper.height(4)),

                              Text(
                                AppText.clickToUpload,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: ResponsiveHelper.height(2)),
                              Text(
                                textAlign: TextAlign.center,
                                AppText.acceptedFormats,
                                style: context.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: ResponsiveHelper.height(30)),

                    // Submit Button
                    CancelSaveRowButtonWidget(
                      onTapTitle: () {},

                      title: AppText.submitRequest,
                    ),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context, {
    required List<String> list,
    required String hint,
    required RxnString selectedValue,
    required Function(String) onChanged,
  }) {
    return Obx(() {
      return CustomContainer(
        backgroundColor: AppColors.containerGreyBgColor,
        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(12)),
        borderColor: AppColors.inputBorderColor,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedValue.value,
            icon: CustomImage(imageSrc: AppAssets.dropDown),
            hint: Text(hint, style: context.bodySmall),
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: context.bodyMedium),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ),
      );
    });
  }
}

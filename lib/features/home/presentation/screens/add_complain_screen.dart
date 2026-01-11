import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

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
                padding: EdgeInsets.all(24),
                width: double.infinity,
                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.submitAComplaint, style: context.titleMedium),
                    SizedBox(height: 4.h),
                    Text(AppText.complaintSubtitle, style: context.bodySmall),
                  ],
                ),
              ),

              /// add complain from=======================================================================================

              /// add complain form =======================================================================================
              SizedBox(height: 20.h),
              CustomContainer(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                backgroundColor: AppColors.white,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Selection
                    Text(AppText.category, style: context.bodyMedium),
                    SizedBox(height: 8.h),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectCategory,
                      list: [
                        AppText.academicIssue,
                        AppText.housingFacilities,
                        AppText.financialAid,
                        AppText.harassmentConduct,
                        AppText.othersReason,
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Complaint Details
                    Text(AppText.priorityLevel, style: context.bodyMedium),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectLevel,
                      list: [
                        AppText.lowGeneralInquiry,
                        AppText.mediumNeedsAttention,
                        AppText.highUrgentIssue,
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Complaint Details
                    Text(AppText.selectCourse, style: context.bodyMedium),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectCourse,
                      list: [
                        AppText.cs301DataStructures,
                        AppText.math301LinearAlgebra,
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(AppText.selectReason, style: context.bodyMedium),
                    SizedBox(height: 8.h),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectReason,
                      list: [
                        AppText.calculationError,
                        AppText.missingAssignmentGrade,
                        AppText.finalExamDispute,
                        AppText.harassmentConduct,
                      ],
                    ),

                    SizedBox(height: 16.h),
                    Text(AppText.subjectLine, style: context.bodyMedium),
                    SizedBox(height: 4.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: AppText.subjectHint,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(AppText.description, style: context.bodyMedium),
                    SizedBox(height: 4.h),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Attachment Section
                    Text(
                      AppText.attachmentsOptional,
                      style: context.titleSmall,
                    ),
                    SizedBox(height: 8.h),
                    CustomContainer(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      backgroundColor: AppColors.containerGreyBgColor,
                      borderColor: AppColors.inputBorderColor,
                      child: Column(
                        children: [
                          CustomImage(imageSrc: AppAssets.updateDoc),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppText.clickToUpload,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                AppText.dragAndDrop,
                                style: context.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            textAlign: TextAlign.center,
                            AppText.acceptedFormats,
                            style: context.bodySmall,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Submit Button
                    CancelSaveRowButtonWidget(
                      onTapTitle: () {},

                      title: AppText.submitRequest,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
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
  }) {
    return CustomContainer(
      backgroundColor: AppColors.containerGreyBgColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      borderColor: AppColors.inputBorderColor,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: context.bodySmall),
          items: list.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}

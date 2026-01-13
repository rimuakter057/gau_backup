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
import 'package:google_fonts/google_fonts.dart';

class AddComplainScreen extends StatelessWidget {
  const AddComplainScreen({super.key});

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
            fontSize: 14,
            color: AppColors.titleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

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
                      list: AppText.categoryList,
                    ),

                    SizedBox(height: 16.h),

                    // Complaint Details
                    Text(AppText.priorityLevel, style: context.bodyMedium),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectLevel,
                      list: AppText.priorityList,
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

                    ///add file =====================================
                    CustomContainer(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      backgroundColor: AppColors.containerGreyBgColor,
                      borderColor: AppColors.inputBorderColor,
                      child: Column(
                        children: [
                          CustomImage(imageSrc: AppAssets.updateDoc),
                          Text(
                            AppText.clickToUpload,
                            style: context.bodyMedium.copyWith(
                              color: AppColors.primaryColor,
                            ),
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
          icon: CustomImage(imageSrc: AppAssets.dropDown),
          hint: Text(hint, style: context.bodySmall),
          items: list.map((String value) {
            return DropdownMenuItem<String>(value: value,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.containerGreyBgColor
                    // color: selectedValue == value
                    //     ? Colors.blue.shade50
                    //     : Colors.transparent,
                  ),
                  child:Text(value,style: context.bodyMedium,)
                ),


               // child: Text(value,style: context.bodyMedium,)


            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}

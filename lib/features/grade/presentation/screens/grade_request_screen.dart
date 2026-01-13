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

class GradeRequestScreen extends StatelessWidget {
  const GradeRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Widget gap=    SizedBox(height: 18.h);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back_ios)),

        title: Text(AppText.requestGradeVerification,
          style:   GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.titleColor,
              fontWeight: FontWeight.w600
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
                backgroundColor: AppColors.softBlueBg,
                borderColor: AppColors.softBlueBorder,
                child: Text(


                    AppText.gradeVerificationDescription, style: context.bodySmall),
              ),

              /// add complain from=======================================================================================

              /// add complain form =======================================================================================
             gap,
              CustomContainer(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                backgroundColor: AppColors.white,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                    /// select course ==================================
                    Text(AppText.selectCourse, style: context.bodyMedium),
                    SizedBox(height: 8.h),
                    _buildDropdownField(
                      context,
                      hint: AppText.selectCourse,
                      list: [
                        AppText.cs301DataStructures,
                        AppText.math301LinearAlgebra,
                      ],
                    ),
                   gap,
                    /// select reason ==================================
                    Text(AppText.reasonForRequest, style: context.bodyMedium),
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

                   gap,

                    Text(AppText.additionalDetails, style: context.bodyMedium),
                    SizedBox(height: 4.h),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppText.discrepancyHint,
                      ),
                    ),

                    gap,
                    gap,

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

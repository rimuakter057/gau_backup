import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GradeRequestScreen extends StatefulWidget {
  const GradeRequestScreen({super.key});

  @override
  State<GradeRequestScreen> createState() => _GradeRequestScreenState();
}

class _GradeRequestScreenState extends State<GradeRequestScreen> {
  String? selectedCourse;
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height:  ResponsiveHelper.height(18));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          AppText.requestGradeVerification,
          style: GoogleFonts.poppins(
            fontSize:  ResponsiveHelper.fontSize(14),
            color: AppColors.titleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.width(16)),
        child: Column(
          children: [
            CustomContainer(
              padding:  EdgeInsets.all( ResponsiveHelper.padding(24)),
              width: double.infinity,
              backgroundColor: AppColors.softBlueBg,
              borderColor: AppColors.softBlueBorder,
              child: Text(
                AppText.gradeVerificationDescription,
                style: context.bodySmall,
              ),
            ),

            gap,

            CustomContainer(
              padding:  EdgeInsets.all( ResponsiveHelper.padding(16)),
              width: double.infinity,
              backgroundColor: AppColors.white,
              borderColor: AppColors.inputBorderColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Select Course
                  Text(AppText.selectCourse, style: context.bodyMedium),
                  SizedBox(height:  ResponsiveHelper.height(8)),
                  _buildDropdownField(
                    context,
                    hint: AppText.selectCourse,
                    list: AppText.selectCourseList,
                    value: selectedCourse,
                    onChanged: (val) {
                      setState(() {
                        selectedCourse = val;
                      });
                    },
                  ),

                  gap,

                  /// Select Reason
                  Text(AppText.reasonForRequest, style: context.bodyMedium),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  _buildDropdownField(
                    context,
                    hint: AppText.selectReason,
                    list: AppText.selectReasonList,
                    value: selectedReason,
                    onChanged: (val) {
                      setState(() {
                        selectedReason = val;
                      });
                    },
                  ),

                  gap,

                  /// Additional Details
                  Text(AppText.additionalDetails, style: context.bodyMedium),
                  SizedBox(height:  ResponsiveHelper.height(4)),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: AppText.discrepancyHint,
                    ),
                  ),

                  gap,
                  gap,

                  CancelSaveRowButtonWidget(
                    onTapTitle: () {},
                    title: AppText.submitRequest,
                  ),
                ],
              ),
            ),

            SizedBox(height:ResponsiveHelper.height(24)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      BuildContext context, {
        required List<String> list,
        required String hint,
        required String? value,
        required Function(String?) onChanged,
      }) {
    return CustomContainer(
      backgroundColor: AppColors.containerGreyBgColor,
      padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.width(12)),
      borderColor: AppColors.inputBorderColor,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: context.bodySmall),
          items: list
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: context.bodyMedium),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

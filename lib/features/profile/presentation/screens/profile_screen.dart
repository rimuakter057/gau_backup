import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/auth/presentation/widgets/title_widget.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

                   TitleWidget(title: AppText.firstName,),

                    SizedBox(height: 4.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: AppText.subjectHint,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TitleWidget(title: AppText.lastName,),
                    SizedBox(height: 4.h),
                    TextFormField(

                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Attachment Section
                    TitleWidget(title: AppText.studentId,),
                    SizedBox(height: 8.h),
                    TextFormField(

                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Attachment Section
                    TitleWidget(title: AppText.email,),
                    SizedBox(height: 8.h),
                    TextFormField(

                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Attachment Section
                    TitleWidget(title: AppText.phoneNumber,),
                    SizedBox(height: 8.h),
                    TextFormField(

                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Attachment Section
                    TitleWidget(title: AppText.dormAddress,),
                    SizedBox(height: 8.h),
                    TextFormField(

                      decoration: InputDecoration(
                        hintText: AppText.descriptionHint,
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


}

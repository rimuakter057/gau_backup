import 'package:flutter/material.dart';
import 'package:gau_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:gau_app/features/common/widgets/cancel_save_button_row.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({
    super.key,
    required this.controller,
    required this.gap,
  });

  final TextEditingController controller;
  final Widget gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        ///first name===================================================
        InputFieldWidget(
          title: AppText.firstName,
          hint: AppText.subjectHint,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your ';
            }
            return null;
          },
        ),
        gap,

        ///last name===================================================
        InputFieldWidget(
          title: AppText.lastName,
          hint: AppText.descriptionHint,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your ';
            }
            return null;
          },
        ),
        gap,

        ///student Id field===================================================
        InputFieldWidget(
          title: AppText.studentId,
          hint: AppText.descriptionHint,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your ';
            }
            return null;
          },
        ),
        gap,

        ///email field===================================================
        InputFieldWidget(
          title: AppText.email,
          hint: AppText.descriptionHint,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your email';
            }

            final emailRegex = RegExp(
              r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
            );

            if (!emailRegex.hasMatch(
              value.trim(),
            )) {
              return 'Please enter a valid email address';
            }

            return null;
          },
        ),
        gap,

        ///number field===================================================
        InputFieldWidget(
          title: AppText.phoneNumber,
          hint: AppText.descriptionHint,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your ';
            }
            return null;
          },
        ),
        gap,

        ///address field===================================================
        InputFieldWidget(
          title: AppText.dormAddress,
          hint: AppText.descriptionHint,
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter your ';
            }
            return null;
          },
        ),

        gap,
        gap,

        CancelSaveRowButtonWidget(
          icon: AppAssets.save,
          onTapTitle: () {},
          title: AppText.saveChanges,
        ),
        gap,
      ],
    );
  }
}
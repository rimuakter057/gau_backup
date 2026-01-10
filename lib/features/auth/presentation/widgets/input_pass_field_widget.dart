import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/auth/presentation/widgets/password_field_widget.dart';
import 'package:gau_app/features/auth/presentation/widgets/title_widget.dart';


class InputPassFieldWidget extends StatelessWidget {
  const InputPassFieldWidget({
    super.key, required this.title, required this.hint, required this.controller, this.validator,
  });
  final String title;
  final String hint;
  final String? Function(String?)?validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title),
        SizedBox(height: 8.h),
        PasswordFieldWidget(
          validator: validator,
          hint: hint,
          controller: controller,
        ),
      ],
    );
  }
}
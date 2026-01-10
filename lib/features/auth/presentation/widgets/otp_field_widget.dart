
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class OtpFieldWidget extends StatelessWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final TextEditingController? controller;
  const OtpFieldWidget({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      enableActiveFill: true,

      textStyle:context.bodyMedium.copyWith(color: AppColors.white),
      cursorColor: Colors.black,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 50,


        activeColor:AppColors.inputBorderColor,
        inactiveColor: AppColors.inputBorderColor,
        selectedColor: Colors.transparent,
        activeFillColor: AppColors.primaryColor,
        selectedFillColor: AppColors.primaryColor,
        inactiveFillColor:AppColors.backgroundColor,

      ),

      onChanged: (value) {},
      controller: controller,
      onCompleted: (value) {
        onCompleted?.call(value);
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
final String? Function(String?)?validator;
  const PasswordFieldWidget({super.key, this.controller, this.hint, this.validator});

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _obscureText = true; // initially hide password

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:widget.validator ,
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hint ?? "Enter password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12), // optional padding
            child: CustomImage(
              imageSrc: _obscureText
                  ? AppAssets.passHide // your "eye closed" image
                  : AppAssets.pass,  // your "eye open" image
              height: 24.h,
              width: 24.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gau_app/features/auth/presentation/widgets/title_widget.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';



class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key, required this.title, required this.hint, this.validator, required this.controller,  this.keyboardType, this.maxLength,
  });
  final String title;
  final String hint;
  final int?maxLength;
  final  TextInputType? keyboardType;
  final String? Function(String?)?validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title,),
        SizedBox(height: ResponsiveHelper.height(8),),
        TextFormField(
          keyboardType:keyboardType??TextInputType.text ,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(hintText: hint),
            maxLength:maxLength ,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}


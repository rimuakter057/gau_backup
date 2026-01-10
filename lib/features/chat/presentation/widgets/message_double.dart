import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/chat/models/chat_model.dart';

import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
      message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 10.h,
        ),
        constraints: BoxConstraints(maxWidth: 260.w),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.white : AppColors.chatContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          message.text,
          style: context.bodySmall.copyWith(color: AppColors.white)
        ),
      ),
    );
  }
}

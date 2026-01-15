import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/chat/models/chat_model.dart';

import 'package:gau_app/utils/extension/base_extension.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
            constraints: BoxConstraints(maxWidth: 280.w),
            decoration: BoxDecoration(
              // Sender hole Red, Receiver hole Off-white/Grey
              color: message.isMe ? Color(0xFFD9534F) : Color(0xFFF8F9FA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                // Sender er jonno bottom-right 0, Receiver er jonno bottom-left 0
                bottomRight: Radius.circular(message.isMe ? 16.r : 0),
                bottomLeft: Radius.circular(message.isMe ? 0 : 16.r),
              ),
              border: message.isMe
                  ? null
                  : Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                                message.text,
                    maxLines: 100,
                    overflow:TextOverflow.ellipsis ,

                    style: context.bodySmall.copyWith(
                      color: message.isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                // Tick icon shudhu matro receiver ba nicher bubble e thakle
                if (!message.isMe)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Icon(Icons.done, color: Colors.red, size: 16.sp),
                  ),
              ],
            ),
          ),
          // "1 day ago" text ta bubble er baire thakle evabe add kora jay
          if (message.isMe)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, right: 4.w),
              child: Text(
                "1 day ago",
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}

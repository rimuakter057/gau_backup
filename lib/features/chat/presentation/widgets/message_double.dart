import 'package:flutter/material.dart';
import 'package:gau_app/features/chat/models/chat_model.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  Widget _buildStatusIcon() {
    switch (message.status) {
      case 'sending':
        return Icon(
          Icons.access_time,
          color: Colors.white54,
          size: ResponsiveHelper.fontSize(12),
        );
      case 'sent':
        return Icon(
          Icons.done,
          color: Colors.white70,
          size: ResponsiveHelper.fontSize(12),
        );
      case 'delivered':
        return Icon(
          Icons.done_all,
          color: Colors.white70,
          size: ResponsiveHelper.fontSize(12),
        );
      case 'seen':
        return Icon(
          Icons.done_all,
          color: Colors.blueAccent,
          size: ResponsiveHelper.fontSize(12),
        );
      default:
        return Icon(
          Icons.access_time,
          color: Colors.white54,
          size: ResponsiveHelper.fontSize(12),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(8)),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(12),
          vertical: ResponsiveHelper.height(10),
         
        ),
        constraints: BoxConstraints(maxWidth: ResponsiveHelper.width(280)),
        decoration: BoxDecoration(
          color: message.isMe
              ? const Color(0xFFD9534F)
              : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ResponsiveHelper.borderRadius(16)),
            topRight: Radius.circular(ResponsiveHelper.borderRadius(16)),
            bottomRight: Radius.circular(
              message.isMe ? 0 : ResponsiveHelper.borderRadius(16),
            ),
            bottomLeft: Radius.circular(
              message.isMe ? ResponsiveHelper.borderRadius(16) : 0,
            ),
          ),
          border: message.isMe ? null : Border.all(color: Colors.grey.shade200),
        ),
        child: IntrinsicWidth(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: message.isMe ? ResponsiveHelper.width(18) : 0,
                ),
                child: Text(
                  message.text,
                  style: context.bodySmall.copyWith(
                    color: message.isMe ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (message.isMe)
                Positioned(bottom: 0, right: 0, child: _buildStatusIcon()),
            ],
          ),
        ),
      ),
    );
  }
}

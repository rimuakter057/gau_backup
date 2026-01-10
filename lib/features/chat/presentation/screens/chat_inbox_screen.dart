import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/features/chat/presentation/widgets/message_double.dart';

import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';

import '../../models/chat_model.dart';

class ChatInboxScreen extends StatefulWidget {
  const ChatInboxScreen({super.key});

  @override
  State<ChatInboxScreen> createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  final TextEditingController _messageController = TextEditingController();

  // temporary local messages (API later)
  final List<ChatMessage> _messages = [
    ChatMessage(text: "Hello 👋", isMe: false),
    ChatMessage(text: "Hi, how can I help you?", isMe: true),
    ChatMessage(
      text:
          "Hello rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr 👋",
      isMe: false,
    ),
    ChatMessage(text: "Hi, how can I help you?", isMe: true),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(text: _messageController.text.trim(), isMe: true),
      );
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "AppText.inbox"),
      body: Column(
        children: [


          /// 🔹 Message list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),

          /// 🔹 Input box
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                backgroundColor: AppColors.chatInputField,
                radius: 12.r,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),

                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: CustomImage(imageSrc: AppAssets.add),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          filled: true,
                          hintText: "Type a message...",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: CustomImage(imageSrc: AppAssets.send),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

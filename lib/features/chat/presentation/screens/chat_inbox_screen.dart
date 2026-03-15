import 'package:flutter/material.dart';
import 'package:gau_app/features/chat/controller/chat_controller.dart';
import 'package:gau_app/features/chat/models/chat_message_model.dart';
import 'package:gau_app/features/chat/models/chat_model.dart';
import 'package:gau_app/features/chat/presentation/widgets/message_double.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/share/widgets/custom_profile_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInboxScreen extends StatefulWidget {
  final String conversationId;
  final String receiverId;
  final String receiverModel;
  final String receiverName;

  const ChatInboxScreen({
    super.key,
    required this.conversationId,
    required this.receiverId,
    required this.receiverModel,
    required this.receiverName,
  });

  @override
  State<ChatInboxScreen> createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  final ChatController controller = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initConversation(
        convId: widget.conversationId,
        recId: widget.receiverId,
        recModel: widget.receiverModel,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.receiverName,
          style: GoogleFonts.poppins(
            fontSize: ResponsiveHelper.fontSize(14),
            color: AppColors.titleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveHelper.padding(16)),
            child: CustomProfileAvatar(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.padding(16),
        ),
        child: Column(
          children: [
            SizedBox(height: ResponsiveHelper.height(8)),

            /// Message List
            Expanded(
              child: Obx(() {
                if (controller.isLoadingMessages.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.messages.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  reverse: true,
                  itemCount: controller.messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.messages.length) {
                      return Obx(() => controller.isLoadingMore.value
                          ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                          : const SizedBox.shrink());
                    }

                    final ChatMessageModel msg = controller.messages[index];
                    final bool isMe = msg.senderId == controller.currentUserId;
                    return MessageBubble(
                      message: ChatMessage(
                        text: msg.content ?? '',
                        isMe: isMe,
                        status: msg.status ?? 'sending',
                      ),
                    );
                  },
                );
              }),
            ),





            /// Input Box
            SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.height(8),
                ),
                decoration: BoxDecoration(
                  color: AppColors.softRed,
                  borderRadius: BorderRadius.circular(
                      ResponsiveHelper.borderRadius(30)),
                  border: Border.all(color: AppColors.inputBorderColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageTextController,
                        decoration: InputDecoration(
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(16),
                            vertical: ResponsiveHelper.height(10),
                          ),
                          hintText: "Type a message...",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: controller.sendMessage,
                      icon: CustomImage(imageSrc: AppAssets.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
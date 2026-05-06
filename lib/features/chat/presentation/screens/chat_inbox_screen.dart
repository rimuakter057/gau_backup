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
                  _ChatMessagesShimmer();
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
                          ?  Padding(
                        padding: EdgeInsets.all(ResponsiveHelper.padding(8)),
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



///chat message shimmer========


class _ChatMessagesShimmer extends StatefulWidget {
  const _ChatMessagesShimmer();

  @override
  State<_ChatMessagesShimmer> createState() => _ChatMessagesShimmerState();
}

class _ChatMessagesShimmerState extends State<_ChatMessagesShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _anim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _box({required double w, required double h, double radius = 8}) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end: Alignment(_anim.value + 1, 0),
            colors: [
              Colors.grey.shade300,
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
          ),
        ),
      ),
    );
  }

  /// isMe=true  → right align (sent)
  /// isMe=false → left align (received)
  Widget _bubble(double sw, {required bool isMe}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.spacing(5),
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: _box(
          w: sw * 0.5,
          h: ResponsiveHelper.height(30),
          radius: 16,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    /// বিভিন্ন width দিয়ে natural chat look
    final bubbles = [
      false, true, false, true, true,
      false, true, false, true, false,
    ];

    return ListView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.spacing(8),
      ),
      itemCount: bubbles.length,
      itemBuilder: (_, i) => _bubble(sw, isMe: bubbles[i]),
    );
  }
}
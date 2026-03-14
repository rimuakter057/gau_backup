import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/chat/controller/chat_controller.dart';
import 'package:gau_app/features/chat/models/conversation_list_model.dart';
import 'package:gau_app/features/chat/presentation/widgets/user_chat_list_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';

import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchConversationList().then((_) {
        if (controller.userChatList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to load conversations. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onNotificationTap: () {},
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
          child: Column(
            children: [
              TextField(
                onTap: () {
                  context.pushNamed(RoutesPath.searchScreen);
                },
                decoration: InputDecoration(
                  hintText: AppText.searchConver,
                ),
              ),
              SizedBox(height: ResponsiveHelper.height(16)),
              Obx(() {
                if (controller.isLoadingChatList.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.userChatList.isEmpty) {
                  return const Center(child: Text('No conversations yet.'));
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.userChatList.length,
                  itemBuilder: (context, index) {
                    final ConversationListModel conversation =
                    controller.userChatList[index];

                    return UserChatListWidget(
                      onTap: () {
                        context.pushNamed(RoutesPath.chatInboxScreen);
                      },
                      name: conversation.participant.name,
                      message: conversation.lastMessage?.content??'...',
                      time: _formatTime(conversation.lastMessageAt),
                      count: conversation.unreadCount > 0
                          ? conversation.unreadCount.toString()
                          : '',
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }
}

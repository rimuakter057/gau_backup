import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/core/service/datasource/remote/socket_service.dart';
import 'package:gau_app/features/chat/controller/chat_controller.dart';
import 'package:gau_app/features/chat/models/conversation_list_model.dart';
import 'package:gau_app/features/chat/presentation/widgets/chat_skeliton.dart';
import 'package:gau_app/features/chat/presentation/widgets/user_chat_list_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/helper/date_converter/date_converter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ✅ প্রথমে API call করো
      await controller.fetchConversationList();

      // তারপর socket
      if (!AppSocket.isConnected) {
        AppSocket.init(
          onSocketConnect: () {
            debugPrint('Socket connected from ChatListScreen');
            controller.listenNewMessagesForChatList();
          },
        );
      } else {
        controller.listenNewMessagesForChatList();
      }
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchConversationList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                    return ChatScreenSkeleton();
                  }
        
                  if (controller.userChatList.isEmpty) {
                    return const Center(child: Text('You don’t have any conversations yet.Start one now!'));
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
                          context.pushNamed(RoutesPath.chatInboxScreen,
        
                            extra: {
                            'conversationId': conversation.id,
                            'receiverId': conversation.participant.id,
                            'receiverModel': conversation.participant.model,
                            'receiverName': conversation.participant.name,
                            },
        
                          );
                        },
                        name: conversation.participant.name,
                        message: conversation.lastMessage?.content??'...',

                        time: DateConverter.formatTime(dateTime: conversation.lastMessage?.createdAt),


                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/chat/controller/chat_controller.dart';
import 'package:gau_app/features/chat/models/search_model.dart';
import 'package:gau_app/features/chat/presentation/widgets/user_chat_list_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ChatController controller = Get.find<ChatController>();

  @override
  void dispose() {
    controller.searchTextController.clear();
    controller.searchList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isBack: true, onNotificationTap: () {}),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
        child: Column(
          children: [
            TextField(
              controller: controller.searchTextController,
              autofocus: true,
              onChanged: (value) {
                controller.searchUsers(value);
              },
              decoration: InputDecoration(
                hintText: AppText.searchConver,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.searchTextController.clear();
                    controller.searchList.clear();
                  },
                ),
              ),
            ),

            SizedBox(height: ResponsiveHelper.height(16)),

            Expanded(
              child: Obx(() {
                if (controller.isLoadingSearch.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchTextController.text.isEmpty) {
                  return Center(
                    child: Text(
                      'Search for users to start a conversation',
                      style: context.bodySmall.copyWith(
                        color: AppColors.titleColor,
                      ),
                    ),
                  );
                }

                if (controller.searchList.isEmpty) {
                  return Center(
                    child: Text(
                      'No users found',
                      style: context.bodySmall.copyWith(
                        color: AppColors.titleColor,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.searchList.length,
                  itemBuilder: (context, index) {
                    final SearchModel user = controller.searchList[index];
                    return UserChatListWidget(
                      onTap: () async {
                        final existing = controller.userChatList
                            .firstWhereOrNull(
                              (c) => c.participant.id == user.id,
                            );

                        if (existing != null) {
                          await context.pushNamed(
                            RoutesPath.chatInboxScreen,
                            extra: {
                              'conversationId': existing.id,
                              'receiverId': existing.participant.id,
                              'receiverModel': existing.participant.model,
                              'receiverName': existing.participant.name,
                            },
                          );
                          // ← back করলে refresh
                          controller.fetchConversationList();
                        } else {
                          await controller.openOrCreateConversation(
                            receiverId: user.id ?? '',
                            receiverModel: user.role == 'student'
                                ? 'Student'
                                : 'Advisor',
                            receiverName: user.name ?? '',
                            context: context,
                          );
                          // ← new conversation এর পরেও refresh
                          controller.fetchConversationList();
                        }
                      },
                      name: user.name ?? '',
                      message: user.designation ?? user.role ?? '',
                      time: '',
                      count: '',
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

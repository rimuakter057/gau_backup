import 'dart:async';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/core/service/datasource/remote/socket_service.dart';
import 'package:gau_app/features/chat/models/chat_message_model.dart';
import 'package:gau_app/features/chat/models/conversation_list_model.dart';
import 'package:gau_app/features/chat/models/search_model.dart';
import 'package:gau_app/helper/shared_prefe/shared_prefe.dart';
import 'package:gau_app/utils/app_const/app_const.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class ChatController extends GetxController {

  RxList<ConversationListModel> userChatList = <ConversationListModel>[].obs;
  RxBool isLoadingChatList = false.obs;

  Future<void> fetchConversationList() async {
    isLoadingChatList(true);

    final response = await ApiClient.getData(ApiUrl.conversationList);

    debugPrint('📋 Conv List Response: ${response.body}');

    if (response.statusCode == 200) {
      List data = response.body['data'] ?? [];
      userChatList.value = data
          .map((e) => ConversationListModel.fromJson(e))
          .toList();


      for (var c in userChatList) {
        debugPrint('✅ Conv: ${c.participant.name} | unread: ${c.unreadCount}');
      }
    } else {
      userChatList.clear();
    }

    isLoadingChatList(false);
  }



///search=========================================================
  RxList<SearchModel> searchList = <SearchModel>[].obs;
  RxBool isLoadingSearch = false.obs;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onClose() {
    searchTextController.dispose();

    AppSocket.socket?.off('message:new');
    messageTextController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      searchList.clear();
      return;
    }

    isLoadingSearch(true);

    final response = await ApiClient.getData(
      '${ApiUrl.searchUsers}?query=$query',
    );

    if (response.statusCode == 200) {
      List data = response.body['data'] ?? [];
      searchList.value = data
          .map((e) => SearchModel.fromJson(e))
          .toList();
    } else {
      searchList.clear();
    }

    isLoadingSearch(false);
  }






  ///navigate inbox====================


  RxBool isCreatingConversation = false.obs;

  Future<void> openOrCreateConversation({
    required String receiverId,
    required String receiverModel,
    required String receiverName,
    required BuildContext context,
  }) async {
    isCreatingConversation(true);

    final response = await ApiClient.postData(
      ApiUrl.sendMessage,
      {
        'receiverId': receiverId,
        'receiverModel': receiverModel,
      },
    );

    debugPrint('🆕 Create Conv Response: ${response.body}');
    isCreatingConversation(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body['data'];
      final convId = data['conversationId'] ?? data['_id'] ?? '';

      await fetchConversationList();
      context.pushNamed(
        RoutesPath.chatInboxScreen,
        extra: {
          'conversationId': convId,
          'receiverId': receiverId,
          'receiverModel': receiverModel,
          'receiverName': receiverName,
        },
      );
    }
  }

  //
  // ///socket===================================================================================
  //
  //
  //
  // RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  // RxBool isLoadingMessages = false.obs;
  //
  // String? conversationId;
  // String? receiverId;
  // String? receiverModel;
  // String? currentUserId;
  //
  // final TextEditingController messageTextController = TextEditingController();
  // final ScrollController scrollController = ScrollController();
  //
  // ///<------------------ Init ------------------>
  // Future<void> initConversation({
  //   required String convId,
  //   required String recId,
  //   required String recModel,
  // }) async {
  //   conversationId = convId;
  //   receiverId = recId;
  //   receiverModel = recModel;
  //   currentUserId = await SharePrefsHelper.getString(AppConstants.userId);
  //
  //
  //   AppSocket.joinConversation(convId);
  //   AppSocket.listenNewMessages((data) {
  //     onNewMessage(data);
  //   });
  //
  //   await fetchMessages();
  // }
  // ///<------------------ Fetch Old Messages ------------------>
  // Future<void> fetchMessages() async {
  //   if (conversationId == null) return;
  //   isLoadingMessages(true);
  //
  //   final response = await ApiClient.getData(
  //     ApiUrl.getMessage(conversationId!),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     List data = response.body['data']['messages'] ?? [];
  //     messages.value = data
  //         .map((e) => ChatMessageModel.fromJson(e))
  //         .toList();
  //
  //     // Scroll to bottom after loading
  //     //_scrollToBottom();
  //   } else {
  //     messages.clear();
  //   }
  //
  //   isLoadingMessages(false);
  // }
  //
  //
  //
  //
  //
  //
  // ///listen new message for chat list==================================================
  //
  // void listenNewMessagesForChatList() {
  //   AppSocket.socket?.on('message:new', (data) {
  //     final conversationId = data['conversationId']?.toString();
  //     final content = data['content']?.toString();
  //
  //     final index = userChatList.indexWhere((c) => c.id == conversationId);
  //     if (index != -1) {
  //       final old = userChatList[index];
  //       userChatList[index] = ConversationListModel(
  //         id: old.id,
  //         participant: old.participant,
  //         lastMessage: LastMessage(
  //           id: data['_id'] ?? '',
  //           conversationId: conversationId ?? '',
  //           senderId: data['senderId'] ?? '',
  //           receiverId: data['receiverId'] ?? '',
  //           senderModel: data['senderModel'] ?? '',
  //           receiverModel: data['receiverModel'] ?? '',
  //           content: content ?? '',
  //           messageType: data['messageType'] ?? 'text',
  //           status: data['status'] ?? 'sent',
  //           isEdited: false,
  //           isDeleted: false,
  //           deletedFor: [],
  //           createdAt: DateTime.now(),
  //           updatedAt: DateTime.now(),
  //         ),
  //         lastMessageAt: DateTime.now(),
  //         unreadCount: old.unreadCount,
  //       );
  //
  //       final updated = userChatList.removeAt(index);
  //       userChatList.insert(0, updated);
  //     }
  //   });
  // }
  //
  //
  // ///<------------------ Send Message ------------------>
  //
  //
  //
  // void sendMessage() {
  //   final content = messageTextController.text.trim();
  //   if (content.isEmpty) return;
  //   if (conversationId == null || receiverId == null) return;
  //
  //   final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';
  //
  //   // Optimistic UI
  //   final tempMessage = ChatMessageModel(
  //     id: tempId,  // ← tempId হিসেবে set করো
  //     conversationId: conversationId,
  //     senderId: currentUserId,
  //     receiverId: receiverId,
  //     senderModel: receiverModel == 'Advisor' ? 'Student' : 'Advisor',
  //     receiverModel: receiverModel,
  //     content: content,
  //     messageType: 'text',
  //     status: 'sent',
  //     createdAt: DateTime.now().toIso8601String(),
  //   );
  //
  //   messages.add(tempMessage);
  //   messageTextController.clear();
  //   _scrollToBottom();
  //
  //   // Socket এ tempId পাঠাও
  //   AppSocket.sendMessage(
  //     conversationId: conversationId!,
  //     receiverId: receiverId!,
  //     receiverModel: receiverModel ?? 'Advisor',
  //     content: content,
  //     tempId: tempId,  // ← এটা pass করো
  //   );
  // }
  //
  //
  //
  //
  //
  //
  //
  // ///<------------------ New Message Received ------------------>
  // void onNewMessage(dynamic data) {
  //   try {
  //     final newMessage = ChatMessageModel.fromJson(
  //       Map<String, dynamic>.from(data),
  //     );
  //
  //     // tempId দিয়ে match করো
  //     final tempId = data['tempId']?.toString();
  //     final tempIndex = messages.indexWhere((m) => m.id == tempId);
  //
  //     if (tempIndex != -1) {
  //       // Temp message টা replace করো real message দিয়ে
  //       messages[tempIndex] = newMessage;
  //     } else {
  //       // অন্য কেউ পাঠালে নতুন add করো
  //       final alreadyExists = messages.any((m) => m.id == newMessage.id);
  //       if (!alreadyExists) {
  //         messages.add(newMessage);
  //       }
  //     }
  //
  //     _scrollToBottom();
  //   } catch (e) {
  //     debugPrint('❌ Error parsing message: $e');
  //   }
  // }
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  // ///<------------------ Scroll to Bottom ------------------>
  // void _scrollToBottom() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (scrollController.hasClients) {
  //       scrollController.animateTo(
  //         scrollController.position.maxScrollExtent,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeOut,
  //       );
  //     }
  //   });
  // }
  //
  //
  //
  //
  //
  //
  //





// ===== SOCKET / CHAT INBOX =====

//   RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
//   RxBool isLoadingMessages = false.obs;
//
//   String? conversationId;
//   String? receiverId;
//   String? receiverModel;
//   String? currentUserId;
//
//   final TextEditingController messageTextController = TextEditingController();
//   final ScrollController scrollController = ScrollController();
//
// // ─── Init ───────────────────────────────────────────────
//   Future<void> initConversation({
//     required String convId,
//     required String recId,
//     required String recModel,
//   }) async
//   {
//     conversationId = convId;
//     receiverId = recId;
//     receiverModel = recModel;
//     currentUserId = await SharePrefsHelper.getString(AppConstants.userId);
//
//     AppSocket.joinConversation(convId);
//     AppSocket.listenNewMessages((data) {
//       onNewMessage(data);
//     });
//
//     await fetchMessages();
//   }
//
//
//
//
//
//
// // ─── Fetch Old Messages ──────────────────────────────────
//   Future<void> fetchMessages() async {
//     if (conversationId == null) return;
//     isLoadingMessages(true);
//
//     final response = await ApiClient.getData(
//       ApiUrl.getMessage(conversationId!),
//     );
//
//     if (response.statusCode == 200) {
//       List data = response.body['data']['messages'] ?? [];
//
//       // reverse: true আছে তাই reversed করতে হবে
//       messages.value = data
//           .map((e) => ChatMessageModel.fromJson(e))
//           .toList()
//           .reversed
//           .toList();
//     } else {
//       messages.clear();
//     }
//
//     isLoadingMessages(false);
//   }
//
//
//






  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  RxBool isLoadingMessages = false.obs;
  RxBool isLoadingMore = false.obs;
  bool hasMoreMessages = true;
  int currentPage = 1;
  final int pageLimit = 15;

  String? conversationId;
  String? receiverId;
  String? receiverModel;
  String? currentUserId;

  final TextEditingController messageTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

// ─── Init ───────────────────────────────────────────────
  Future<void> initConversation({
    required String convId,
    required String recId,
    required String recModel,
  }) async {
    conversationId = convId;
    receiverId = recId;
    receiverModel = recModel;
    currentUserId = await SharePrefsHelper.getString(AppConstants.userId);

    // ← এখানে
    scrollController.addListener(() {
      final position = scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 300) {
        loadMoreMessages();
      }
    });

    AppSocket.joinConversation(convId);
    AppSocket.listenNewMessages((data) {
      onNewMessage(data);
    });

    await fetchMessages();
  }
// ─── Fetch First Page ────────────────────────────────────
  Future<void> fetchMessages() async {
    if (conversationId == null) return;
    isLoadingMessages(true);
    currentPage = 1;
    hasMoreMessages = true;

    final response = await ApiClient.getData(
      ApiUrl.getMessage(conversationId!, page: 1, limit: pageLimit),
    );

    if (response.statusCode == 200) {
      List data = response.body['data']['messages'] ?? [];
      messages.value = data
          .map((e) => ChatMessageModel.fromJson(e))
          .toList()
          .reversed
          .toList();

      if (data.length < pageLimit) hasMoreMessages = false;
    } else {
      messages.clear();
    }

    isLoadingMessages(false);
  }

// ─── Load More (Pagination) ──────────────────────────────
  Future<void> loadMoreMessages() async {
    if (!hasMoreMessages) return;
    if (isLoadingMore.value) return;
    if (conversationId == null) return;

    isLoadingMore(true);
    currentPage++;

    final response = await ApiClient.getData(
      ApiUrl.getMessage(conversationId!, page: currentPage, limit: pageLimit),
    );

    if (response.statusCode == 200) {
      List data = response.body['data']['messages'] ?? [];

      if (data.isEmpty || data.length < pageLimit) {
        hasMoreMessages = false;
      }

      final newMessages = data
          .map((e) => ChatMessageModel.fromJson(e))
          .toList()
          .reversed
          .toList();

      messages.addAll(newMessages); // ← পুরনো messages উপরে যোগ হবে
    } else {
      currentPage--;
    }

    isLoadingMore(false);
  }


















// ─── Send Message ────────────────────────────────────────
  void sendMessage() {
    final content = messageTextController.text.trim();
    if (content.isEmpty) return;
    if (conversationId == null || receiverId == null) return;

    final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';

    final tempMessage = ChatMessageModel(
      id: tempId,
      conversationId: conversationId,
      senderId: currentUserId,
      receiverId: receiverId,
      senderModel: receiverModel == 'Advisor' ? 'Student' : 'Advisor',
      receiverModel: receiverModel,
      content: content,
      messageType: 'text',
      status: 'sent',
      createdAt: DateTime.now().toIso8601String(),
    );

    // reverse: true তাই insert(0) — নিচে দেখাবে
    messages.insert(0, tempMessage);
    messageTextController.clear();

    AppSocket.sendMessage(
      conversationId: conversationId!,
      receiverId: receiverId!,
      receiverModel: receiverModel ?? 'Advisor',
      content: content,
      tempId: tempId,
    );
  }

// ─── New Message Received ────────────────────────────────
  void onNewMessage(dynamic data) {
    try {
      final newMessage = ChatMessageModel.fromJson(
        Map<String, dynamic>.from(data),
      );

      final tempId = data['tempId']?.toString();
      final tempIndex = messages.indexWhere((m) => m.id == tempId);

      if (tempIndex != -1) {
        // নিজের message — temp replace করো
        messages[tempIndex] = newMessage;
      } else {
        // অন্যের message — নিচে দেখাবে
        final alreadyExists = messages.any((m) => m.id == newMessage.id);
        if (!alreadyExists) {
          messages.insert(0, newMessage);
        }
      }
    } catch (e) {
      debugPrint('❌ Error parsing message: $e');
    }
  }

// ─── Chat List Realtime Update ───────────────────────────
  void listenNewMessagesForChatList() {
    AppSocket.socket?.on('message:new', (data) {
      final convId = data['conversationId']?.toString();
      final content = data['content']?.toString();

      final index = userChatList.indexWhere((c) => c.id == convId);
      if (index != -1) {
        final old = userChatList[index];
        userChatList[index] = ConversationListModel(
          id: old.id,
          participant: old.participant,
          lastMessage: LastMessage(
            id: data['_id'] ?? '',
            conversationId: convId ?? '',
            senderId: data['senderId'] ?? '',
            receiverId: data['receiverId'] ?? '',
            senderModel: data['senderModel'] ?? '',
            receiverModel: data['receiverModel'] ?? '',
            content: content ?? '',
            messageType: data['messageType'] ?? 'text',
            status: data['status'] ?? 'sent',
            isEdited: false,
            isDeleted: false,
            deletedFor: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          lastMessageAt: DateTime.now(),
          unreadCount: old.unreadCount,
        );

        final updated = userChatList.removeAt(index);
        userChatList.insert(0, updated);
      }
    });
  }



}



import 'dart:async';
import 'dart:convert';

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



class ChatController extends GetxController {

  RxList<ConversationListModel> userChatList = <ConversationListModel>[].obs;
  RxBool isLoadingChatList = false.obs;

  Future<void> fetchConversationList() async {
    isLoadingChatList(true);

    final response = await ApiClient.getData(ApiUrl.conversationList);

    if (response.statusCode == 200) {
      List data = response.body['data'] ?? [];
      userChatList.value = data
          .map((e) => ConversationListModel.fromJson(e))
          .toList();
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
    // Screen বন্ধ হলে listener remove করো
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




  ///socket===================================================================================



  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  RxBool isLoadingMessages = false.obs;

  String? conversationId;
  String? receiverId;
  String? receiverModel;
  String? currentUserId;

  final TextEditingController messageTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ///<------------------ Init ------------------>
  Future<void> initConversation({
    required String convId,
    required String recId,
    required String recModel,
  }) async {
    conversationId = convId;
    receiverId = recId;
    receiverModel = recModel;
    currentUserId = await SharePrefsHelper.getString(AppConstants.userId);

    // আগের listener clear করো আগে
    //AppSocket.socket?.off('message:new');

    AppSocket.joinConversation(convId);
    AppSocket.listenNewMessages((data) {
      onNewMessage(data);
    });

    await fetchMessages();
  }
  ///<------------------ Fetch Old Messages ------------------>
  Future<void> fetchMessages() async {
    if (conversationId == null) return;
    isLoadingMessages(true);

    final response = await ApiClient.getData(
      ApiUrl.getMessage(conversationId!),
    );

    if (response.statusCode == 200) {
      List data = response.body['data']['messages'] ?? [];
      messages.value = data
          .map((e) => ChatMessageModel.fromJson(e))
          .toList();

      // Scroll to bottom after loading
     // _scrollToBottom();
    } else {
      messages.clear();
    }

    isLoadingMessages(false);
  }






  ///listen new message for chat list==================================================

  void listenNewMessagesForChatList() {
    AppSocket.socket?.on('message:new', (data) {  // off করো না
      final conversationId = data['conversationId']?.toString();
      final content = data['content']?.toString();

      final index = userChatList.indexWhere((c) => c.id == conversationId);
      if (index != -1) {
        final old = userChatList[index];
        userChatList[index] = ConversationListModel(
          id: old.id,
          participant: old.participant,
          lastMessage: LastMessage(
            id: data['_id'] ?? '',
            conversationId: conversationId ?? '',
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


  ///<------------------ Send Message ------------------>



  void sendMessage() {
    final content = messageTextController.text.trim();
    if (content.isEmpty) return;
    if (conversationId == null || receiverId == null) return;

    final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';

    // Optimistic UI
    final tempMessage = ChatMessageModel(
      id: tempId,  // ← tempId হিসেবে set করো
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

    messages.add(tempMessage);
    messageTextController.clear();
    _scrollToBottom();

    // Socket এ tempId পাঠাও
    AppSocket.sendMessage(
      conversationId: conversationId!,
      receiverId: receiverId!,
      receiverModel: receiverModel ?? 'Advisor',
      content: content,
      tempId: tempId,  // ← এটা pass করো
    );
  }







  ///<------------------ New Message Received ------------------>
  void onNewMessage(dynamic data) {
    try {
      final newMessage = ChatMessageModel.fromJson(
        Map<String, dynamic>.from(data),
      );

      // tempId দিয়ে match করো
      final tempId = data['tempId']?.toString();
      final tempIndex = messages.indexWhere((m) => m.id == tempId);

      if (tempIndex != -1) {
        // Temp message টা replace করো real message দিয়ে
        messages[tempIndex] = newMessage;
      } else {
        // অন্য কেউ পাঠালে নতুন add করো
        final alreadyExists = messages.any((m) => m.id == newMessage.id);
        if (!alreadyExists) {
          messages.add(newMessage);
        }
      }

      _scrollToBottom();
    } catch (e) {
      debugPrint('❌ Error parsing message: $e');
    }
  }












  ///<------------------ Scroll to Bottom ------------------>
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }















}



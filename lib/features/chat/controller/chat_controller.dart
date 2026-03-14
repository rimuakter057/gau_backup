import 'dart:async';
import 'dart:convert';

import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/features/chat/models/conversation_list_model.dart';
import 'package:gau_app/features/chat/models/search_model.dart';
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







  RxList<SearchModel> searchList = <SearchModel>[].obs;
  RxBool isLoadingSearch = false.obs;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onClose() {
    searchTextController.dispose();
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








  // RxList<UpcomingDeadlineModel> upcomingDeadlines = <UpcomingDeadlineModel>[].obs;
  // RxBool isDeadlineLoading = false.obs;
  // Future<void> fetchUpcomingDeadlines() async {
  //   isDeadlineLoading.value = true;
  //   final response = await ApiClient.getData(ApiUrl.upcomingDeadline);
  //   if (response.statusCode == 200) {
  //     List data = response.body['data'] ?? [];
  //
  //
  //     upcomingDeadlines.value =
  //         data.map((e) => UpcomingDeadlineModel.fromJson(e)).toList();
  //   }
  //
  //   isDeadlineLoading.value = false;
  // }


  // ///==============================================================
  // bool _listenersInitialized = false; // ⭐ Add this
  //
  // void initSocketListeners() {
  //   if (_listenersInitialized) return; // ⭐ Prevent multiple calls
  //   _listenersInitialized = true;
  //
  //   sendNewListenMessage();
  //   errorListenMessage();
  //
  //   debugPrint('✅ Socket listeners initialized');
  // }
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   //initSocketListeners();
  //   getChatSearchList();
  // }
  //
  // /// get all message list ================================================
  // RxList<Messages> userMessageList = <Messages>[].obs;
  //
  // var isLoadingMessage = false.obs; // first page
  // var isLoadingMoreMessage = false.obs; // pagination
  //
  // int pageCount = 1;
  // final int limitCount = 10;
  // int totalCount = 0;
  //
  // bool get hasMoreMessage => userMessageList.length < totalCount;
  //
  // //RxString? roomID;
  // /// Room ID
  // RxString roomID = "".obs;
  //
  // Future<void> fetchRoomMessage({String? roomId, bool refresh = false}) async {
  //   //  if (roomId != null) roomID?.value = roomId;
  //   userMessageList.clear();
  //   // Update roomID if provided
  //   if (roomId != null && roomId.isNotEmpty) {
  //     roomID.value = roomId;
  //   }
  //
  //   if (roomID.value.isEmpty) {
  //     debugPrint("❌ Room ID is empty, skipping fetch");
  //     return; // Skip API call if no room ID
  //   }
  //
  //   debugPrint("================ RoomID=========== ${roomID.value}");
  //
  //   if (refresh) {
  //     pageCount = 1;
  //     totalCount = 0;
  //     userMessageList.clear();
  //   }
  //
  //   if ((pageCount > 1 && isLoadingMoreMessage.value) ||
  //       (pageCount == 1 && isLoadingMessage.value)) {
  //     return;
  //   }
  //
  //   if (pageCount == 1) {
  //     isLoadingMessage.value = true;
  //   } else {
  //     isLoadingMoreMessage.value = true;
  //   }
  //
  //   final uri = ApiUrl.getRoomMessage(
  //     roomId: roomId ?? '',
  //     page: pageCount,
  //     limit: limitCount,
  //   );
  //
  //   Response response = await ApiClient.getData(uri: uri);
  //   final body = jsonDecode(response.body);
  //
  //   if (response.statusCode == 200 && body['messages'] != null) {
  //     final data = MessageResponseModel.fromJson(body);
  //     totalCount = data.total ?? 0;
  //
  //     if (data.messages != null && data.messages!.isNotEmpty) {
  //       for (final msg in data.messages!) {
  //         msg.isMine = msg.isMine == true;
  //         userMessageList.add(msg);
  //       }
  //       pageCount++;
  //     }
  //   }
  //
  //   isLoadingMessage.value = false;
  //   isLoadingMoreMessage.value = false;
  // }
  //
  // ///socket========================
  //
  // final TextEditingController messageController = TextEditingController();
  //
  // void sendNewEmitMessage({
  //   required String receiverId,
  //   required String message,
  // }) {
  //   final payload = {'receiver_id': receiverId, 'message': message};
  //
  //   final localTempMessage = Messages(
  //     id: DateTime.now().millisecondsSinceEpoch.toString(),
  //     receiverId: receiverId,
  //     senderId: '', // আপনার user ID এখানে দিতে পারেন
  //     message: message,
  //     createdAt: DateTime.now().toIso8601String(),
  //     isMine: true,
  //     isDelivered: false,
  //     type: 'TEXT',
  //     chatRoomId: roomID.value, // ⭐ Important
  //   );
  //
  //   // Message list এ add
  //   userMessageList.insert(0, localTempMessage);
  //
  //   // Chat list এ instant update (optimistic)
  //   updateChatRoomInListOptimistic(localTempMessage);
  //
  //   messageController.clear();
  //
  //   AppSocket.emitWithAck(
  //     "message",
  //     payload,
  //     ack: (value) {
  //       debugPrint("✅ Message sent successfully: $value");
  //     },
  //   );
  // }
  //
  // void updateChatRoomInListOptimistic(Messages newMessage) {
  //   final roomIndex = userChatList.indexWhere(
  //     (room) => room.id == newMessage.chatRoomId,
  //   );
  //
  //   if (roomIndex != -1) {
  //     List<Rooms> tempList = List.from(userChatList);
  //     final room = tempList[roomIndex];
  //
  //     room.latestMessage = LatestMessage(
  //       id: newMessage.id,
  //       chatRoomId: newMessage.chatRoomId,
  //       senderId: newMessage.senderId,
  //       receiverId: newMessage.receiverId,
  //       message: newMessage.message,
  //       type: newMessage.type,
  //       isRead: false,
  //       isDelivered: false,
  //       createdAt: newMessage.createdAt,
  //       updatedAt: newMessage.updatedAt,
  //       isMine: true,
  //     );
  //
  //     tempList.removeAt(roomIndex);
  //     tempList.insert(0, room);
  //     userChatList.value = tempList;
  //
  //     debugPrint('✅ Chat list updated after sending message');
  //   }
  // }
  //
  // Future<void> sendNewListenMessage() async {
  //   AppSocket.onEvent('message-sent', (value) {
  //     debugPrint('📤 Message sent confirmation: $value');
  //     // Optional: Server confirmation পেলে কিছু করতে চাইলে
  //   });
  // }
  //
  // ///new message==========================
  //
  // Future<void> newMessage() async {
  //   debugPrint('========== Call New Message');
  //   AppSocket.onEvent('new-message', (value) {
  //     debugPrint('🔔 NEW MESSAGE RECEIVED: $value'); // ← এটা print হচ্ছে?
  //
  //     Messages model = Messages.fromJson(value);
  //     debugPrint('📨 Parsed Message: ${model.toJson()}');
  //     debugPrint('🆔 Chat Room ID: ${model.chatRoomId}'); // ← এটা কি আসছে?
  //
  //     if (model.chatRoomId == roomID.value) {
  //       userMessageList.insert(0, model);
  //       debugPrint('✅ Added to message list');
  //     }
  //
  //     debugPrint('🔄 Calling updateChatRoomInList...');
  //     updateChatRoomInList(model);
  //   });
  // }
  //
  // void updateChatRoomInList(Messages newMessage) {
  //   final roomIndex = userChatList.indexWhere(
  //     (room) => room.id == newMessage.chatRoomId,
  //   );
  //
  //   if (roomIndex != -1) {
  //     userChatList[roomIndex].latestMessage = LatestMessage(
  //       id: newMessage.id,
  //       chatRoomId: newMessage.chatRoomId,
  //       senderId: newMessage.senderId,
  //       receiverId: newMessage.receiverId,
  //       message: newMessage.message,
  //       type: newMessage.type,
  //       isRead: newMessage.isRead,
  //       isDelivered: newMessage.isDelivered,
  //       createdAt: newMessage.createdAt,
  //       updatedAt: newMessage.updatedAt,
  //       isMine: newMessage.isMine,
  //     );
  //
  //     if (newMessage.isMine == false && newMessage.chatRoomId != roomID.value) {
  //       userChatList[roomIndex].unreadCount =
  //           (userChatList[roomIndex].unreadCount ?? 0) + 1;
  //     }
  //
  //     final updatedRoom = userChatList[roomIndex];
  //     final newList = [updatedRoom];
  //
  //     for (int i = 0; i < userChatList.length; i++) {
  //       if (i != roomIndex) {
  //         newList.add(userChatList[i]);
  //       }
  //     }
  //
  //     userChatList.value = newList;
  //
  //     debugPrint('✅ UI should update now');
  //   } else {
  //     fetchChatRooms(refresh: true);
  //   }
  // }
  //
  // Future<void> errorListenMessage() async {
  //   AppSocket.onEvent('exception', (value) {
  //     debugPrint(
  //       '====================== error message   $value============================ ',
  //     );
  //   });
  // }

  ///=======================================================================

  ///get all user chat list========================================================

  // RxList<Rooms> userChatList = <Rooms>[].obs;
  // var isLoadingChat = false.obs;
  // var isLoadingMore = false.obs;
  //
  //
  //
  // int page = 1;
  // final int limit = 10;
  // int total = 0;
  // // fetch chat rooms
  // Future<void> fetchChatRooms({bool refresh = false}) async {
  //   if (refresh) {
  //     page = 1;
  //     userChatList.clear();
  //   }
  //   if (isLoadingChat.value || isLoadingMore.value) return;
  //
  //   final isFirstPage = page == 1;
  //   if (isFirstPage) {
  //     isLoadingChat.value = true;
  //   } else {
  //     isLoadingMore.value = true;
  //   }
  //   // GET request
  //   final uri = ApiUrl.getChatRooms(page: page, limit: limit);
  //   Response response = await ApiClient.getData(uri: uri);
  //
  //   // decode JSON string to Map
  //   final Map<String, dynamic> body = jsonDecode(response.body);
  //
  //   if (response.statusCode == 200 && body['rooms'] != null) {
  //     final data = UserChatModel.fromJson(body);
  //     total = data.total ?? 0;
  //
  //     if (data.rooms != null) {
  //       userChatList.addAll(data.rooms!);
  //       page++;
  //     }
  //
  //     userChatList.refresh();
  //   } else {
  //     if (refresh) userChatList.clear();
  //   }
  //   isLoadingChat.value = false;
  //   isLoadingMore.value = false;
  // }
  //
  // bool get hasMore => userChatList.length < total;
  //




  //
  // ///get block list==============================================================
  //
  // RxList<BlockModel> userBlockList = <BlockModel>[].obs;
  // var isLoadingBlockList = false.obs;
  // Future<void> fetchBlockList({bool refresh = false}) async {
  //   debugPrint("fetchBlockList called");
  //
  //   if (refresh) {
  //     userBlockList.clear();
  //   }
  //
  //   isLoadingBlockList.value = true;
  //
  //   final uri = ApiUrl.blockList;
  //
  //   Response response = await ApiClient.getData(uri: uri);
  //
  //   debugPrint("status code: ${response.statusCode}");
  //   debugPrint("body: ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);
  //
  //     userBlockList.value = (body['blockList'] as List)
  //         .map((e) => BlockModel.fromJson(e))
  //         .toList();
  //
  //     debugPrint("list length: ${userBlockList.length}");
  //   }
  //
  //   isLoadingBlockList.value = false;
  // }
  //
  //
  // ///==============search api section=========================================================
  // final ChatRepository _repo = ChatRepository();
  //
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  //
  // bool _isSearching = false;
  // bool get isSearching => _isSearching;
  //
  // List<ChatModel> _chatList = [];
  // List<ChatModel> get chatList => _chatList;
  //
  // List<ChatModel> _searchResults = [];
  // List<ChatModel> get searchResults => _searchResults;
  //
  // Timer? _debounce;
  //
  // @override
  // void onClose() {
  //   _debounce?.cancel();
  //   super.onClose();
  // }
  //
  // Future<void> getChatSearchList() async {
  //   _isLoading = true;
  //   update();
  //
  //   final Response response = await _repo.getChatList();
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //
  //     // Fix: Check if data has 'chats' array or if it's user profile
  //     if (data['chats'] != null && data['chats'] is List) {
  //       _chatList = (data['chats'] as List)
  //           .map((chat) => ChatModel.fromJson(chat))
  //           .toList();
  //     } else {
  //       // This seems to be user profile, not chat list
  //       _chatList = [];
  //     }
  //   } else {
  //     _chatList = [];
  //   }
  //
  //   _isLoading = false;
  //   update();
  // }
  //
  // void searchUsers(String query) {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //
  //   if (query.isEmpty) {
  //     _isSearching = false;
  //     _searchResults = [];
  //     update();
  //     return;
  //   }
  //
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     _performSearch(query);
  //   });
  // }
  //
  // Future<void> _performSearch(String query) async {
  //   _isSearching = true;
  //   update();
  //
  //   final Response response = await _repo.searchUsers(
  //     query: query,
  //     page: 1,
  //     limit: 10,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //
  //     // Fix: Navigate nested structure - users.users array
  //     if (data['users'] != null && data['users'] != null) {
  //       _searchResults = (data['users'] as List)
  //           .map((user) => ChatModel.fromJson(user))
  //           .toList();
  //     } else {
  //       _searchResults = [];
  //     }
  //   } else {
  //     _searchResults = [];
  //   }
  //
  //   _isSearching = false;
  //   update();
  // }

  ///=======================user chat list===================================================================

  // ///patch block=====================================================
  // RxBool isBlockedByMe = false.obs;
  // RxBool isBlockedMe = false.obs;
  // var isLoadingBlock = false.obs;
  //
  // Future<void> block(String id, BuildContext context) async {
  //   isLoadingBlock.value = true;
  //
  //   final body = {"userId": id};
  //
  //   final response = await ApiClient.patchData(uri: ApiUrl.block, body: body);
  //
  //   isLoadingBlock.value = false;
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print("User blocked successfully");
  //     showSnackBar(context, "user_blocked_successfully".tr, bgColor: Colors.green);
  //   } else {
  //     print("Block failed: ${response.statusCode}");
  //     showSnackBar(context, "failed_to_block_user".tr, bgColor: Colors.red);
  //   }
  // }

  // Future<void> unBlock(String id, BuildContext context) async {
  //   final body = {"userId": id};
  //
  //   final response = await ApiClient.patchData(uri: ApiUrl.unblock, body: body);
  //
  //   isLoadingBlockList.value = false;
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     debugPrint("User unblocked successfully");
  //
  //
  //     showSnackBar(
  //       context,
  //       "user_unblocked_successfully".tr,
  //       bgColor: Colors.green,
  //     );
  //   } else {
  //     debugPrint("Unblock failed: ${response.statusCode}");
  //     showSnackBar(context, "failed_to_unblock_user".tr, bgColor: Colors.red);
  //   }
  // }







  // Future<void> unBlock(String id, BuildContext context) async {
  //   final body = {"userId": id};
  //
  //   final response = await ApiClient.patchData(uri: ApiUrl.unblock, body: body);
  //
  //   isLoadingBlockList.value = false;
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     debugPrint("User unblocked successfully");
  //
  //     // ✅ block list থেকে remove
  //     userBlockList.removeWhere((block) => block.blockedUserId == id);
  //
  //     // ✅ chat list এর isBlockedByMe status update
  //     final roomIndex = userChatList.indexWhere(
  //           (room) => room.otherUser?.id == id,
  //     );
  //
  //     if (roomIndex != -1) {
  //       final updatedRoom = userChatList[roomIndex];
  //       updatedRoom.isBlockedByMe = false; // ✅ status false
  //
  //       userChatList[roomIndex] = updatedRoom; // ✅ GetX detect করবে
  //       userChatList.refresh(); // ✅ force UI update
  //     }
  //
  //     // ✅ isBlockedByMe global state ও update
  //     isBlockedByMe.value = false;
  //
  //     showSnackBar(
  //       context,
  //       "user_unblocked_successfully".tr,
  //       bgColor: Colors.green,
  //     );
  //   } else {
  //     debugPrint("Unblock failed: ${response.statusCode}");
  //     showSnackBar(context, "failed_to_unblock_user".tr, bgColor: Colors.red);
  //   }
  // }













  void showSnackBar(BuildContext context, String message, {Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor ?? Colors.black87,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

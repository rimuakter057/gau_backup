import 'package:gau_app/helper/shared_prefe/shared_prefe.dart';
import 'package:gau_app/utils/app_const/app_const.dart';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'api_urls/api_urls.dart';

class AppSocket {
  factory AppSocket() => _instance;
  AppSocket._internal();

  static final AppSocket _instance = AppSocket._internal();
  static io.Socket? socket;
  static bool _isInitialized = false;
  static Function? _onSocketConnectCallback;
  static String? _userId;

  static bool get isConnected => socket?.connected ?? false;

  ///<------------------ Public Init ------------------>
  static Future<void> init({Function? onSocketConnect}) async {
    _onSocketConnectCallback = onSocketConnect;

    _userId = await SharePrefsHelper.getString(AppConstants.userId);

    if (_userId == null || _userId!.isEmpty || _userId == "null") {
      debugPrint('⚠️ No userId found. Socket not connecting.');
      return;
    }

    _connectToSocket();
    _isInitialized = true;
  }

  ///<------------------ Internal Connect ------------------>
  static void _connectToSocket() {
    final socketUrl = ApiUrl.baseSocketUrl;

    socket = io.io(
      socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .build(),
    );

    _registerListeners();
  }

  ///<------------------ Register Events ------------------>
  static void _registerListeners() {
    if (socket == null) return;

    socket!
      ..onConnect((_) {
        debugPrint('✅ Socket connected as $_userId');

        // Step 2: Connect হলে সাথে সাথে users:online emit করো
        emitUsersOnline();

        _onSocketConnectCallback?.call();
      })
      ..onDisconnect((data) {
        debugPrint('🔌 Disconnected: $data');
      })
      ..onReconnectAttempt((attempt) {
        debugPrint('🔁 Reconnect attempt: $attempt');
      })
      ..onReconnectFailed((_) {
        debugPrint('❌ Reconnect failed');
      })
      ..onError((error) {
        debugPrint('⚠️ Socket error: $error');
      })
      ..on('unauthorized', (data) {
        debugPrint('❌ Unauthorized: $data');
      });
  }

  ///<------------------ Step 2: Users Online ------------------>
  static void emitUsersOnline() {
    if (_userId == null) return;
    sendEvent('users:online', {'userId': _userId});
    debugPrint('📡 Emitted users:online for $_userId');
  }

  ///<------------------ Step 5: Join Conversation ------------------>
  static void joinConversation(String conversationId) {
    sendEvent('conversation:join', {'conversationId': conversationId});
    debugPrint('🚪 Joined conversation: $conversationId');
  }

  ///<------------------ Step 6: Send Message ------------------>
  static void sendMessage({
    required String conversationId,
    required String receiverId,
    required String receiverModel,
    required String content,
    String? tempId,           // ← নতুন parameter
    String messageType = 'text',
  }) {
    if (_userId == null) return;

    final payload = {
      "conversationId": conversationId,
      "senderId": _userId,
      "senderModel": receiverModel == 'Advisor' ? 'Student' : 'Advisor',
      "receiverId": receiverId,
      "receiverModel": receiverModel,
      "content": content,
      "messageType": messageType,
      "tempId": tempId ?? "temp-${DateTime.now().millisecondsSinceEpoch}",
    };

    sendEvent('message:send', payload);
    debugPrint('📤 Message sent: $payload');
  }
  ///<------------------ Step 6: Listen New Message ------------------>

  static void listenNewMessages(Function(dynamic) onMessage) {
    socket!.on('message:new', (data) {
      debugPrint('📩 New message received: $data');
      onMessage(data);
    });
  }

  ///<------------------ Listen for Events ------------------>
  static void onEvent(String eventName, Function(dynamic) callback) {
    if (socket != null && socket!.connected) {
      socket!.on(eventName, callback);
    } else {
      debugPrint('⚠️ Socket not connected. Cannot listen for "$eventName".');
    }
  }

  ///<------------------ Emit Events ------------------>
  static void sendEvent(String eventName, dynamic data) {
    if (!isConnected) {
      debugPrint('❌ Socket not connected. Cannot emit "$eventName".');
      return;
    }
    socket!.emit(eventName, data);
  }

  static void emitWithAck(
      String event,
      dynamic data, {
        required Function(dynamic response) ack,
        Duration timeout = const Duration(seconds: 5),
      }) {
    if (!isConnected) {
      debugPrint('❌ Socket not connected. Cannot emit "$event".');
      ack(false);
      return;
    }
    socket!.emitWithAck(event, data, ack: (response) => ack(response));
  }

  ///<------------------ Cleanup ------------------>
  static void dispose() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
    _isInitialized = false;
    _userId = null;
    _onSocketConnectCallback = null;
    debugPrint('🧹 Socket disposed');
  }
}
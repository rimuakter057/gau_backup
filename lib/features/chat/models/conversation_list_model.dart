class ConversationListModel {
  final String id;
  final Participant participant;
  final LastMessage? lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;

  ConversationListModel({
    required this.id,
    required this.participant,
    this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
  });

  factory ConversationListModel.fromJson(Map<String, dynamic> json) {
    return ConversationListModel(
      id: json['_id']?.toString() ?? '',
      participant: Participant.fromJson(json['participant'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
      lastMessageAt: DateTime.tryParse(json['lastMessageAt']?.toString() ?? '') ?? DateTime.now(),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'participant': participant.toJson(),
      'lastMessage': lastMessage?.toJson(),
      'lastMessageAt': lastMessageAt.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }
}

class Participant {
  final String id;
  final String model;
  final String name;
  final String email;
  final String? avatar;
  final String designation;

  Participant({
    required this.id,
    required this.model,
    required this.name,
    required this.email,
    this.avatar,
    required this.designation,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      avatar: json['avatar']?.toString(),
      designation: json['designation']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'model': model,
      'name': name,
      'email': email,
      'avatar': avatar,
      'designation': designation,
    };
  }
}

class LastMessage {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String senderModel;
  final String receiverModel;
  final String content;
  final String messageType;
  final String status;
  final bool isEdited;
  final bool isDeleted;
  final List<dynamic> deletedFor;
  final DateTime createdAt;
  final DateTime updatedAt;

  LastMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.senderModel,
    required this.receiverModel,
    required this.content,
    required this.messageType,
    required this.status,
    required this.isEdited,
    required this.isDeleted,
    required this.deletedFor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id']?.toString() ?? '',
      conversationId: json['conversationId']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      receiverId: json['receiverId']?.toString() ?? '',
      senderModel: json['senderModel']?.toString() ?? '',
      receiverModel: json['receiverModel']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      messageType: json['messageType']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      isEdited: json['isEdited'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedFor: json['deletedFor'] as List<dynamic>? ?? [],
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderModel': senderModel,
      'receiverModel': receiverModel,
      'content': content,
      'messageType': messageType,
      'status': status,
      'isEdited': isEdited,
      'isDeleted': isDeleted,
      'deletedFor': deletedFor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
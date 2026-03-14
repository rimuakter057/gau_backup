class ChatMessageModel {
  String? id;
  String? conversationId;
  String? senderId;
  String? receiverId;
  String? senderModel;
  String? receiverModel;
  String? content;
  String? messageType;
  String? status;
  bool? isEdited;
  bool? isDeleted;
  List<dynamic>? deletedFor;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ChatMessageModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.receiverId,
    this.senderModel,
    this.receiverModel,
    this.content,
    this.messageType,
    this.status,
    this.isEdited,
    this.isDeleted,
    this.deletedFor,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    senderModel = json['senderModel'];
    receiverModel = json['receiverModel'];
    content = json['content'];
    messageType = json['messageType'];
    status = json['status'];
    isEdited = json['isEdited'];
    isDeleted = json['isDeleted'];
    deletedFor = json['deletedFor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['conversationId'] = conversationId;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['senderModel'] = senderModel;
    data['receiverModel'] = receiverModel;
    data['content'] = content;
    data['messageType'] = messageType;
    data['status'] = status;
    data['isEdited'] = isEdited;
    data['isDeleted'] = isDeleted;
    data['deletedFor'] = deletedFor;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
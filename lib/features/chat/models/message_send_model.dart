

class MessageSendModel {
  String? id;
  List<Participants>? participants;
  List<UnreadCounts>? unreadCounts;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastMessage;
  String? lastMessageAt;

  MessageSendModel(
      {this.id,
        this.participants,
        this.unreadCounts,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.lastMessage,
        this.lastMessageAt});

  MessageSendModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    if (json['unreadCounts'] != null) {
      unreadCounts = <UnreadCounts>[];
      json['unreadCounts'].forEach((v) {
        unreadCounts!.add(UnreadCounts.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastMessage = json['lastMessage'];
    lastMessageAt = json['lastMessageAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    if (unreadCounts != null) {
      data['unreadCounts'] = unreadCounts!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['lastMessage'] = lastMessage;
    data['lastMessageAt'] = lastMessageAt;
    return data;
  }
}

class Participants {
  String? userId;
  String? userModel;
  String? id;

  Participants({this.userId, this.userModel, this.id});

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userModel = json['userModel'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userModel'] = userModel;
    data['_id'] = id;
    return data;
  }
}

class UnreadCounts {
  String? userId;
  int? count;
  String? id;

  UnreadCounts({this.userId, this.count, this.id});

  UnreadCounts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    count = json['count'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['count'] = count;
    data['_id'] = id;
    return data;
  }
}

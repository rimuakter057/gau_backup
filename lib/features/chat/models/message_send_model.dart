

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
        participants!.add(new Participants.fromJson(v));
      });
    }
    if (json['unreadCounts'] != null) {
      unreadCounts = <UnreadCounts>[];
      json['unreadCounts'].forEach((v) {
        unreadCounts!.add(new UnreadCounts.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastMessage = json['lastMessage'];
    lastMessageAt = json['lastMessageAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.unreadCounts != null) {
      data['unreadCounts'] = this.unreadCounts!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageAt'] = this.lastMessageAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userModel'] = this.userModel;
    data['_id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['count'] = this.count;
    data['_id'] = this.id;
    return data;
  }
}

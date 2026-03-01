
class CreateComplainModel {
  String? studentId;
  String? category;
  String? priority;
  String? subject;
  String? description;
  String? status;
  bool? isDeleted;
  String? sId;
  List<StatusTimeline>? statusTimeline;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreateComplainModel(
      {this.studentId,
        this.category,
        this.priority,
        this.subject,
        this.description,
        this.status,
        this.isDeleted,
        this.sId,
        this.statusTimeline,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CreateComplainModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    category = json['category'];
    priority = json['priority'];
    subject = json['subject'];
    description = json['description'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    if (json['statusTimeline'] != null) {
      statusTimeline = <StatusTimeline>[];
      json['statusTimeline'].forEach((v) {
        statusTimeline!.add(StatusTimeline.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['category'] = category;
    data['priority'] = priority;
    data['subject'] = subject;
    data['description'] = description;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['_id'] = sId;
    if (statusTimeline != null) {
      data['statusTimeline'] =
          statusTimeline!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class StatusTimeline {
  String? status;
  String? changedAt;
  String? changedBy;

  StatusTimeline({this.status, this.changedAt, this.changedBy});

  StatusTimeline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    changedAt = json['changedAt'];
    changedBy = json['changedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['changedAt'] = changedAt;
    data['changedBy'] = changedBy;
    return data;
  }
}
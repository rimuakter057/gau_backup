class ComplainModel {
  String? id;
  String? studentId;
  String? category;
  String? priority;
  String? subject;
  String? description;
  String? status;
  bool? isDeleted;
  List<StatusTimeline>? statusTimeline;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ComplainModel(
      {this.id,
        this.studentId,
        this.category,
        this.priority,
        this.subject,
        this.description,
        this.status,
        this.isDeleted,
        this.statusTimeline,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ComplainModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    studentId = json['studentId'];
    category = json['category'];
    priority = json['priority'];
    subject = json['subject'];
    description = json['description'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    if (json['statusTimeline'] != null) {
      statusTimeline = <StatusTimeline>[];
      json['statusTimeline'].forEach((v) {
        statusTimeline!.add(new StatusTimeline.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['studentId'] = this.studentId;
    data['category'] = this.category;
    data['priority'] = this.priority;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    if (this.statusTimeline != null) {
      data['statusTimeline'] =
          this.statusTimeline!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['changedAt'] = this.changedAt;
    data['changedBy'] = this.changedBy;
    return data;
  }
}

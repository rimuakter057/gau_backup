class UpcomingDeadlineModel {
  String? id;
  String? createdBy;
  String? sectionId;
  String? semesterId;
  String? title;
  String? deadlineType;
  String? dueDate;
  String? dueTime;
  String? description;
  String? source;
  Null? sourceId;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UpcomingDeadlineModel(
      {this.id,
        this.createdBy,
        this.sectionId,
        this.semesterId,
        this.title,
        this.deadlineType,
        this.dueDate,
        this.dueTime,
        this.description,
        this.source,
        this.sourceId,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UpcomingDeadlineModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdBy = json['createdBy'];
    sectionId = json['sectionId'];
    semesterId = json['semesterId'];
    title = json['title'];
    deadlineType = json['deadlineType'];
    dueDate = json['dueDate'];
    dueTime = json['dueTime'];
    description = json['description'];
    source = json['source'];
    sourceId = json['sourceId'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdBy'] = createdBy;
    data['sectionId'] = sectionId;
    data['semesterId'] = semesterId;
    data['title'] = title;
    data['deadlineType'] = deadlineType;
    data['dueDate'] = dueDate;
    data['dueTime'] = dueTime;
    data['description'] = description;
    data['source'] = source;
    data['sourceId'] = sourceId;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

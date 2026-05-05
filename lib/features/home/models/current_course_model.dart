class CurrentCourseModel {
  String? sectionId;
  String? courseCode;
  String? courseName;
  String? section;
  String? programId;
  int? credits;
  SectionTime? sectionTime;
  List<String>? sectionDays;
  String? semester;
  int? academicYear;
  String? program;
  String? semesterId;
  AdvisorId? advisorId;
  ClassRoomId? classRoomId;

  CurrentCourseModel(
      {this.sectionId,
        this.courseCode,
        this.courseName,
        this.section,
        this.programId,
        this.credits,
        this.sectionTime,
        this.sectionDays,
        this.semester,
        this.academicYear,
        this.program,
        this.semesterId,
        this.advisorId,
        this.classRoomId});

  CurrentCourseModel.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    courseCode = json['courseCode'];
    courseName = json['courseName'];
    section = json['section'];
    programId = json['programId'];
    credits = json['credits'];
    sectionTime = json['sectionTime'] != null
        ? new SectionTime.fromJson(json['sectionTime'])
        : null;
    sectionDays = json['sectionDays'].cast<String>();
    semester = json['semester'];
    academicYear = json['academicYear'];
    program = json['program'];
    semesterId = json['semesterId'];
    advisorId = json['advisorId'] != null
        ? new AdvisorId.fromJson(json['advisorId'])
        : null;
    classRoomId = json['classRoomId'] != null
        ? new ClassRoomId.fromJson(json['classRoomId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionId'] = this.sectionId;
    data['courseCode'] = this.courseCode;
    data['courseName'] = this.courseName;
    data['section'] = this.section;
    data['programId'] = this.programId;
    data['credits'] = this.credits;
    if (this.sectionTime != null) {
      data['sectionTime'] = this.sectionTime!.toJson();
    }
    data['sectionDays'] = this.sectionDays;
    data['semester'] = this.semester;
    data['academicYear'] = this.academicYear;
    data['program'] = this.program;
    data['semesterId'] = this.semesterId;
    if (this.advisorId != null) {
      data['advisorId'] = this.advisorId!.toJson();
    }
    if (this.classRoomId != null) {
      data['classRoomId'] = this.classRoomId!.toJson();
    }
    return data;
  }
}

class SectionTime {
  String? startTime;
  String? endTime;

  SectionTime({this.startTime, this.endTime});

  SectionTime.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}

class AdvisorId {
  String? sId;
  String? advisorId;
  String? fullName;

  AdvisorId({this.sId, this.advisorId, this.fullName});

  AdvisorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    advisorId = json['advisorId'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['advisorId'] = this.advisorId;
    data['fullName'] = this.fullName;
    return data;
  }
}

class ClassRoomId {
  String? building;
  String? roomNumber;
  String? roomName;

  ClassRoomId({this.building, this.roomNumber, this.roomName});

  ClassRoomId.fromJson(Map<String, dynamic> json) {
    building = json['building'];
    roomNumber = json['roomNumber'];
    roomName = json['roomName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building'] = this.building;
    data['roomNumber'] = this.roomNumber;
    data['roomName'] = this.roomName;
    return data;
  }
}

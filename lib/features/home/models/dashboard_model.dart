class SemistarModel {
  double? currentGPA;
  int? totalEarnedCredits;
  List<String>? semestersName;
  List<Semesters>? semesters;

  SemistarModel(
      {this.currentGPA,
        this.totalEarnedCredits,
        this.semestersName,
        this.semesters});

  SemistarModel.fromJson(Map<String, dynamic> json) {
    currentGPA = json['currentGPA'];
    totalEarnedCredits = json['totalEarnedCredits'];
    semestersName = json['semestersName'].cast<String>();
    if (json['semesters'] != null) {
      semesters = <Semesters>[];
      json['semesters'].forEach((v) {
        semesters!.add(new Semesters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentGPA'] = this.currentGPA;
    data['totalEarnedCredits'] = this.totalEarnedCredits;
    data['semestersName'] = this.semestersName;
    if (this.semesters != null) {
      data['semesters'] = this.semesters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Semesters {
  String? semesterId;
  String? semesterName;
  double? semesterGPA;
  List<Courses>? courses;

  Semesters(
      {this.semesterId, this.semesterName, this.semesterGPA, this.courses});

  Semesters.fromJson(Map<String, dynamic> json) {
    semesterId = json['semesterId'];
    semesterName = json['semesterName'];
    semesterGPA = json['semesterGPA'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semesterId'] = this.semesterId;
    data['semesterName'] = this.semesterName;
    data['semesterGPA'] = this.semesterGPA;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? sectionId;
  String? courseCode;
  String? courseName;
  int? credits;
  String? instructor;
  String? letterGrade;
  double? gradePoint;
  int? percentage;

  Courses(
      {this.sectionId,
        this.courseCode,
        this.courseName,
        this.credits,
        this.instructor,
        this.letterGrade,
        this.gradePoint,
        this.percentage});

  Courses.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    courseCode = json['courseCode'];
    courseName = json['courseName'];
    credits = json['credits'];
    instructor = json['instructor'];
    letterGrade = json['letterGrade'];
    gradePoint = json['gradePoint'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionId'] = this.sectionId;
    data['courseCode'] = this.courseCode;
    data['courseName'] = this.courseName;
    data['credits'] = this.credits;
    data['instructor'] = this.instructor;
    data['letterGrade'] = this.letterGrade;
    data['gradePoint'] = this.gradePoint;
    data['percentage'] = this.percentage;
    return data;
  }
}

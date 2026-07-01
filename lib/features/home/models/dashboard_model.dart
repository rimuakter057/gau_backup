class SemistarModel {
  double? currentGPA;
  double? totalEarnedCredits;   // int? থেকে double? করা হলো
  List<String>? semestersName;
  List<Semesters>? semesters;

  SemistarModel(
      {this.currentGPA,
        this.totalEarnedCredits,
        this.semestersName,
        this.semesters});

  SemistarModel.fromJson(Map<String, dynamic> json) {
    currentGPA = (json['currentGPA'] as num?)?.toDouble();
    totalEarnedCredits = (json['totalEarnedCredits'] as num?)?.toDouble();
    semestersName = (json['semestersName'] as List?)?.cast<String>();
    if (json['semesters'] != null) {
      semesters = <Semesters>[];
      json['semesters'].forEach((v) {
        semesters!.add(Semesters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentGPA'] = currentGPA;
    data['totalEarnedCredits'] = totalEarnedCredits;
    data['semestersName'] = semestersName;
    if (semesters != null) {
      data['semesters'] = semesters!.map((v) => v.toJson()).toList();
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
    semesterGPA = (json['semesterGPA'] as num?)?.toDouble();
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semesterId'] = semesterId;
    data['semesterName'] = semesterName;
    data['semesterGPA'] = semesterGPA;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? sectionId;
  String? courseCode;
  String? courseName;
  double? credits;              // int? থেকে double? করা হলো
  String? instructor;
  String? letterGrade;
  double? gradePoint;
  double? percentage;           // int? থেকে double? করা হলো (future-proof)

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
    credits = (json['credits'] as num?)?.toDouble();
    instructor = json['instructor'];
    letterGrade = json['letterGrade'];
    gradePoint = (json['gradePoint'] as num?)?.toDouble();
    percentage = (json['percentage'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sectionId'] = sectionId;
    data['courseCode'] = courseCode;
    data['courseName'] = courseName;
    data['credits'] = credits;
    data['instructor'] = instructor;
    data['letterGrade'] = letterGrade;
    data['gradePoint'] = gradePoint;
    data['percentage'] = percentage;
    return data;
  }
}
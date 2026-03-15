class TranscriptModel {
  final List<TranscriptSemester> transcriptSemesters;
  final ProgramSummary programSummary;

  TranscriptModel({
    required this.transcriptSemesters,
    required this.programSummary,
  });

  factory TranscriptModel.fromJson(Map<String, dynamic> json) {
    return TranscriptModel(
      transcriptSemesters: (json['transcriptSemesters'] as List)
          .map((e) => TranscriptSemester.fromJson(e))
          .toList(),
      programSummary: ProgramSummary.fromJson(json['programSummary']),
    );
  }

  Map<String, dynamic> toJson() => {
    'transcriptSemesters': transcriptSemesters.map((e) => e.toJson()).toList(),
    'programSummary': programSummary.toJson(),
  };
}



class TranscriptSemester {
  final String semesterLabel;
  final double termGPA;
  final int totalCredits;
  final int totalCreditHours;
  final List<CourseModel> courses;

  TranscriptSemester({
    required this.semesterLabel,
    required this.termGPA,
    required this.totalCredits,
    required this.totalCreditHours,
    required this.courses,
  });

  factory TranscriptSemester.fromJson(Map<String, dynamic> json) {
    return TranscriptSemester(
      semesterLabel: json['semesterLabel'] ?? '',
      termGPA: (json['termGPA'] ?? 0).toDouble(),
      totalCredits: json['totalCredits'] ?? 0,
      totalCreditHours: json['totalCreditHours'] ?? 0,
      courses: (json['courses'] as List)
          .map((e) => CourseModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'semesterLabel': semesterLabel,
    'termGPA': termGPA,
    'totalCredits': totalCredits,
    'totalCreditHours': totalCreditHours,
    'courses': courses.map((e) => e.toJson()).toList(),
  };
}

class CourseModel {
  final String code;
  final String courseName;
  final String level;
  final int credits;
  final int creditHours;
  final String grade;
  final double gradePoint;

  CourseModel({
    required this.code,
    required this.courseName,
    required this.level,
    required this.credits,
    required this.creditHours,
    required this.grade,
    required this.gradePoint,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      code: json['code'] ?? '',
      courseName: json['courseName'] ?? '',
      level: json['level'] ?? '',
      credits: json['credits'] ?? 0,
      creditHours: json['creditHours'] ?? 0,
      grade: json['grade'] ?? '',
      gradePoint: (json['gradePoint'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'courseName': courseName,
    'level': level,
    'credits': credits,
    'creditHours': creditHours,
    'grade': grade,
    'gradePoint': gradePoint,
  };
}


class ProgramSummary {
  final int totalAchievedCredits;
  final int totalAchievedCreditHours;
  final double cumulativeGPA;

  ProgramSummary({
    required this.totalAchievedCredits,
    required this.totalAchievedCreditHours,
    required this.cumulativeGPA,
  });

  factory ProgramSummary.fromJson(Map<String, dynamic> json) {
    return ProgramSummary(
      totalAchievedCredits: json['totalAchievedCredits'] ?? 0,
      totalAchievedCreditHours: json['totalAchievedCreditHours'] ?? 0,
      cumulativeGPA: (json['cumulativeGPA'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalAchievedCredits': totalAchievedCredits,
    'totalAchievedCreditHours': totalAchievedCreditHours,
    'cumulativeGPA': cumulativeGPA,
  };
}
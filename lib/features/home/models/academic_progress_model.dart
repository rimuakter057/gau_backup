class ProgressModel {
  double? currentGPA;
  int? earnedCredits;
  int? requiredCredits;
  double? degreeCompletionPercent;
  // double? currentGPA;
  // int? earnedCredits;
  // int? requiredCredits;
  // int? degreeCompletionPercent;
  List<RecentSemester>? recentSemesters;

  ProgressModel(
      {this.currentGPA,
        this.earnedCredits,
        this.requiredCredits,
        this.degreeCompletionPercent,
        this.recentSemesters});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    currentGPA = (json['currentGPA'] as num?)?.toDouble();
    earnedCredits = json['earnedCredits'];
    requiredCredits = json['requiredCredits'];
    degreeCompletionPercent = json['degreeCompletionPercent'];
    if (json['recentSemesters'] != null) {
      recentSemesters = <RecentSemester>[];
      json['recentSemesters'].forEach((v) {
        recentSemesters!.add(RecentSemester.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currentGPA'] = currentGPA;
    data['earnedCredits'] = earnedCredits;
    data['requiredCredits'] = requiredCredits;
    data['degreeCompletionPercent'] = degreeCompletionPercent;
    if (recentSemesters != null) {
      data['recentSemesters'] = recentSemesters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentSemester {
  String? label;
  double? gpa;

  RecentSemester({this.label, this.gpa});

  RecentSemester.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    gpa = (json['gpa'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'gpa': gpa,
    };
  }
}
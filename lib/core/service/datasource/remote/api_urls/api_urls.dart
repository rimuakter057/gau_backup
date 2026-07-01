class ApiUrl {
  //local Server
  static const String primaryUrl = "http://3.130.104.6:5000";
  // ////
  static const baseSocketUrl = 'http://3.130.104.6:5000';

  // static const String primaryUrl = "http://10.10.20.16:6123";
  // static const baseSocketUrl = 'http://10.10.20.16:6123';

  // static String socketUrl({required String userId}) =>
  //     "$baseSocketUrl?userId=$userId";

  static const String baseUrl = "$primaryUrl/api/v1";
  static const String imageUrl = "$primaryUrl/";

  ///app url================================================
  static const String login = "/auth/signin";
  static const String forgot = "/auth/forget-password";
  static const String verifyOtp = "/auth/verify-reset-otp";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";

  ///create complain========================================

  static const String createComplain = "/complaints/create-request";
  static const String dashboard = "/final-grade/student/my-grades";
  static const String currentCourse = "/course-assign/student/current-courses";
  static String getSingleComplain({complainId}) =>
      "/complaints/get-single/$complainId";
  static String getAllComplain({
    required String status,
    required int page,
    required int limit,
  }) => "/complaints/my?status=$status&page=$page&limit=$limit";
  static String upcomingDeadline =
      "/upcoming-deadlines/student?sectionIds=69919b90a39db2efefc243ea";
  static String academicProgress =
      "/final-grade/student/academic-progress?programId=699a9a3ed08a2c30363d8c98";

  ///message====================================================

  static const String searchUsers = '/messages/search-users';

  static String conversationList = "/messages/conversations";
  static const String sendMessage = '/messages/conversations';
  static const String profile = '/user/get-my-profile';
  static const String updateProfile = '/user/update-profile';

  static String getMessage(
    String conversationId, {
    int page = 1,
    int limit = 15,
  }) =>
      '/messages/conversations/$conversationId/messages?page=$page&limit=$limit';



  static String semester({required String semesterName }) =>
      "/final-grade/student/my-grades?semestersName=$semesterName";



}

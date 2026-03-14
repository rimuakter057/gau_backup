class ApiUrl {
  //Live Server
  static const String primaryUrl = "http://10.10.20.45:5000"; // ////

  static const String baseUrl = "$primaryUrl/api/v1";
  static const String imageUrl = "$primaryUrl/";




///app url================================================
  static const String login = "/auth/signin";
  static const String forgot = "/auth/forget-password";
  static const String verifyOtp = "/auth/verify-reset-otp";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";

  ///create complain========================================

static const String createComplain="/complaints/create-request";
static  String getSingleComplain({complainId})=>"/complaints/get-single/$complainId";
  static String getAllComplain({
    required String status,
    required int page,
    required int limit,
  }) =>
      "/complaints/my?status=$status&page=$page&limit=$limit";
  static String upcomingDeadline ="/upcoming-deadlines/student?sectionIds=69919b90a39db2efefc243ea";
  static String academicProgress ="/final-grade/student/academic-progress?programId=699a9a3ed08a2c30363d8c98";


  ///message====================================================

static String conversationList="/messages/conversations";
  static const String searchUsers = '/messages/search-users';

}

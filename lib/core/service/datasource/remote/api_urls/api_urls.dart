class ApiUrl {
  //Live Server
  static const String primaryUrl = "http://56.228.56.225:5000"; // ////

  //local Server
  // static const String primaryUrl = "http://10.10.20.45:5000";

  // static const String primaryUrl = "https://sg6hn18x-5555.inc1.devtunnels.ms";
  //static const String primaryUrl = "https://sg6hn18x-5000.inc1.devtunnels.ms";

  //static const String primaryUrl = "http://10.10.20.45:5555"; //local
  static const String baseUrl = "$primaryUrl/api/v1";
  // static const String baseUrl = "https://sta-map-point-2.onrender.com/api/v1";
  static const String imageUrl = "$primaryUrl/";




///app url================================================
  static const String login = "/auth/signin";




  //
  // static String deleteNotifications({required String id}) =>
  //     "/notification/delete-notification/$id";
}

class AppConstants {
  static String bearerToken = "BearerToken";
  static String refreshToken = "RefreshToken";
  static String userId = "UserId";



  /// <====================== All Response Message Static==============================>

  static String error = "Oops, something went wrong";
  static String profileID = "profileID";
  static String userStatus = "userStatus";
  static String rememberMe = "rememberMe";
  static var chatId = "chatID";
  static String isRememberMe = "isRememberMe";

  static String map = 'https://i.sstatic.net/HILmr.png';

  static String unknown =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/500px-Unknown_person.jpg';

  static String restaurantImage =
      'https://images.pexels.com/photos/941861/pexels-photo-941861.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

}

enum Status { loading, error, completed, internetError }

enum UserType { myProfile, anotherProfile }

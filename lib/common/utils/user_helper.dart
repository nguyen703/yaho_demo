import 'package:yaho_demo/domain/entities/user/user.dart';

class UserHelper {
  UserHelper._();

  /// This functions checks for null and empty String, then returns the default
  /// String "Username" if the User instance doesn't get the correct format.
  ///
  /// Return [user.firstName], a white-space, and [user.lastName] if got the correct format.
  ///
  static String getUserName(User user) {
    // return Default value if both fields are null
    if (user.firstName == null && user.lastName == null) {
      return "Username";
    }

    // Get non-nullable String
    final firstName = user.firstName == null ? "" : user.firstName!.trim();
    final lastName = user.lastName == null ? "" : user.lastName!.trim();

    // return Default value if both fields are null
    if (firstName.isEmpty && lastName.isEmpty) return "Username";

    // Only get firstName
    if (firstName.isEmpty && lastName.isNotEmpty) return lastName;

    // Only get lastName
    if (firstName.isNotEmpty && lastName.isEmpty) return firstName;

    // Happy case, user got both firstName and lastName
    return "$firstName $lastName";
  }

  /// This functions checks for null and empty String, then returns the default
  /// "User email not found 🥸" if the User instance
  /// doesn't get the correct format.
  ///
  /// Return [user.email] if got the correct format.
  ///
  static String getUserEmail(User user) {
    if (user.email == null) return "User email not found 🥸";

    final userEmail = user.email!.trim();
    if (userEmail.isEmpty) return "User email not found 🥸";

    return userEmail;
  }
}

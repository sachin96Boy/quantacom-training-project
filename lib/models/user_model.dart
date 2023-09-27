enum UserRole { user, admin }

class UserModel {
  final String userId;
  final String userEmail;
  final String userName;
  final String password;
  final UserRole userRole;

  UserModel(
      {required this.userEmail,
      required this.userName,
      required this.password,
      required this.userId,
      required this.userRole});
}

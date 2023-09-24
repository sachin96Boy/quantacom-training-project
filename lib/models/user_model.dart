enum UserRole { user, admin }

class UserModel {
  final String userEmail;
  final String userName;
  final String password;
  final UserRole userRole;

  UserModel(
      {required this.userEmail,
      required this.userName,
      required this.password,
      this.userRole = UserRole.user});
}

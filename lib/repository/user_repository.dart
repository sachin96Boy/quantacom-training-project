import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_app_quantacom/models/user_model.dart';
import 'package:web_app_quantacom/utils/dio_instance.dart';

class UserRepository extends ChangeNotifier {
  List<UserModel> _users;

  UserRepository(this._users);

  List<UserModel> get users {
    return [..._users];
  }

  Future<void> fetchAndSetUserData() async {
    final respoonse = await dioInstance.get('/api/v1/users');

    final extractedUsers = respoonse.data;

    final List<UserModel> filledUsers = [];

    for (var user in extractedUsers) {
      filledUsers.add(
        UserModel(
          userEmail: user['userEmail'],
          userName: user['userName'],
          password: user['password'],
          userId: user['id'],
          userRole: user['userType'] == "USER" ? UserRole.user : UserRole.admin,
        ),
      );
    }

    _users = filledUsers;
    notifyListeners();
  }

  Future<void> passwordReset(String userid, Map<String, String> values) async {
    await dioInstance.put(
      '/api/v1/users/$userid',
      data: json.encode({"newPassword": values["newpassword"]}),
    );

    notifyListeners();
  }

  Future<void> UserCreation(Map<String, String> values) async {
    final response = await dioInstance.post('/api/v1/auth/signup',
        data: json.encode(values));

    if (response.statusCode == 200) {
      final result = response.data as Map<String, dynamic>;
      UserModel newUser = UserModel(
          userEmail: result["userEmail"],
          userName: result["userName"],
          password: result["password"],
          userId: result["id"],
          userRole: UserRole.user);
      _users.add(newUser);
      notifyListeners();
    }
  }
}

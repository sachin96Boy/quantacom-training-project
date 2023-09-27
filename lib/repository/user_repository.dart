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

    final extractedUsers = json.decode(respoonse.data) as List<dynamic>;

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
}

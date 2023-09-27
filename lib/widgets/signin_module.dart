import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_quantacom/utils/dio_instance.dart';

class SignInModule extends StatefulWidget {
  final SharedPreferences prefs;
  const SignInModule({super.key, required this.prefs});

  @override
  State<SignInModule> createState() => _SignInModuleState();
}

class _SignInModuleState extends State<SignInModule> {
  final _formKey = GlobalKey<FormState>();
  var initialValues = {"username": "", "password": ""};

  void _handleLogin() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    // add logic to login request

    try {
      final response = await dioInstance.post(
        '/api/v1/auth/signin',
        data: json.encode(initialValues),
      );
      if (response.statusCode == 200) {
        final extractedData = response.data as Map<String, dynamic>;
        await prefs.setString('userName', extractedData['userName']);
        await prefs.setString('userEmail', extractedData['userEmail']);
        await prefs.setString('userType', extractedData['userType']);
        await prefs.setString('token', extractedData['token']);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Let's get in",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), labelText: "Enter username"),
                  onSaved: (newValue) {
                    initialValues["username"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username can't be Blank";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.password), labelText: "password"),
                  onSaved: (newValue) {
                    initialValues["password"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password can't be Blank";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: _handleLogin,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

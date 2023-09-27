import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_quantacom/repository/auth_provider.dart';

class SignInModule extends StatefulWidget {
  final SharedPreferences prefs;
  const SignInModule({super.key, required this.prefs});

  @override
  State<SignInModule> createState() => _SignInModuleState();
}

class _SignInModuleState extends State<SignInModule> {
  final _formKey = GlobalKey<FormState>();
  var initialValues = {"username": "", "password": ""};

  void _handleLogin() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    // add logic to login request

    Provider.of<Auth>(context, listen: false)
        .handleLogin(initialValues, widget.prefs);
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

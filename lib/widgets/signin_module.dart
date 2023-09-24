import 'package:flutter/material.dart';

class SignInModule extends StatefulWidget {
  const SignInModule({super.key});

  @override
  State<SignInModule> createState() => _SignInModuleState();
}

class _SignInModuleState extends State<SignInModule> {
  final _formKey = GlobalKey<FormState>();
  var initialValues = {"userEmail": "", "password": ""};

  void _handleLogin() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    // add logic to login request
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Let's get in",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      icon: Icon(Icons.email), labelText: "Enter Email"),
                  onSaved: (newValue) {
                    initialValues["userEmail"] = newValue!;
                  },
                  validator: (value) {
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return "Email can't be Blank";
                    }
                    if (!emailValid) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                TextFormField(
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
                      onPressed: _handleLogin,
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontSize: 25.0),
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

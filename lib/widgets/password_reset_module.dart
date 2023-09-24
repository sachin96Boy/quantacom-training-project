import 'package:flutter/material.dart';

class PasswordResetModule extends StatefulWidget {
  const PasswordResetModule({super.key});

  @override
  State<PasswordResetModule> createState() => _PasswordResetModuleState();
}

class _PasswordResetModuleState extends State<PasswordResetModule> {
  final _formKey = GlobalKey<FormState>();

  var initialValues = {"newPassword": "", "confirmedPassword": ""};

  void _handlePasswordResetSubmit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Reset Password",
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
                      icon: Icon(Icons.password), labelText: "Enter Password"),
                  onSaved: (newValue) {
                    initialValues["newPassword"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password can't be Blank";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.visibility_off),
                      labelText: "ReEnter Password"),
                  obscureText: true,
                  onSaved: (newValue) {
                    initialValues["confirmedPassword"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password can't be Blank";
                    }
                    if (value != initialValues["newPassword"]) {
                      return "Passwords does not match";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: _handlePasswordResetSubmit,
                    child: const Text("Submit"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

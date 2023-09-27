import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_quantacom/repository/auth_provider.dart';
import 'package:web_app_quantacom/repository/user_repository.dart';

class PasswordResetModule extends StatefulWidget {
  const PasswordResetModule({super.key});

  @override
  State<PasswordResetModule> createState() => _PasswordResetModuleState();
}

class _PasswordResetModuleState extends State<PasswordResetModule> {
  final _formKeypasswords = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  var initialValues = {"newpassword": "", "confpassword": ""};

  @override
  void dispose() {
    // TODO: implement dispose
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  void _handlePasswordResetSubmit() {
    final isValid = _formKeypasswords.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKeypasswords.currentState?.save();
    // add logic to password reset request
    final userId = Provider.of<Auth>(context, listen: false).userId;
    Provider.of<UserRepository>(context, listen: false)
        .passwordReset(userId, initialValues)
        .then((_) => {
              _formKeypasswords.currentState!.reset(),
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Update Complete")))
            });
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
            key: _formKeypasswords,
            child: Column(
              children: [
                TextFormField(
                  controller: _pass,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.password), labelText: "Enter Password"),
                  onSaved: (newValue) {
                    initialValues["newpassword"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password can't be Blank";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPass,
                  obscureText: true,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.visibility_off),
                      labelText: "ReEnter Password"),
                  // obscureText: true,
                  onSaved: (newValue) {
                    initialValues["confpassword"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password can't be Blank";
                    }
                    if (value != _pass.text) {
                      return "passwords don't match";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: _handlePasswordResetSubmit,
                      child: const Text("Submit")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

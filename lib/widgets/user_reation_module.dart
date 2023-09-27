import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_quantacom/repository/user_repository.dart';

class UserCreationModule extends StatefulWidget {
  const UserCreationModule({super.key});

  @override
  State<UserCreationModule> createState() => _UserCreationModuleState();
}

class _UserCreationModuleState extends State<UserCreationModule> {
  final _formKeyusercreation = GlobalKey<FormState>();

  var initialValues = {"userEmail": "", "username": "", "password": ""};

  void _handleSubmitUser() {
    final isValid = _formKeyusercreation.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKeyusercreation.currentState?.save();
    // add logic to sae user request
    Provider.of<UserRepository>(context, listen: false)
        .UserCreation(initialValues)
        .then((_) => {
              _formKeyusercreation.currentState!.reset(),
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
            "Create User",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Form(
            key: _formKeyusercreation,
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
                      icon: Icon(Icons.person), labelText: "Username"),
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
                  child: ElevatedButton(
                      onPressed: _handleSubmitUser,
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

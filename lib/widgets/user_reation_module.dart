import 'package:flutter/material.dart';

class UserCreationModule extends StatefulWidget {
  const UserCreationModule({super.key});

  @override
  State<UserCreationModule> createState() => _UserCreationModuleState();
}

class _UserCreationModuleState extends State<UserCreationModule> {
  final _formKey = GlobalKey<FormState>();

  var initialValues = {"userEmail": "", "userName": "", "password": ""};

  void _handleSubmitUser() {
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
            "Create User",
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
                    if (value!.isEmpty) {
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
                    initialValues["userName"] = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username can't be Blank";
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
                ElevatedButton(
                    onPressed: _handleSubmitUser,
                    child: const Text("Submit"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

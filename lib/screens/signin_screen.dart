import 'package:flutter/material.dart';
import 'package:web_app_quantacom/widgets/signin_module.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/signin';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 150.0,
            height: 190.0,
            padding: const EdgeInsets.only(top: 40.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(200.0)),
            child: Center(
              child: Image.asset(
                'assets/images/newlogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SignInModule()
        ]),
      ),
    );
  }
}

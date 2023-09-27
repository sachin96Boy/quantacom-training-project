import 'package:flutter/material.dart';
import 'package:web_app_quantacom/widgets/password_reset_module.dart';

class PasswordResetScreen extends StatelessWidget {
  static const routeName = '/password-reset';
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('password Reset'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text("Password Reset Feature"),
            SizedBox(
              height: 20.0,
            ),
            PasswordResetModule()
          ],
        ),
      ),
    );
  }
}

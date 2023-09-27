import 'package:flutter/material.dart';
import 'package:web_app_quantacom/widgets/user_reation_module.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = "/admin";
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Previlages"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          Text("Admin features are below"),
          SizedBox(
            height: 20,
          ),
          UserCreationModule()
        ],
      )),
    );
  }
}

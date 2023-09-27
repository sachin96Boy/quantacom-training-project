import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_quantacom/models/user_model.dart';
import 'package:web_app_quantacom/repository/user_repository.dart';

class ProfileDetailsScreen extends StatelessWidget {
  static const routeName = "/person";
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final userId = args["userid"] as String;
    final selectedUser =
        Provider.of<UserRepository>(context, listen: false).findById(userId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employ Details saving Screen"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "User Details are available Below",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      Text(
                        selectedUser.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.email),
                      ),
                      Text(
                        selectedUser.userEmail,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.cases),
                      ),
                      Text(
                        selectedUser.userRole == UserRole.user
                            ? "USER"
                            : "ADMIN",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

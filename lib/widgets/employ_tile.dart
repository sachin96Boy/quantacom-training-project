import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_quantacom/repository/auth_provider.dart';
import 'package:web_app_quantacom/screens/profile_details_screen.dart';

class EmployTile extends StatelessWidget {
  final String username;
  final String userEmail;
  final String userId;
  const EmployTile(
      {super.key,
      required this.username,
      required this.userEmail,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<Auth>(context).sharedPreferences;
    final userType = prefs.getString("userType");
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(username),
      subtitle: Text(userEmail),
      trailing: IconButton(
        color: Colors.red,
        icon: const Icon(
          Icons.delete,
        ),
        disabledColor: Colors.grey,
        onPressed: userType == "USER" ? null : () {},
      ),
      onTap: () => Navigator.of(context).pushNamed(
          ProfileDetailsScreen.routeName,
          arguments: {"userid": userId}),
    );
  }
}

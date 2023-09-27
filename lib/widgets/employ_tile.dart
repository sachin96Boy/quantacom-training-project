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
        onPressed: userType == "USER"
            ? null
            : () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                              'This item will be no longer available'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("NO")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text("YES")),
                          ],
                        ));
              },
      ),
      onTap: () => Navigator.of(context).pushNamed(
          ProfileDetailsScreen.routeName,
          arguments: {"userid": userId}),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:web_app_quantacom/repository/auth_provider.dart';
import 'package:web_app_quantacom/screens/admin_screen.dart';
import 'package:web_app_quantacom/screens/password_reset_screen.dart';

class AppDrawerCustom extends StatelessWidget {
  const AppDrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<Auth>(context).sharedPreferences;
    String? userName = prefs.getString('userName');
    String? userType = prefs.getString('userType');
    return Drawer(
      backgroundColor: Colors.green[300],
      child: Column(children: [
        AppBar(
          title: Text(userName!),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.admin_panel_settings),
          title: const Text("Password Reset"),
          onTap: () {
            Navigator.of(context).pushNamed(PasswordResetScreen.routeName);
          },
          enabled: userType == "ADMIN" ? true : false,
        ),
        ListTile(
          leading: const Icon(Icons.person_add_alt_rounded),
          title: const Text("Add new User"),
          onTap: () {
            Navigator.of(context).pushNamed(AdminScreen.routeName);
          },
          enabled: userType == "ADMIN" ? true : false,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<Auth>(context, listen: false).handleLogout();
          },
        ),
      ]),
    );
  }
}

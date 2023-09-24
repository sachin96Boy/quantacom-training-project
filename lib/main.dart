import 'package:flutter/material.dart';
import 'package:web_app_quantacom/screens/admin_screen.dart';
import 'package:web_app_quantacom/screens/home_screen.dart';
import 'package:web_app_quantacom/screens/profile_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        AdminScreen.routeName: (context) => const AdminScreen(),
        ProfileDetailsScreen.routeName: (context) =>
            const ProfileDetailsScreen()
      },
    );
  }
}

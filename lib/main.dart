import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_quantacom/repository/auth_provider.dart';
import 'package:web_app_quantacom/repository/user_repository.dart';
import 'package:web_app_quantacom/screens/admin_screen.dart';
import 'package:web_app_quantacom/screens/home_screen.dart';
import 'package:web_app_quantacom/screens/profile_details_screen.dart';
import 'package:web_app_quantacom/screens/signin_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserRepository([]),
        ),
        ChangeNotifierProvider.value(
          value: Auth(null, null),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, value, _) => MaterialApp(
          title: 'Employ management',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => value.isAuth 
                ? HomeScreen(prefs: prefs)
                : SignInScreen(prefs: prefs),
            SignInScreen.routeName: (context) => SignInScreen(prefs: prefs),
            AdminScreen.routeName: (context) => const AdminScreen(),
            ProfileDetailsScreen.routeName: (context) =>
                const ProfileDetailsScreen()
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_quantacom/repository/auth_provider.dart';

import 'package:web_app_quantacom/repository/user_repository.dart';
import 'package:web_app_quantacom/screens/signin_screen.dart';

import 'package:web_app_quantacom/widgets/employ_record_grid.dart';

enum FilterOptions { profile, logout }

class HomeScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const HomeScreen({super.key, required this.prefs});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isloading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<UserRepository>(context).fetchAndSetUserData().then((_) => {
            setState(() {
              _isloading = false;
            })
          });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userlist = Provider.of<UserRepository>(context).users;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Employ Profile Databse",
          style: TextStyle(color: Colors.grey, fontSize: 20.0),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              // add logout and gotoprofile options

              // when logout clear storage
              // in profile page show user data and edit options

              if (value == FilterOptions.logout) {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false)
                    .handleLogout(widget.prefs)
                    .then((value) => Navigator.of(context).pushNamed('/'));
              }
            },
            icon: const CircleAvatar(child: Icon(Icons.person)),
            position: PopupMenuPosition.under,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.profile,
                child: Text("Go to Profile"),
              ),
              const PopupMenuItem(
                value: FilterOptions.logout,
                child: Text("Logout"),
              ),
            ],
          )
        ],
        primary: true,
        elevation: 2.0,
        centerTitle: true,
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
              children: [
                const SizedBox(
                  child: Text("Grid of Profile Data"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: EmployRecordGrid(
                    userList: userlist,
                  ),
                ),
              ],
            )),
    );
  }
}

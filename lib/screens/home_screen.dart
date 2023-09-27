import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_quantacom/models/user_model.dart';
import 'package:web_app_quantacom/repository/user_repository.dart';
import 'package:web_app_quantacom/utils/dio_instance.dart';
import 'package:web_app_quantacom/widgets/employ_record_grid.dart';

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

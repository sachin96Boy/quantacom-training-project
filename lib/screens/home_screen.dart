import 'package:flutter/material.dart';
import 'package:web_app_quantacom/models/user_model.dart';
import 'package:web_app_quantacom/widgets/employ_record_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserModel> dummyUsers = [
      UserModel(
          userEmail: "sac@gmail.com",
          userName: "zack",
          password: "Asdf1234@#",
          userId: "123ert"),
      UserModel(
          userEmail: "sac2@gmail.com",
          userName: "zack2",
          password: "Asdf1234@#",
          userId: "123ert2"),
      UserModel(
          userEmail: "sac3@gmail.com",
          userName: "zack3",
          password: "Asdf1234@#",
          userId: "123ert23"),
      UserModel(
          userEmail: "sac4@gmail.com",
          userName: "zack4",
          password: "Asdf1234@#",
          userId: "123ert24"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Employ Profile Databse",
          style: TextStyle(color: Colors.grey, fontSize: 20.0),
        ),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            child: Text("Grid of Profile Data"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: EmployRecordGrid(
              userList: dummyUsers,
            ),
          ),
        ],
      )),
    );
  }
}

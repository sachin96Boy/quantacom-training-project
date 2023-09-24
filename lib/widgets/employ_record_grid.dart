import 'package:flutter/material.dart';
import 'package:web_app_quantacom/models/user_model.dart';
import 'package:web_app_quantacom/widgets/employ_tile.dart';

class EmployRecordGrid extends StatelessWidget {
  final List<UserModel> userList;

  const EmployRecordGrid({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: userList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.brown.withOpacity(0.2)),
          child: EmployTile(
              username: userList[index].userName,
              userEmail: userList[index].userEmail,
              userId: userList[index].password),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/data/dummy_users.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = {...MOCK};
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuarios"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, i) => UserTile(users.values.elementAt(i)),
      ),
    );
  }
}

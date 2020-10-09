import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuarios"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              users.put(User(
                  email: 'teste@teste.com',
                  name: 'teste alterado',
                  avatarUrl: '',
                  id: '32'));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}

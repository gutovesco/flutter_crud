import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Icon(
        Icons.remove_circle_outline,
        color: Colors.redAccent,
      ),
    );
  }
}

Widget userTileIcons() {
  return Row(
    children: [
      Icon(
        Icons.remove_circle_outline,
        color: Colors.redAccent,
      ),
      Padding(
        padding: EdgeInsets.only(left: 20),
        child: Icon(
          Icons.edit,
          color: Colors.blueAccent,
        ),
      )
    ],
  );
}

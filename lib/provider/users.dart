import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  Map<String, User> _items = {...MOCK};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
          user.id,
          (_) => User(
                email: user.email,
                name: user.name,
                id: user.id,
                avatarUrl: user.avatarUrl,
              ));
    } else {
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => User(
              email: user.email,
              name: user.name,
              avatarUrl: user.avatarUrl,
              id: id));
    }

    notifyListeners();
  }

  void removeUser(String id) {
    if (id != null) {
      _items.remove(id);
      notifyListeners();
    }
  }
}

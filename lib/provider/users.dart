import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl = 'https://simple-crud-d8314.firebaseio.com/';
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

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.post(
        "$_baseUrl/users.json",
        body: json.encode(
          {
            'email': user.email,
            'name': user.name,
            'avatarUrl': user.avatarUrl,
          },
        ),
      );

      _items.update(
        user.id,
        (_) => User(
          email: user.email,
          name: user.name,
          id: user.id,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      final response = await http.post(
        "$_baseUrl/users.json",
        body: json.encode(
          {
            'email': user.email,
            'name': user.name,
            'avatarUrl': user.avatarUrl,
          },
        ),
      );

      final id = json.decode(response.body)['name'];

      _items.putIfAbsent(
        id,
        () => User(
          email: user.email,
          name: user.name,
          avatarUrl: user.avatarUrl,
          id: id,
        ),
      );
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

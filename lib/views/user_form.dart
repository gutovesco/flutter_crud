import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    print(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    email: _formData['email'],
                    name: _formData['name'],
                    avatarUrl: _formData['url'],
                    id: _formData['id'],
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: user != null ? user.name : '',
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => {_formData['name'] = value},
                // ignore: missing_return
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return 'Nome invalido';
                  }
                },
              ),
              TextFormField(
                initialValue: user != null ? user.email : '',
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => {_formData['email'] = value},
                // ignore: missing_return
                validator: (value) {
                  if (value == null || value.trim().length < 10) {
                    return 'E-mail invalido';
                  }
                },
              ),
              TextFormField(
                initialValue: user != null ? user.avatarUrl : '',
                decoration: InputDecoration(labelText: 'URL do avatar'),
                onSaved: (value) => {_formData['url'] = value},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

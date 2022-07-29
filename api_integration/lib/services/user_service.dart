import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

getUsers() async {
  var response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  var jsonData = jsonDecode(response.body);

  List<UserModel> users = [];
  for (var i in jsonData) {
    UserModel user =
        UserModel(id: i['id'], name: i['name'], username: i['username']);
    users.add(user);
  }
  return users;
}

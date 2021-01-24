import 'package:laravel_passport_flutter/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends ChangeNotifier {
  List<User> _data = [];
  List<User> get dataUser => _data;

  Future<List<User>> getUser() async {
    final url = 'http://192.168.43.229:8000/api/datauser';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result.map<User>((json) => User.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  // Future<User> findUser(int id) async {
  //   return _data.firstWhere((i) => i.id == id);
  // }

}

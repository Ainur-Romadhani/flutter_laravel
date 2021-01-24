import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laravel_passport_flutter/models/todomodel.dart';
import 'package:laravel_passport_flutter/models/usermodel.dart';
import 'dart:convert';

class UserController extends ChangeNotifier {
  List<Todo> _data = [];
  List<Todo> get dataTodo => _data;

  Future<List<Todo>> getTodo(id) async {
    final url = 'http://192.168.43.229:8000/api/todo/index/{id}';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data_todo'].cast<Map<String, dynamic>>();
      _data = result.map<Todo>((json) => Todo.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}

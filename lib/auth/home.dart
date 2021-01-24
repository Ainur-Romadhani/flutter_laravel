import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:laravel_passport_flutter/auth/login.dart';
import 'package:laravel_passport_flutter/konfigurasi/api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usermodel.dart';
import '../controller/usercontroller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final data = [
    User(
      id: 1,
      name: "dani",
      email: "dhani@gmail.com",
    ),
    User(
      id: 2,
      name: "dewi",
      email: "dewi@gmail.com",
    ),
    User(
      id: 2,
      name: "fian",
      email: "fian@gmail.com",
    ),
  ];
  String name;
  @override
  void initState() {
    _loadUserData();
    _dataUser();
    super.initState();
  }

  _dataUser() {
    setState(() {
      Provider.of<UserController>(context, listen: false).getUser();
    });
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('data'));

    if (user != null) {
      setState(() {
        name = user['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _dataUser();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings_power),
        onPressed: logout,
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () {
          setState(() {
            Provider.of<UserController>(context, listen: false).getUser();
          });
        },
        child: Container(
          margin: EdgeInsets.all(10),
          child: Consumer<UserController>(
            builder: (context, data, _) {
              return ListView.builder(
                itemCount: data.dataUser.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        data.dataUser[i].name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Email : ${data.dataUser[i].email}"),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().logOut('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('data');
      localStorage.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'http://172.26.114.250:4000/api/users';
  Map data = {};
  List usersData = [];
  getUsers() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      usersData = data['users'];
    });
  }

  addUser(url) async {
    await http.get(url + '/create');
  }

  remove(url) async {
    await http.get(url + '/remove');
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void _aggUsers() {
    setState(() {
      addUser(url);
    });
  }

  void _refresh() {
    setState(() {
      getUsers();
    });
  }

  void _delet() {
    setState(() {
      remove(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User List'),
          backgroundColor: Colors.indigo[900],
        ),
        body: ListView.builder(
          itemCount: usersData == null ? 0 : usersData.length,
          itemBuilder: (BuildContext context, int index) {
            int count = index + 1;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "$count",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(usersData[index]['avatar']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          "  ${usersData[index]['firstName']} ${usersData[index]['lastName']}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: Row(children: <Widget>[
          const SizedBox(
            height: 20,
            width: 214,
          ),
          FloatingActionButton(
            onPressed: _aggUsers,
            child: Icon(Icons.add),
          ),
          const SizedBox(
            height: 20,
            width: 5,
          ),
          FloatingActionButton(
            onPressed: _refresh,
            child: Icon(Icons.refresh_rounded),
          ),
          const SizedBox(
            height: 20,
            width: 5,
          ),
          FloatingActionButton(
            onPressed: _delet,
            child: Icon(Icons.delete),
          ),
        ]));
  }
}

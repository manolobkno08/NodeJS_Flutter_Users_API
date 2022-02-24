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
  String url = 'http://192.168.251.14:4000/api/users';
  Map data = {};
  List usersData = [];
  int countUser = 0;
  getUsers() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      usersData = data['users'];
    });
  }

  addUser(url, count) async {
    if (count != 0 && count > 0) {
      await http.get(url + '/create/$count');
      setState(() {
        countUser = 0;
      });
    } else {
      print('No se puso ningun numero');
    }
  }

  remove(url, count) async {
    await http.delete(url + '/delete');
    setState(() {
      countUser = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void _addUsers() {
    setState(() {
      addUser(url, countUser);
    });
  }

  void _refresh() {
    getUsers();
  }

  void _delet() {
    setState(() {
      remove(url, countUser);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Row(children: <Widget>[
          const SizedBox(
            height: 20,
            width: 214,
          ),
          FloatingActionButton(
            onPressed: () async {
              _addUsers();
              Future.delayed(const Duration(milliseconds: 200), () {
                _refresh();
              });
            },
            elevation: 20.0,
            backgroundColor: Colors.greenAccent[400],
            child: Icon(Icons.add),
          ),
          const SizedBox(
            height: 20,
            width: 5,
          ),
          FloatingActionButton(
            onPressed: () async {
              _delet();
              Future.delayed(const Duration(milliseconds: 200), () {
                _refresh();
              });
            },
            elevation: 20.0,
            backgroundColor: Colors.red[600],
            child: Icon(Icons.delete),
          ),
          const SizedBox(
            height: 20,
            width: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                countUser++;
              });
            },
            elevation: 20.0,
            backgroundColor: Colors.deepPurple[50],
            child: Text(
              '$countUser',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ),
        ]));
  }
}

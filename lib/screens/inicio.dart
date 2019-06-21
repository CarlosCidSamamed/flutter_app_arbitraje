import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService auth = new AuthService();

  bool userDocOK = false;

  @override
  Widget build(BuildContext context) {
    return UserManegement().handleAuth();
    /*return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      drawer: MenuLateral(),
      body: GridView.count(
        primary: false,
        padding: EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: <Widget>[
          Text("Página accesible para todos los usuarios"),
        ],
      ),
    );*/
  }
}
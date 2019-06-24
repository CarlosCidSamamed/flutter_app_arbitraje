// Pantalla Inicial para un Admin de la App
// Acceso total a los datos y a las funcionalidades de la app
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthService auth = new AuthService();
  final _db = Firestore.instance;
  bool userDocOK = false;

  @override
  Widget build(BuildContext context) {
    // Se evalúa el usuario que ha iniciado sesión para poder redirigir a cada uno a su pantalla correspondiente.
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    //return UsuariosList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin - Stats"),
      ),
      drawer: MenuLateral(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.list),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.search),
              title: Text(''),
            ),
          ].toList(),
          onTap: (int idx) {
            switch(idx){
              case 0:{
                print("Se ha pulsado Listados");
                Navigator.of(context).pushNamed('/listados');
                break;
              }
              case 1:{
                print("Se ha pulsado Buscador");
                break;
              }
            }
          }
      ),
      body: GridView.count(
        primary: false,
        padding: EdgeInsets.all(10.0),
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          CustomStatCard(
            icono: FontAwesomeIcons.userAlt,
            dato: "0",
          ),
          CustomStatCard(
            icono: FontAwesomeIcons.book,
            dato: "0",
          ),
          CustomStatCard(
            icono: FontAwesomeIcons.trophy,
            dato: "0",
          ),
          CustomStatCard(
            icono: null,
            assetIcono2: "assets/icons/boxing-glove.png",
            dato: "0",
          ),
          CustomStatCard(
            icono: null,
            assetIcono2: "assets/icons/boxing.png",
            dato: "0",
          ),
          CustomStatCard(
            icono: null,
            assetIcono2: "assets/icons/open-hand.png",
            dato: "0",
          ),
        ],
      ),
    );


  }



}


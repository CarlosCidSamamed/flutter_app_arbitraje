// Pantalla Inicial para un Admin de la App
// Acceso total a los datos y a las funcionalidades de la app
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthService auth = new AuthService();

  bool userDocOK = false;

  @override
  Widget build(BuildContext context) {
    // Se evalúa el usuario que ha iniciado sesión para poder redirigir a cada uno a su pantalla correspondiente.
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    return FutureBuilder(
      future: Global.usuariosRef.getData(), // Obtiene los datos de todos los usuarios registrados en la BD en la colección Usuarios.
      builder: (BuildContext context, AsyncSnapshot snap) {
        if(snap.hasData){
          List<Usuario> usuarios = snap.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Administración'),
            ),
            drawer: MenuLateral(),
            body: GridView.count(
              primary: false,
              padding: EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: usuarios.map((usuario) => UsuarioItem(usuario: usuario)).toList(),
            ),
          );
        } else {
          return LoadingScreen(); // Mientras no se leen los datos para el FutureBuilder se muestra una pantalla de carga.
        }
      },
    );
  }



}


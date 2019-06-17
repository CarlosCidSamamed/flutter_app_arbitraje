import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {

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
              title: Text('Lista de Usuarios'),
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
        }
      },
    );
  }
}

class UsuarioItem extends StatelessWidget {
  final Usuario usuario;
  const UsuarioItem({Key key, this.usuario }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
          tag: usuario.foto,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap:  () {
                // TODO: Completar esta clase siguiendo la clase topcis.dart (Fireship)
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => UsuarioScreen(usuario: usuario),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment(0.0, 0.0),
                    child: Image.network(usuario.foto, fit: BoxFit.fitWidth),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              usuario.nombreUsuario,
                              style: TextStyle(
                                height: 1.5, fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

class UsuarioScreen extends StatelessWidget {
  final Usuario usuario;

  UsuarioScreen({ this.usuario });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Hero(
            tag: usuario.foto,
            child: Image.network(
              usuario.foto, width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            usuario.nombreUsuario,
            style: TextStyle(height : 2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            usuario.mostrarRol(usuario.rol),
            style: TextStyle(height : 2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            usuario.email,
            style: TextStyle(height : 2, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
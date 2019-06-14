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

  @override
  Widget build(BuildContext context) {
    // Se evalúa el usuario que ha iniciado sesión para poder redirigir a cada uno a su pantalla correspondiente.
    //FirebaseUser user = Provider.of<FirebaseUser>(context);
    auth.getUser.then((user) {
      if(user != null) { // Si un usuario ha iniciado sesión se lee su registro en la colección USUARIOS para comprobar su ROL.
        // Obtener los datos del usuario cuyo documento de la colección USUARIOS tiene el nombre de user.uid
        UserData<Usuario> docUsuario = new UserData<Usuario>(
            collection: 'usuarios');
        if (docUsuario.getDocument() != null) {
          Future<Usuario> usuario = docUsuario.getDocument();
          usuario.then((v) {
            switch (v.rol) {
              case Rol.Admin:
                {
                  Navigator.pushNamed(context, '/admin');
                  break;
                }
              case Rol.Editor:
                {
                  //Navigator.pushNamed(context, '/editor');
                  break;
                }
              case Rol.JuezMesa:
                {
                  //Navigator.pushNamed(context, '/mesa');
                  break;
                }
              case Rol.JuezSilla:
                {
                  //Navigator.pushNamed(context, '/silla');
                  break;
                }
              case Rol.Visitante:
                {
                  //Navigator.pushNamed(context, '/visitante');
                  break;
                }
              default:
                {
                  Navigator.pushNamed(context, '/acerca');
                  break;
                }
            }
          }, onError: (e) {
            print(e.toString());
          });
        }
      } else {
        return Container(
          child: Center(
            child: Text('Inicio'),
          ),
        );
      }
    });
  }
}
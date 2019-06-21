// En esta clase definiremos el acceso basado en roles a las distintas partes de la App.
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/screens.dart';
import '../shared/shared.dart';

class UserManegement {
  Widget handleAuth(){
    return new StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged, // Se usa el cambio de estado de Auth como stream de datos. Al cambiar el estado se le notifica a esta clase.
      builder: (BuildContext context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingScreen();
        }
        if(snapshot.hasData) {
          return ProfileScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  // En este método se redirigirá a los usuarios a la página de inicio que les corresponde según rol.
  authorizeAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/usuarios')
          .getDocuments()
          .then((docs) {
            if(docs.documents[0].exists){                     // Si existe el documento para el usuario actual
              if(docs.documents[0].data['Rol'] == 'admin') {  // y es ADMIN
                Navigator.of(context).pushNamed('/admin');
              }
              else if(docs.documents[0].data['Rol'] == 'editor') {
                //Navigator.of(context).pushNamed('/editor');   // y es EDITOR
              }
              else if(docs.documents[0].data['Rol'] == 'juezMesa') {
                //Navigator.of(context).pushNamed('/mesa');
              }
              else if(docs.documents[0].data['Rol'] == 'juezSilla') {
                //Navigator.of(context).pushNamed('/silla');
              }
              else if(docs.documents[0].data['Rol'] == 'visitante') {
                //Navigator.of(context).pushNamed('/visitante');
              }
              else {
                Navigator.of(context).pushNamed('/acerca');
              }
            }
      });
    });
  }
}
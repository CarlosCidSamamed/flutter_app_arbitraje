import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]); // Bloquear la orientación de la pantalla a vertical y sin invertir.

    if (user != null) {
      LoadingScreen();
      Future datos = UserData<Usuario>(collection: 'usuarios').getDocument();
      if (datos == null) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Error al obtener los datos del Usuario de la BD..."),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/acerca');
                },
                child: Text("Cerrar")),
          ],
        );
      } else {
        print('FIREBASE AUTH USER UID : ' + user.uid);
        print('Se han leído datos del usuario de la BD');
        return FutureBuilder(
            future: datos,//Global.userRef.getDocument(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Usuario usuario = snapshot.data;
                  return Scaffold(
                    appBar: AppBar(
                        title: Text('Perfil del Usuario'),
                    ),
                    body: Stack(
                      children: [
                        Column(
                          children: [
                            CustomCard(
                              urlFoto: user.photoUrl ?? '',
                              icono: FontAwesomeIcons.google,
                              titulo: user.displayName ?? '',
                              texto1: user.email ?? '',
                              texto2: '',
                            ),
                            CustomCard(
                              urlFoto: usuario.foto ?? '',
                              icono: FontAwesomeIcons.user,
                              titulo: usuario.nombreUsuario ?? '',
                              texto1: usuario.mostrarRol(usuario.rol) ?? '',
                              texto2: usuario.email ?? '',
                            ),
                            /*IconButton(
                                icon: Icon(FontAwesomeIcons.signOutAlt),
                                color: Colors.purpleAccent,
                                onPressed: () {
                                  auth.signOut();
                                  Navigator.of(context).pushNamed('/');
                            }),*/
                          ],
                        ),
                      ],
                    ),
                    drawer: MenuLateral(),
                  );
                }
                if (snapshot.hasError) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text(
                        "Error al obtener los datos del Usuario de la BD...\n\n" +
                            snapshot.error.toString()),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/acerca');
                          },
                          child: Text("Cerrar")),
                    ],
                  );
                }
              } else {
                return LoadingScreen();
              }
            }
        );
      }
    }
  }
}

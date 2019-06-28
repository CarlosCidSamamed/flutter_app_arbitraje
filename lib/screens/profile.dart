import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  bool checkScreenSize(BuildContext context){
    bool res = false;
    if(MediaQuery.of(context).size.width < 500) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]); // Bloquear la orientación de la pantalla a vertical y sin invertir.
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]); // Bloquear la orientación de la pantalla a horiznotal y sin invertir.
      res = true;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    bool horizontal = checkScreenSize(context);

    if(!horizontal) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]); // Bloquear la orientación de la pantalla a vertical y sin invertir.
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    }
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomUsuarioCard(
                                urlFoto: user.photoUrl ?? '',
                                icono: FontAwesomeIcons.google,
                                titulo: user.displayName ?? '',
                                texto1: user.email ?? '',
                                texto2: '',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomUsuarioCard(
                                urlFoto: usuario.foto ?? '',
                                icono: FontAwesomeIcons.user,
                                titulo: usuario.nombreUsuario ?? '',
                                texto1: usuario.mostrarRol(usuario.rol) ?? '',
                                texto2: usuario.email ?? '',
                              ),
                            ),
                            IconButton(
                                icon: Icon(FontAwesomeIcons.signOutAlt),
                                color: Colors.purpleAccent,
                                onPressed: () {
                                  auth.signOut();
                                  Navigator.of(context).pushNamed('/');
                            }),
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
    } else {
      return LoadingScreen();
    }
  }


}

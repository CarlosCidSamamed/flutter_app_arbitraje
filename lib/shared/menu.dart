import 'package:flutter/material.dart';
import 'package:flutter_app_arbitraje/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MenuLateral extends StatelessWidget {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    // Si el usuario es un Invitado el menú tiene otras opciones.
    if (user == null) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Volver al inicio'),
              trailing: Icon(FontAwesomeIcons.signOutAlt),
            ),
          ],
        ),
      );
    } else {
      // Si el usuario ha iniciado sesión se muestra el menú correspondiente
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),),
            ),
            ListTile(
              title: Text('Inicio'),
              trailing: Icon(FontAwesomeIcons.home),
              onTap: () {
                Navigator.pushNamed(context, '/inicio');
                //Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Listados'),
              trailing: Icon(FontAwesomeIcons.list),
              onTap: () {
                Navigator.pop(context); // Cerrar el menú lateral.
              },
            ),
            ListTile(
              title: Text("Buscador"),
              trailing: Icon(FontAwesomeIcons.search),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Perfil'),
              trailing: Icon(FontAwesomeIcons.user),
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              trailing: Icon(FontAwesomeIcons.signOutAlt),
              onTap: () {
                auth.signOut();
                Navigator.pushNamed(context, '/');
              },
            )
          ],
        ),
      );
    }
  }
}
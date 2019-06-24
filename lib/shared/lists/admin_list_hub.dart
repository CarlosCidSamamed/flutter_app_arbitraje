// En esta clase se definirá la pantalla desde la cual se podrá acceder a los distintos listados.
// Estos listados mostrarán distintas entidades y poseerán una serie de filtros que dependerán del modelo del que se ocupen.

import 'package:flutter/material.dart';
import '../../shared/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminListHubScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin -- Listados"),
      ),
      drawer: MenuLateral(),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.userAlt),
            title: Text("Usuarios"),
            onTap: () {
              Navigator.of(context).pushNamed('/listados/usuarios');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.book),
            title: Text("Organizaciones"),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.trophy),
            title: Text("Campeonatos"),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: ImageIcon(AssetImage("assets/icons/boxing-glove.png")),
            title: Text("Competidores"),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: ImageIcon(AssetImage("assets/icons/boxing.png")),
            title: Text("Combates"),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
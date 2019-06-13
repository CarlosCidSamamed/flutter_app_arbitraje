// Definición del listado para los organizadores de los distintos campeonatos.

import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class OrganizadoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.organizadoresRef.getData(),  // Los datos de la BD correspondientes a los Organizadores.
      builder: (BuildContext context, AsyncSnapshot snap) {
        if(snap.hasData){
          List<Organizador> orgs = snap.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text('Organizadores'),
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.userCircle,
                    color: Colors.pink[200]),
                  onPressed: () => Navigator.pushNamed(context, '/perfil'),
                )
              ],
            ),
            drawer: MenuLateral(),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 1,
              children: orgs.map((org) => OrganizadorItem(organizador: org)).toList(),
            ),
            bottomNavigationBar: AppBottomNav(),
          );
        }
      },
    );
  }
}

class OrganizadorItem extends StatelessWidget {
  final Organizador organizador;
  const OrganizadorItem({Key key, this.organizador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: organizador.logo,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => OrganizadorScreen(organizador: organizador)),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(organizador.logo),
                Row(children: [
                  Text(organizador.nombre),
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrganizadorScreen extends StatelessWidget {
  final Organizador organizador;

  OrganizadorScreen({ this.organizador });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: organizador.logo,
            child: Image.network(organizador.logo),
          ),
          Text(
            organizador.nombre,
            style:
              TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      )
    );
  }
}
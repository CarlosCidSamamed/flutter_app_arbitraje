// Definición del listado para los organizadores de los distintos campeonatos.

import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrganizadoresScreen extends StatefulWidget {
  @override
  _OrganizadoresScreenState createState() => _OrganizadoresScreenState();
}

class _OrganizadoresScreenState extends State<OrganizadoresScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.organizadoresRef.getData(),
      // Los datos de la BD correspondientes a los Organizadores.
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
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
              children:
                  orgs.map((org) => OrganizadorItem(organizador: org)).toList(),
            ),
            bottomNavigationBar: AppBottomNav(),
          );
        } else {
          return LoadingScreen();
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
    if (organizador == null) {
      print("Organizador == Null -- OrganizadorItem");
      return LoadingScreen();
    } else {
      print("Nombre del Organizador --> " + organizador.nombre);
      return Scaffold(
        appBar: AppBar(
          title: Text("OrganizadorItem"),
        ),
        drawer: MenuLateral(),
        body: Container(
          child: Hero(
            tag: (organizador.logo != null) ? organizador.logo : 'logo',
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            OrganizadorScreen(organizador: organizador)),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LimitedBox(
                        maxHeight: MediaQuery.of(context).size.height,
                        maxWidth: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LimitedBox(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 4,
                                maxWidth: MediaQuery.of(context).size.width / 4,
                                child: (organizador.logo != null)
                                    ? Image.network(organizador.logo)
                                    : Image.asset('assets/icons/logo_app1.png'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(organizador.nombre),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

class OrganizadorScreen extends StatelessWidget {
  final Organizador organizador;

  OrganizadorScreen({this.organizador});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          title: Text("Detalle del Organizador"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.edit,
                color: Colors.lightGreen,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.times,
                color: Colors.redAccent,
              ),
              title: Text(''),
            ),
          ].toList(),
          onTap: (int idx) {
            switch (idx) {
              case 0:
                {
                  print("Se ha pulsado EDITAR");
                  MyDialog(
                    message: "Editar Datos",
                  ).showMyAlertDialog(context, Organizador);
                  break;
                }
              case 1:
                {
                  print("Se ha pulsado ELIMINAR");
                  MyDialog(
                    message: "Eliminar Datos",
                  ).showMyDeleteDialog(context, Organizador);
                  break;
                }
            }
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LimitedBox(
                maxWidth: MediaQuery.of(context).size.width / 3,
                maxHeight: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Hero(
                    tag: (organizador.logo != null) ? organizador.logo : 'logo',
                    child: (organizador.logo != null)
                        ? Image.network(organizador.logo)
                        : Image.asset('assets/icons/logo_app1.png'),
                  ),
                ),
              ),
            ),
            Text(
              organizador.nombre,
              style: TextStyle(
                  height: 2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Info Contacto
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(organizador.direccion),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(organizador.ciudad),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LimitedBox(
                          maxHeight: 75,
                          maxWidth: 75,
                          child: Tooltip(
                            message: organizador.pais,
                            child: Image(
                                image: getFlagForCountry(organizador.pais)),
                          )),
                    ),
                  ],
                ),
                // Info Contacto 2
                Column(
                  children: <Widget>[
                    (organizador.telf != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.phone),
                              ),
                              Text(organizador.telf)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.phone),
                              ),
                              Text('Teléfono')
                            ],
                          ),
                    (organizador.email != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.envelope),
                              ),
                              Text(organizador.email)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.envelope),
                              ),
                              Text('Email')
                            ],
                          ),
                    (organizador.web != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.chrome),
                              ),
                              Text(organizador.web)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.chrome),
                              ),
                              Text('Web')
                            ],
                          ),
                  ],
                ),
                // Stats
                Column(
                  children: <Widget>[
                    (organizador.numCamps != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.trophy),
                              ),
                              Text(organizador.numCamps.toString()),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.trophy),
                              ),
                              Text('Campeonatos'),
                            ],
                          ),
                    (organizador.numCompetidores != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(AssetImage(
                                    'assets/icons/boxing-glove.png')),
                              ),
                              Text(organizador.numCompetidores.toString()),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(AssetImage(
                                    'assets/icons/boxing-glove.png')),
                              ),
                              Text('Competidores'),
                            ],
                          ),
                    (organizador.numJueces != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                    AssetImage('assets/icons/open-hand.png')),
                              ),
                              Text(organizador.numJueces.toString()),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                    AssetImage('assets/icons/open-hand.png')),
                              ),
                              Text('Jueces'),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

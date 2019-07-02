import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CampeonatosScreen extends StatefulWidget {
  @override
  _CampeonatosScreenState createState() => _CampeonatosScreenState();
}

class _CampeonatosScreenState extends State<CampeonatosScreen> {
  Future<List<Campeonato>> campFuture;
  FirebaseUser user;

  bool esAdmin;
  bool esEditor;
  String _idOrg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /*@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Campeonatos'),
      ),
      drawer: MenuLateral(),
      body: Container(
        width: 200,
        height: 200,
        child: Text('CampFuture == null'),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: Para construir el Future con los Campeonatos correctos deberemos evaluar el rol del usuario que ha iniciado sesión:
    // ADMIN: Podrá acceder a TODOS los Campeonatos de la BD.
    // EDITOR: Podrá acceder a los Campeonatos de la BD que dependan de su organización.

    user = Provider.of<FirebaseUser>(context);
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
      // ADMIN o EDITOR
      /*FutureBuilder datosUsuario = new FutureBuilder(
        future: datos,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            if (snapshot.hasError) {
              print(
                  'Error al leer los datos del Usuario -- _CampeonatosScreenState.build / datosUsuario');
              return LoadingScreen();
            } else {
              Usuario usuario = snapshot.data;
              if (usuario.rol == 'admin') {
                esAdmin = true;
              } else if (usuario.rol == 'editor') {
                esEditor = true;
                _idOrg = usuario.idOrg;
              }
            }
          }
        },
      );

      if (esAdmin) {
        // Todos los Campeonatos
        campFuture = Global.campeonatosRef.getData();
      } else if (esEditor) {
        // Los Campeonatos cuyo idOrg coincida con el indicado.
        //campFuture = Collection<Campeonato>(path: 'campeonatos').getData(); // TODO --> Aprender a filtrar los resultados de este tipo de consulta.
        campFuture = Collection<Campeonato>(path: 'campeonatos')
            .getFilteredDataCampsIdOrg(Campeonato().idOrg, _idOrg);
      }*/

      //campFuture = Global.campeonatosRef.getData();
      campFuture = Collection<Campeonato>(path: 'campeonatos').getData();

      if (campFuture == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Campeonatos'),
          ),
          drawer: MenuLateral(),
          body: Container(
            width: 200,
            height: 200,
            child: Text('CampFuture == null'),
          ),
        );
      }
    } // else

    return FutureBuilder(
      future: Global.campeonatosRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Campeonatos'),
              ),
              drawer: MenuLateral(),
              body: Container(
                child: LoadingScreen(),
              ));
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Campeonatos'),
              ),
              drawer: MenuLateral(),
              body: Container(
                child: AlertDialog(
                  title: Text('Error'),
                  content: Text(
                      'Error al cargar los datos del Future de Campeonatos desde la BD'),
                ),
              ));
        } else if (snapshot.hasData) {
          List<Campeonato> lista = snapshot.data;
          print('Tamaño de la lista de Campeonatos --> ' +
              lista.length.toString());

          // TODO: Mostrar la lista de Campeonatos correspondiente al nivel de privilegios del Usuario Logueado.
          return Scaffold(
            appBar: AppBar(
              title: Text('Campeonatos'),
            ),
            drawer: MenuLateral(),
            body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: 1,
                children: [
                  //lista.map((camp) => CampeonatoItem(campeonato: camp)).toList();

                  Text('Tamaño de la lista de Campeonatos --> ' +
                      lista.length.toString()),
                ]),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Campeonatos'),
            ),
            drawer: MenuLateral(),
            body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: 1,
                children: [
                  Text('Tamaño de la lista de Campeonatos -->  0'),
                ]),
          );
        }
      },
    );
  }
}


class CampeonatoScreen extends StatelessWidget {
  final Campeonato campeonato;

  CampeonatoScreen({this.campeonato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Campeonato'),
      ),
      drawer: MenuLateral(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              LimitedBox(
                maxWidth: 100,
                maxHeight: 200,
                child: (campeonato.urlCartel != null)
                    ? Image.network(campeonato.urlCartel)
                    : Text('Cartel no disponible'),
              ),
              Text(
                campeonato.nombre,
                style: TextStyle(
                  height: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Fecha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(FontAwesomeIcons.calendar),
                  Text(campeonato.fecha),
                ],
              ),
              // Lugar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(FontAwesomeIcons.locationArrow),
                  Text(campeonato.lugar),
                ],
              ),
              // Tipo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(FontAwesomeIcons.bell),
                  Text(campeonato.tipo),
                ],
              ),
            ],
          ),
          // Listas en principio vacías hasta que se pulse el botón de "Mostrar"
          ParteListas(),
        ],
      ),
    );
  }

  Widget ParteListas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Lista Jueces
        Column(),
        // Lista Modalidades
        Column(),
        // Lista de Zonas de Combate
        Column()
      ],
    );
  }
}

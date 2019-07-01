// En esta clase se definirá la pantalla de Mesa durante el arbitraje de un asalto.

import 'package:flutter/material.dart';
import 'package:flutter_app_arbitraje/services/services.dart';
import 'package:flutter_app_arbitraje/shared/shared.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MesaScreen extends StatefulWidget {
  // Ha de ser un stateful widget porque deberemos actualizar muchas partes de la UI dependiendo del estado del widget y de la app.

  final Firestore _db = Firestore.instance;

  final String idCamp;
  final String idMod;
  final String idCat;
  final String idCombate;
  final String idAsalto;

  MesaScreen(
      {this.idCamp, this.idMod, this.idCat, this.idCombate, this.idAsalto});

  @override
  _MesaScreenState createState() => _MesaScreenState();
}

class _MesaScreenState extends State<MesaScreen> {
  @override
  Widget build(BuildContext context) {
    /*// Referencia al documento donde se guarda la información del combate al que pertenece el asalto actual.
    DocumentReference combateRef = widget._db.collection('campeonatos').document(widget.idCamp)
        .collection('modalidades').document(widget.idMod)
        .collection('categorias').document(widget.idCat)
        .collection('combates').document(widget.idCombate);
    // Referencia al documento del asalto actual.
    DocumentReference asaltoRef = widget._db.collection('campeonatos').document(widget.idCamp)
        .collection('modalidades').document(widget.idMod)
        .collection('categorias').document(widget.idCat)
        .collection('combates').document(widget.idCombate)
        .collection('asaltos').document(widget.idAsalto);*/
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla de Mesa"),
      ),
      drawer: MenuLateral(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            //MyCountdownTimer(),
            UIRojo(),
            UICentral(),
            UIAzul(),
          ],
        ),
      ),
    );
  }

  Widget UIRojo(/*Usuario rojo, Combate combate, Asalto asalto*/) {
    // Columna Izquierda de la UI que contendrá los elementos de UI correpondientes al Competidor Rojo
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Foto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/default_avatar.png'),
            ),
            // Nombre
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Nombre Competidor Rojo'),
            ),
            // Puntuación Media
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '0',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0),
              ),
            ),
            // Fila de Botones de Amonestación, Penalización, Salida y Cuenta
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Text('A'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Text('P'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Text('S'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Text('C'),
                  ),
                ),
              ],
            ),
            // Fila de Texts con A, P, S y C para Asalto 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            ),
            // Fila de Texts con A, P, S y C para Asalto 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            ),
            // Fila de Texts con A, P, S y C para Asalto 3
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            ),
            // StreamBuilder con las puntuaciones de los Jueces de Silla en tiempo real.
            // Usaremos un StreamBuilder para poder actualizar la UI cada vez que se añada una puntuación a la BD para este Asalto.
            /*StreamBuilder(
              stream: ,
              builder: ,
            ),*/
          ],
        ),
      ),
    );
  }

  Widget UIAzul(/*Usuario azul, Combate combate, Asalto asalto*/) {
    // Columna Derecha de la UI que contendrá los elementos de UI correpondientes al Competidor Azul
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Foto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/default_avatar.png'),
            ),
            // Nombre
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Nombre Competidor Azul'),
            ),
            // Puntuación Media
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '0',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0),
              ),
            ),
            // Fila de Botones de Amonestación, Penalización, Salida y Cuenta
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text('A'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text('P'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text('S'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text('C'),
                  ),
                ),
              ],
            ),
            // Fila de Texts con A, P, S y C para Asalto 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            ),
            // Fila de Texts con A, P, S y C para Asalto 2
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            ),
            // Fila de Texts con A, P, S y C para Asalto 3
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                Text('0',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            ),
            // ListView con las puntuaciones de los Jueces de Silla en tiempo real.
            // Usaremos un StreamBuilder para poder actualizar la UI cada vez que se añada una puntuación a la BD para este Asalto.
          ],
        ),
      ),
    );
  }

  Widget UICentral(/*Combate combate, Asalto asalto*/) {
    // Columna Central de la UI que contendrá los elementos de UI correpondientes al Crono, sus botones y los botones de inicio y fin de asalto y combate.
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Número de Combate
            Text('Combate'),
            // Número de Asalto
            Text('Asalto'),
            // Crono con sus botones
            //Text('Crono'),
            MyCountdownTimer(),
            // Fila de Botones de KO y TKO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.grey,
                    child: Text('KO'),
                  ),
                ),
                LimitedBox(
                  maxWidth: 75,
                  maxHeight: 75,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.grey,
                    child: Text('TKO'),
                  ),
                ),
              ],
            ),
            // Boton de Inicio Asalto
            LimitedBox(
              maxWidth: 75,
              maxHeight: 75,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.grey,
                child: Text('Inicio Asalto'),
              ),
            ),
            // Boton de Fin Asalto
            LimitedBox(
              maxWidth: 75,
              maxHeight: 75,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.grey,
                child: Text('Fin Asalto'),
              ),
            ),
            // Boton de Fin Combate
            LimitedBox(
              maxWidth: 75,
              maxHeight: 75,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.grey,
                child: Text('Fin Combate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

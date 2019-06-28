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
      { this.idCamp, this.idMod, this.idCat, this.idCombate, this.idAsalto });

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]);
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
            MyCountdownTimer(),
            //UIRojo(),
            //UICentral(),
            //UIAzul(),
          ],
        ),
      ),
    );
  }

  Widget UIRojo(/*Usuario rojo, Combate combate, Asalto asalto*/) {
    // Columna Izquierda de la UI que contendrá los elementos de UI correpondientes al Competidor Rojo
    return LimitedBox(
      maxHeight: MediaQuery
          .of(context)
          .size
          .height,
      maxWidth: MediaQuery
          .of(context)
          .size
          .width / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          // Foto
          // Nombre
          // Puntuación Media
          // Fila de Botones de Amonestación, Penalización, Salida y Cuenta
          // Fila de Texts con A, P, S y C para Asalto 1
          // Fila de Texts con A, P, S y C para Asalto 2
          // Fila de Texts con A, P, S y C para Asalto 3
          ],
        ),
      ),
    );
  }

  Widget UIAzul(/*Usuario azul, Combate combate, Asalto asalto*/) {
    // Columna Derecha de la UI que contendrá los elementos de UI correpondientes al Competidor Azul
    return LimitedBox(
      maxHeight: MediaQuery
          .of(context)
          .size
          .height,
      maxWidth: MediaQuery
          .of(context)
          .size
          .width / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Foto
            // Nombre
            // Puntuación Media
            // Fila de Botones de Amonestación, Penalización, Salida y Cuenta
            // Fila de Texts con A, P, S y C para Asalto 1
            // Fila de Texts con A, P, S y C para Asalto 2
            // Fila de Texts con A, P, S y C para Asalto 3
          ],
        ),
      ),
    );
  }

  Widget UICentral(/*Combate combate, Asalto asalto*/) {
    // Columna Central de la UI que contendrá los elementos de UI correpondientes al Crono, sus botones y los botones de inicio y fin de asalto y combate.
    return LimitedBox(
      maxHeight: MediaQuery
          .of(context)
          .size
          .height,
      maxWidth: MediaQuery
          .of(context)
          .size
          .width / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Número de Combate
            // Número de Asalto
            // Crono con sus botones
            MyCountdownTimer(),
            // Fila de Botones de KO y TKO
            // Boton de Inicio Asalto
            // Boton de Fin Asalto
            // Boton de Fin Combate
          ],
        ),
      ),
    );
  }

}

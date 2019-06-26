// En esta clase se definirá el proceso de selección del layout de la app según el tipo de dispositivo.
// Layout Uno --> Tablet
// Layout Dos --> Móvil de pantalla de 5'' o más
// Layout Tres --> Móvil de pantalla menor de 5''

import 'package:flutter/material.dart';
import 'shared.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_arbitraje/services/services.dart';
import 'package:flutter/services.dart';

class SelectLayout extends StatefulWidget {

  final String tit;

  SelectLayout({  this.tit });

  @override
  _SelectLayoutState createState() => _SelectLayoutState();
}

class _SelectLayoutState extends State<SelectLayout> {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < 500) {
            return OneColumnLayoutMini(); // TRES
          } else  if (constraints.maxWidth < 600){
            return OneColumnLayout();     // DOS
          } else {
            return TwoColumnsLayout(titulo: widget.tit,);    // UNO
          }
        },
    );
  }
}

// Layout para móviles cuya resolución sea menor de 500 pixeles de ancho
class OneColumnLayoutMini extends StatefulWidget {
  @override
  _OneColumnLayoutMiniState createState() => _OneColumnLayoutMiniState();
}

class _OneColumnLayoutMiniState extends State<OneColumnLayoutMini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("OneColumnLayoutMini"),
    );
  }
}

// Layout para móviles cuya resolución sea menor de 600 pixeles de ancho
class OneColumnLayout extends StatefulWidget {
  @override
  _OneColumnLayoutState createState() => _OneColumnLayoutState();
}

class _OneColumnLayoutState extends State<OneColumnLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("OneColumnLayout"),
    );
  }
}

// Layout para tablets o "phablets"
class TwoColumnsLayout extends StatefulWidget {

  final String titulo;

  TwoColumnsLayout({this.titulo});

  @override
  _TwoColumnsLayoutState createState() => _TwoColumnsLayoutState();
}

class _TwoColumnsLayoutState extends State<TwoColumnsLayout> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]); // Esto pone el layout de dos columnas en modo horizontal - landscape left.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      drawer: MenuLateral(),
      body: // Aquí deberemos definir las dos secciones que tendrá el layout.
        Row(
          children: <Widget>[
            Expanded(
              child: TCLMain( // Parte central
                dataFuture: Global.usuariosRef.getData(),
                tipo: Usuario,
              ),
            ),
            TCLOptions( // Lateral derecho con opciones
            ),
          ],
        ),
    );
  }
}

// La parte principal del Layout de Dos Columnas.
class TCLMain extends StatefulWidget {

  final Future dataFuture;
  final Type tipo; // Se define el tipo de dato que mostrará la parte central del layout para

  TCLMain({ this.dataFuture, this.tipo });

  @override
  _TCLMainState createState() => _TCLMainState();
}

class _TCLMainState extends State<TCLMain> {
  @override
  Widget build(BuildContext context) {
    print("LimitedBox maxWidth --> " + MediaQuery.of(context).size.width.toString());
    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width - 200,
      maxHeight: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: widget.dataFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingScreen();
          } else {
            if(snapshot.hasError){
              print("TCLMain -- Error al obtener los datos del Future");
              return LoadingScreen();
            } else if(snapshot.hasData){
              List<Usuario> usuarios = snapshot.data;
              return ListView(
                children: usuarios.map((usuario) => CustomUsuarioListCard(
                  altura: 150, anchura: 150,
                  urlFoto: usuario.foto,
                  nombre: usuario.nombreUsuario,
                  rol: usuario.mostrarRol(usuario.rol),
                )).toList(),
              );
            }
          }
        }
      ),

    );
  }
}

Type obtenerTipoDatosLista<T>(List<T> e) => T;
Type obtenerTipoDatosFuture<T>(Future<T> f) => T;

class TCLOptions extends StatefulWidget {
  @override
  _TCLOptionsState createState() => _TCLOptionsState();
}

class _TCLOptionsState extends State<TCLOptions> {
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 200.0,
      maxHeight: MediaQuery.of(context).size.height,
      child: Container(
        child: Text("Aquí irá el menú de opciones"),
      ),
    );
  }
}






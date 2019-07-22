// En esta clase se definirá el proceso de selección del layout de la app según el tipo de dispositivo.
// Layout Uno --> Tablet
// Layout Dos --> Móvil de pantalla de 5'' o más
// Layout Tres --> Móvil de pantalla menor de 5''

import 'package:flutter/material.dart';
import 'shared.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_arbitraje/services/services.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectLayout extends StatefulWidget {

  final String tit;
  final Type type;

  SelectLayout({ Key key, this.tit, this.type}) : super(key: key);

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
            return TwoColumnsLayout(titulo: widget.tit, tipo: widget.type,);    // UNO
          }
        },
    );
  }
}

// Layout para móviles cuya resolución sea menor de 500 pixeles de ancho
class OneColumnLayoutMini extends StatefulWidget {

  OneColumnLayoutMini ({ Key key }) : super(key: key);

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

  OneColumnLayout({ Key key }) : super(key: key);

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
  final Type tipo;

  TwoColumnsLayout({Key key, this.titulo, this.tipo}): super(key: key);

  @override
  _TwoColumnsLayoutState createState() => _TwoColumnsLayoutState();
}

class _TwoColumnsLayoutState extends State<TwoColumnsLayout> {

  @override
  void initState() {
    super.initState();
  }
  
  Future getDataFuture(Type tipo){
    switch(tipo){
      case Usuario: {
        return Global.usuariosRef.getData();
      }
      case Organizador: {
        return Global.organizadoresRef.getData();
      }
      case Campeonato: {
        return Global.campeonatosRef.getData();
      }
      default: {
        return null;
      }
    }
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
                dataFuture: getDataFuture(widget.tipo),
                tipo: widget.tipo,
              ),
            ),
            TCLOptions( // Lateral derecho con opciones
              tipo: widget.tipo,
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

  TCLMain({ Key key, this.dataFuture, this.tipo }) : super(key: key);

  @override
  _TCLMainState createState() => _TCLMainState();
}

class _TCLMainState extends State<TCLMain> {


  //static TextEditingController controller = new TextEditingController();
  String filter;



  /*static TextEditingController getController (){
    return controller;
  }*/

  @override
  void initState() {
    super.initState();
    /*controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });*/
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.dataFuture == null){
      return LimitedBox(
          maxWidth: MediaQuery.of(context).size.width - 200,
          maxHeight: MediaQuery.of(context).size.height,
          child: Center(child: Text("_TCLMainState.build ha recibido un dataFuture NULL")),
      );
    } else return LimitedBox(
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
              switch(widget.tipo){
                case Usuario: {
                  List<Usuario> usuarios = snapshot.data;
                  return ListView(
                    children: usuarios.map((usuario) => CustomUsuarioListCard(
                      altura: 150, anchura: 150,
                      urlFoto: usuario.foto,
                      nombre: usuario.nombreUsuario,
                      rol: usuario.mostrarRol(usuario.rol),
                      icono: FontAwesomeIcons.userAlt,
                    )).toList(),
                  );
                }
                case Organizador: {
                  List<Organizador> orgs = snapshot.data;
                  return ListView(
                    children: orgs.map((org) => CustomOrgListCard(
                      org: org,
                      altura: 150, anchura: 150,
                      urlLogo: org.logo,
                      nombre: org.nombre,
                      pais: org.pais,
                      ciudad: org.ciudad,
                    )).toList(),
                  );
                }
                case Campeonato: {
                  List<Campeonato> camps = snapshot.data;
                  return ListView(
                    children: camps.map((camp) => CustomCampListCard(
                      campeonato: camp,
                      altura: 150, anchura: 150,
                      nombre: camp.nombre,
                      fecha: camp.fecha,
                      lugar: camp.lugar,
                    )).toList(),
                  );
                }
                default: {
                  return Text("El Tipo especificado en el constructor de TCLMain no coincide con ninguno de los modelos de la App");
                }
              }

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

  final Type tipo;

  TCLOptions ({ Key key, this.tipo }) : super(key: key);

  @override
  _TCLOptionsState createState() => _TCLOptionsState();
}

class _TCLOptionsState extends State<TCLOptions> {

  List<String> roles = ["Admin", "Editor", "JuezMesa", "JuezSilla", "Visitante"];
  List<String> tiposOrgs = ["Federación", "Asociación"];
  List<String> tiposCamps = ["Provincial", "Autonómico", "Nacional", "Internacional"];
  List<DropdownMenuItem<String>> elementosLista;
  String valorActual;
  List<String> datos = new List();

  List<DropdownMenuItem<String>> getElementosLista(Type t){
    List<DropdownMenuItem<String>> lista = new List();
    switch(t){
      case Usuario: {
        datos = roles;
        break;
      }
      case Organizador :{
        datos = tiposOrgs;
        break;
      }
      case Campeonato: {
        datos = tiposCamps;
        break;
      }
      case Competidor: {
        break;
      }
      case Combate: {
        break;
      }
    }
    for(String r in datos){
      print(r);
      lista.add(new DropdownMenuItem(
        value: r,
        child: Text(r),
      ));
    }
    return lista;
  }

  void changeDropDownItem(String valor){
    setState(() {
      valorActual = valor;
    });
  }

  @override
  void initState() {
    elementosLista = getElementosLista(widget.tipo);
    valorActual = elementosLista[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 200.0,
      maxHeight: MediaQuery.of(context).size.height,
      child: Container(
        width: 200,
        child: Column(
          children: [
            Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Text("Opciones"),
                  Divider(),
                  TextField(
                    //controller: _TCLMainState.getController(),
                    decoration: InputDecoration(
                      labelText: "Buscador",
                      hintText: "Buscador",
                      prefixIcon: Icon(FontAwesomeIcons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                  Divider(),
                  Icon(FontAwesomeIcons.filter),
                  DropdownButton(
                    value: valorActual,
                    items: datos.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: changeDropDownItem,
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.0,
              child: Container(
                width: 200,
                child: Column(
                  children: [
                    BotonesOpciones(tipo: widget.tipo),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BotonesOpciones extends StatelessWidget {

  final Type tipo;

  BotonesOpciones({Key key, this.tipo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(tipo){
      case Usuario: {
        return Column(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.user),
                onPressed: () {
                  print("BotonesOpciones --> Pulsado Botón Nuevo Usuario...");
                  Navigator.of(context).pushNamed('/add/usuario');
                }),
          ],
        );
      }
      case Organizador: {
        return Column(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.book),
                onPressed: null)
          ],
        );
      }
      case Campeonato: {
        return Column(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.trophy),
                onPressed: null)
          ],
        );
      }
      case Competidor: {
        return Column(
          children: [
            IconButton(
                icon: ImageIcon(AssetImage("assets/icons/boxing-glove.png")),
                onPressed: null)
          ],
        );
      }
      case Combate: {
        return Column(
          children: [
            IconButton(
                icon: ImageIcon(AssetImage("assets/icons/boxing.png")),
                onPressed: null)
          ],
        );
      }
      default: {
        return Column(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.google),
                onPressed: null)
          ],
        );
      }
    }
  }
}







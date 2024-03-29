// En esta clase definiremos los widgets que serán usados en distintas partes de la app.
import 'package:flutter/material.dart';
import '../services/models.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioItem extends StatelessWidget {
  final Usuario usuario;
  const UsuarioItem({Key key, this.usuario }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: usuario.foto,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap:  () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsuarioScreen(usuario: usuario),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Container(
                    padding: EdgeInsets.all(20.0),
                    child: Image.network(usuario.foto, fit: BoxFit.scaleDown, alignment: Alignment.bottomCenter,),
                  ),*/
                Expanded(
                  child: Container(
                    child: Image.network(usuario.foto, fit: BoxFit.fitHeight),
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  flex: 1,
                ),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          usuario.nombreUsuario,
                          style: TextStyle(
                              height: 1.5, fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsuarioScreen extends StatelessWidget {
  final Usuario usuario;

  UsuarioScreen({ this.usuario });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Usuario'),
      ),
      body: ListView(
        children: [
          Hero(
            tag: usuario.foto,
            child: Container(
              child: Image.network(usuario.foto,),
              padding: EdgeInsets.all(100.0),
            ),
          ),
          Text(
            usuario.nombreUsuario,
            style: TextStyle(height : 2, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            usuario.mostrarRol(usuario.rol),
            style: TextStyle(height : 2, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            usuario.email,
            style: TextStyle(height : 2, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidEdit),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userTimes),
              title: Text(''),
            ),
          ].toList(),
          onTap: (int idx) {
            switch(idx){
              case 0:{
                print("Se ha pulsado EDITAR");
                MyDialog(message: "Editar Datos",).showMyAlertDialog(context, Usuario);
                break;
              }
              case 1:{
                print("Se ha pulsado ELIMINAR");
                MyDialog(message: "Eliminar Datos",).showMyDeleteDialog(context, Usuario);
                break;
              }
            }
          },
      ),
    );
  }
}

class MyDialog extends Dialog {

  final String message;

  MyDialog ({this.message});

  Future<void> showMyAlertDialog (BuildContext context, Type tipo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Desea editar los datos de ' + tipo.toString() + '?'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Aceptar'),
              textColor: Colors.white,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {
                print("Se ha pulsado Aceptar Edición");
                /*Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: MyCustomForm(),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );*/
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: MyCustomForm(),
                    );
                  }
                );
              },
            ),
            RaisedButton(
              child: Text('Cancelar'),
              textColor: Colors.white,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> showMyDeleteDialog(BuildContext context, Type tipo) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          title: Text(message),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('¿Desea eliminar los datos de ' + tipo.toString() + '?'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                  child: Text('Aceptar'),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    print("Se ha pulsado Aceptar Eliminación");
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                  child: Text('Cancelar'),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyFilterDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
              title: Text(message),
              children: <Widget>[
                //FiltroUsuarios(),
              ]
          );
        }
        );
  }
}


class UsuariosList extends StatefulWidget {
  @override
  _UsuariosListState createState() => _UsuariosListState();
}

class _UsuariosListState extends State<UsuariosList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.usuariosRef.getData(), // Obtiene los datos de todos los usuarios registrados en la BD en la colección Usuarios.
      builder: (BuildContext context, AsyncSnapshot snap) {
        if(snap.hasData){
          List<Usuario> usuarios = snap.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Admin - Usuarios'),
            ),
            drawer: MenuLateral(),
            body: GridView.count(
              primary: false,
              padding: EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: usuarios.map((usuario) => UsuarioItem(usuario: usuario)).toList(),
            ),
          );
        } else {
          return LoadingScreen(); // Mientras no se leen los datos para el FutureBuilder se muestra una pantalla de carga.
        }
      },
    );
  }
}

class EditButtonForList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.edit, color: Colors.lightGreen,),
      onPressed: () {
        print("EditButtonForList --> PULSADO");
      }, // TODO
      tooltip: 'Editar',
      iconSize: 20.0,
    );
  }
}

class DeleteButtonForList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.times, color: Colors.redAccent,),
      onPressed: () {
        print("DeleteButtonForList --> PULSADO");
      }, //TODO
      tooltip: 'Eliminar',
      iconSize: 20.0,
    );
  }
}


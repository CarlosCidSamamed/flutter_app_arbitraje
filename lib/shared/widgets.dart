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
                MyDialog(message: "Editar Datos",).showMyAlertDialog(context);
                break;
              }
              case 1:{
                print("Se ha pulsado ELIMINAR");
                MyDialog(message: "Eliminar Datos",).showMyDeleteDialog(context);
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

  Future<void> showMyAlertDialog (BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Desea editar los datos de este Usuario?'),
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

  Future<void> showMyDeleteDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          title: Text(message),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('¿Desea eliminar los datos de este Usuario?'),
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
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

  String uid;

  @override
  Widget build(BuildContext context) {
    user.then((value) {
      uid = value.uid;
    });
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Widget con los campos correspondientes a cada uno de los modelos de la BD.

          //TODO: REvisar la definción de EditUsuarioWidget --> Mi idea es generar un formulario scrollable con los campos editables del documento de un Usuario.
          //EditUsuarioWidget(uid: uid),

          /*TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Introduzca texto';
              }
              return null;
            },
          ),*/
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Processando Datos')));
                    }
                  },
                  child: Text('Enviar'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ),
            ],
          ),
        ],

      ),
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

class EditUsuarioWidget extends StatefulWidget {

  final String uid;

  EditUsuarioWidget({ this.uid });

  @override
  _EditUsuarioWidgetState createState() => _EditUsuarioWidgetState();
}

class _EditUsuarioWidgetState extends State<EditUsuarioWidget> {
  Future<Usuario> oldValues;
  List<String> strings;
  List<DropdownMenuItem<String>> items;
  String valorActual;

  @override
  Widget build(BuildContext context) {
    LoadingScreen();
    oldValues = UserData<Usuario>(collection: 'usuarios').getDocument();
    if(oldValues == null){
      return AlertDialog(
        title: Text("Error"),
        content: Text("Error al leer el documento del Usuario de la BD..."),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cerrar"),
          ),
        ],
      );
    } else {
      strings = ['Admin', 'Editor', 'Juez de Mesa', 'Juez de Silla', 'Visitante'];
      items = strings.map((String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ));
      return FutureBuilder(
        future: oldValues,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Stack( // Este será el widget que definirá el cuerpo del formulario de edición de los datos de un Usuario.
            children: <Widget>[
              Column(
                children: <Widget>[
                  // Nombre de Usuario
                  TextFormField(
                    decoration:const InputDecoration(
                      icon: Icon(FontAwesomeIcons.user),
                      hintText: "Nombre de Usuario",
                      labelText: "Nombre",
                    ),
                    onSaved: (String value) {
                      // Aquí deberemos actualizar el valor del campo nombreUsuario en el documento de la BD.
                    },
                    validator: (String value) {
                      return value.length < 5 ? 'El nombre es demasiado corto' : '';
                    },
                  ),
                  // Password
                  TextFormField(),
                  // Email
                  TextFormField(),
                  // Foto
                  TextFormField(),
                  // Rol
                  DropdownButton(
                    value: 'Elija',
                    items: this.items,
                    onChanged: ((String newValue) {
                      setState(() {
                        valorActual = newValue;
                      });
                    }),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }
}

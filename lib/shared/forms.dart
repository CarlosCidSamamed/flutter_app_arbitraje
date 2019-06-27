import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'shared.dart';
import '../services//services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      /*strings = ['Admin', 'Editor', 'Juez de Mesa', 'Juez de Silla', 'Visitante'];
      items = strings.map((String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ));*/
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
                      labelText: "Nombre de Usuario",
                    ),
                    onSaved: (String value) {
                      // Aquí deberemos actualizar el valor del campo nombreUsuario en el documento de la BD.
                    },
                    validator: (String value) {
                      if(value.length < 5) {
                        return 'El nombre es demasiado corto';
                      } else {
                        return null;
                      }
                    },
                  ),
                  // Password
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(FontAwesomeIcons.key),
                      hintText: "Contraseña",
                      labelText: "Contraseña",
                    ),
                    onSaved: (String value){

                    },
                    validator: (String value) {
                      if (value.length < 6) {
                        return 'La contraseña es demasiado corta';
                      } else {
                        return null;
                      }
                    },
                  ),
                  // Email
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(FontAwesomeIcons.envelope),
                      hintText: "Email",
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String value) {

                    },
                    validator: (String value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);
                      if(!regExp.hasMatch(value)){
                        return "El email no tiene un formato correcto";
                      } else {
                        return null;
                      }
                    },
                  ),
                  // Foto
                  //TextFormField(),
                  // Rol
                  /*DropdownButton(
                    value: 'Elija',
                    items: this.items,
                    onChanged: ((String newValue) {
                      setState(() {
                        valorActual = newValue;
                      });
                    }),
                  ),*/
                ],
              ),
            ],
          );
        },
      );
    }
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

          EditUsuarioWidget(uid: uid),

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
                      _formKey.currentState.save(); // Ejecutará los métodos onSave de los distintos campos del formulario.
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

class NuevoUsuarioForm extends StatefulWidget { // Para poder validar los datos deberemos usar un StatefulWidget para poder actualizar la UI en caso de datos erróneos.

  @override
  _NuevoUsuarioFormState createState() => _NuevoUsuarioFormState();
}

class _NuevoUsuarioFormState extends State<NuevoUsuarioForm> with ValidationMixin{

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String nombre = '';
  String rol = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo Usuario"),),
      drawer: MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  emailField(),
                  nombreUsuarioField(),
                  rolField(),
                  Container(margin: EdgeInsets.only(top: 25.0),),
                  botonEnviar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email",
      ),
      validator: validateEmail,
      onSaved: (String value){
        email = value;
      },
    );
  }

  Widget nombreUsuarioField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nombre de Usuario",
        hintText: "Nombre",
      ),
      validator: validateNombreUsuario,
      onSaved: (String value){
        nombre = value;
      },
    );
  }

  Widget rolField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Rol",
        hintText: "Rol",
      ),
      validator: validateRol,
      onSaved: (String value){
        rol = value;
      },
    );
  }

  Widget botonEnviar() {
    return RaisedButton(
      color: Colors.blueAccent,
      child: Text('Enviar'),
      onPressed: () {
        if(formKey.currentState.validate()){ // Comprueba la key del form y valida los datos usando los métodos validator de cada campo del formulario.
          formKey.currentState.save();
        }
      });
  }
}

// La validación se realizará en un Mixin para poder compartir el código que aquí se define con otras clases
class ValidationMixin {
  String validateEmail(String value) {
    if(!value.contains('@')){
      return "El Email introducido no es correcto...";
    }
    return null;
  }

  String validatePassword(String value){
    if(value.length < 6){
      return "La contraseña es demasiado corta...";
    }
    return null;
  }

  String validateNombreUsuario(String value){
    if(value.length < 6){
      return "El Nombre de Usuario es demasiado corto...";
    }
    return null;
  }

  String validateRol(String value){
    String rol = value.toLowerCase();
    if((rol == "admin") ||
      (rol == "editor") ||
      (rol == "juezmesa") ||
      (rol == "juezsilla") ||
      (rol == "visitante")){
      return null;
    }
    return "El Rol no es correcto. (admin, editor, juezmesa, juezsilla, visitante)";
  }
}

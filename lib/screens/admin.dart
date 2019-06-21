// Pantalla Inicial para un Admin de la App
// Acceso total a los datos y a las funcionalidades de la app
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthService auth = new AuthService();

  bool userDocOK = false;

  @override
  Widget build(BuildContext context) {
    // Se evalúa el usuario que ha iniciado sesión para poder redirigir a cada uno a su pantalla correspondiente.
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return UsuariosList();
  }



}


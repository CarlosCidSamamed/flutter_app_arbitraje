// Pantalla Inicial para un Admin de la App
// Acceso total a los datos y a las funcionalidades de la app
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: Text('Página principal de Administración de la App'),
      ),
      drawer: MenuLateral(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home, size: 20),
          title: Text('Inicio'),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.list, size: 20),
          title: Text('Listados'),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user, size: 20)
        ),
      ].toList(),
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch(idx) {
          case 0: {
            break;
          }
          case 1: {
            Navigator.pushNamed(context, '/listados');
            break;
          }
          case 2: {
            Navigator.pushNamed(context, '/perfil');
            break;
          }
        }
      },
    );
  }
}
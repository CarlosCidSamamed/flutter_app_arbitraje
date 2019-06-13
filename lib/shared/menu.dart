import 'package:flutter/material.dart';


class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menú'),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          ListTile(
            title: Text('Listados'),
            onTap: () {
              Navigator.pop(context); // Cerrar el menú lateral.
            },
          ),
          ListTile(
            title: Text("Buscador"),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
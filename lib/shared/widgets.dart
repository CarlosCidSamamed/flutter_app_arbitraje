// En esta clase definiremos los widgets que serán usados en distintas partes de la app.
import 'package:flutter/material.dart';
import '../services/models.dart';
import 'package:flutter/widgets.dart';

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
    );
  }
}
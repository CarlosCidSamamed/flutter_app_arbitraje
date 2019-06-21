import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  String urlFoto;
  IconData icono;
  String titulo;
  String texto1;
  String texto2;

  CustomCard({ this.urlFoto, this.icono, this.titulo, this.texto1, this.texto2 });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100,
              height: 100,
              //margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image : DecorationImage(image: NetworkImage(urlFoto)),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Icon(icono),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  titulo,
                  style: TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  texto1,
                  style: TextStyle(
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  texto2,
                  style: TextStyle(
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
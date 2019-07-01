import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:flutter_app_arbitraje/shared/shared.dart';
import 'package:flutter_app_arbitraje/services/services.dart';

class CustomUsuarioCard extends StatelessWidget {
  String urlFoto;
  IconData icono;
  String titulo;
  String texto1;
  String texto2;

  CustomUsuarioCard(
      {this.urlFoto, this.icono, this.titulo, this.texto1, this.texto2});

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
                image: DecorationImage(image: NetworkImage(urlFoto)),
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
                  style: TextStyle(height: 1.5, fontWeight: FontWeight.bold),
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

class CustomUsuarioListCard extends StatelessWidget {
  String urlFoto;
  IconData icono;
  String nombre;
  String rol;

  double altura;
  double anchura;

  CustomUsuarioListCard(
      {this.urlFoto,
      this.icono,
      this.nombre,
      this.rol,
      this.altura,
      this.anchura});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: LimitedBox(
        maxHeight: altura,
        maxWidth: anchura,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    image: DecorationImage(image: NetworkImage(urlFoto)),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(icono),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      nombre,
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      rol,
                      style: TextStyle(
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              EditButtonForList(),
              DeleteButtonForList(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOrgListCard extends StatelessWidget {
  Organizador org;

  String urlLogo;
  String nombre;
  String pais;
  String ciudad;

  double anchura;
  double altura;

  CustomOrgListCard(
      {this.org,
      this.urlLogo,
      this.nombre,
      this.pais,
      this.ciudad,
      this.anchura,
      this.altura});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => OrganizadorScreen(organizador: org,),
            ),
          );
        },
        child: LimitedBox(
          maxWidth: anchura,
          maxHeight: altura,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                        image: (urlLogo != null)
                            ? DecorationImage(image: NetworkImage(urlLogo))
                            : DecorationImage(
                                image:
                                    AssetImage("assets/icons/logo_app1.png"))),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        nombre,
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: //Text(pais),
                      Container(
                          height: 40,
                          width: 60,
                          child: Image(image: getFlagForCountry(pais))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ciudad),
                ),
                EditButtonForList(),
                DeleteButtonForList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AssetImage getFlagForCountry(String country) {
  print(country);
  switch (country) {
    case "España":
      {
        return AssetImage('assets/icons/flags/es.png');
      }
    default:
      {
        return AssetImage('assets/icons/logo_app1.png');
      }
  }
}

class CustomOrgCard extends StatelessWidget {
  String urlLogo;
  String nombre;
  String pais;
  String ciudad;

  double anchura;
  double altura;

  CustomOrgCard(
      {this.urlLogo,
      this.nombre,
      this.pais,
      this.ciudad,
      this.anchura,
      this.altura});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: (urlLogo != null)
                      ? DecorationImage(image: NetworkImage(urlLogo))
                      : DecorationImage(
                          image: AssetImage("assets/icons/logo_app1.png"))),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                nombre,
                style: TextStyle(height: 1.5, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 40,
                width: 60,
                child: Image(image: getFlagForCountry(pais))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ciudad),
          ),
        ],
      ),
    );
  }
}

class CustomStatCard extends StatelessWidget {
  final IconData icono;
  final Image icono2;
  final String assetIcono2;
  final String dato;

  CustomStatCard({this.icono, this.icono2, this.assetIcono2, this.dato});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(56.0),
        child: Column(
          children: <Widget>[
            icono != null ? Icon(icono) : ImageIcon(AssetImage(assetIcono2)),
            Divider(),
            Text(dato),
          ],
        ),
      ),
    );
  }
}

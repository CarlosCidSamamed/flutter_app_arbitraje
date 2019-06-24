// En esta clase se definirán los widgets que servirán para aplicar filtros a los listados del Admin.
import 'package:flutter/material.dart';
import '../services/services.dart';
import 'shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FiltroUsuarios extends StatefulWidget {
  @override
  _FiltroUsuariosState createState() => _FiltroUsuariosState();
}

class _FiltroUsuariosState extends State<FiltroUsuarios> {

  List<Usuario> usuarios;
  TextEditingController controller = new TextEditingController();
  String filtro;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filtro = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.usuariosRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        if(snapshot.hasData){
          usuarios = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("Admin -- Usuarios"),
            ),
            drawer: MenuLateral(),
            bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 50.0,
                ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print("Se ha pulsado el Floating Action Button");
                // Abrir una ventana modal en la que se muestre el selector de filtro y el campo de texto a buscar.
                /*Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        //MyDialog(message: "Filtro",).showMyFilterDialog(context);
                      }
                  ),
                );*/
              },
              child: Icon(FontAwesomeIcons.filter),
              backgroundColor: Colors.purpleAccent,
            ),
            body: GridView.count(
              primary: false,
              padding: EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: usuarios.map((usuario) => UsuarioItem(usuario: usuario)).toList(),
            ),
          );
        }
      },
    );
  }
}

class SelectFilterUsuario extends StatefulWidget {
  @override
  _SelectFilterUsuarioState createState() => _SelectFilterUsuarioState();
}

class _SelectFilterUsuarioState extends State<SelectFilterUsuario> {

  List<String> _items;
  List<DropdownMenuItem> _dropItems;
  String _currrentItem;
  List<String> campos = ["Nombre", "Email", "Rol"];

  @override
  void initState() {
    _items = campos;
    _dropItems = getDropDownMenuItems();
    _currrentItem = _dropItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for(String i in _items){
      items.add(new DropdownMenuItem(
        value: i,
        child: Text(i),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Escoja un filtro"),
            Container(
              padding: new EdgeInsets.all(16.0),
            ),
            DropdownButton<String>(
              value: _currrentItem,
              items: _dropItems,
              onChanged: changeDropDownItem,
            ),
          ],
        ),
      ),
    );
  }

  void changeDropDownItem(String selectedItem){
    setState(() {
      _currrentItem = selectedItem;
    });
  }
}


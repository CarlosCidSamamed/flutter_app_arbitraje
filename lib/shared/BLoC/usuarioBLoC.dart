// El BLoC para el modelo Usuario.
// Encapsula la lógica para recuperar la información de los Usuarios de la BD (de la colección 'usuarios')
// ya sea para un usuario o para una lista de usuarios.

import 'package:flutter/widgets.dart';
import 'package:flutter_app_arbitraje/shared/shared.dart';
import 'package:flutter_app_arbitraje/services/services.dart'; // Models
import 'package:rxdart/rxdart.dart'; // Reactive behaviours

class UsuarioBloc {
  // Vamos a usar un objeto de la clase PublishSubject para el controlador del stream para asegurarnos de que siempre
  // nos devuelva un valor. En el caso de que no obtenga valor en un momento dado nos devolverá su último valor => Nunca será null.
  final _indexController = PublishSubject<String>();
  // En nuestro modelo los IDs de los Usuarios son Strings y el objeto _indexController nos devolverá
  // una "lista" de Strings, que serán los IDs de los Usuarios que se cargan desde la BD.
}

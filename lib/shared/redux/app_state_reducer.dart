// En esta clase se definirá el reducer que se encargará de especificar cómo cambia el AppState en respuesta a las Actions.
// El reducer es una función pura que recibe el estado previo y una acción y devuelve el nuevo estado.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_arbitraje/shared/redux/actions.dart';
import 'package:flutter_app_arbitraje/shared/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

AppState appStateReducer (AppState state, dynamic action) {
  return new AppState(
    crono: cronoReducer(state.crono, action),
  );
}

final cronoReducer = combineReducers<String>([
  new TypedReducer<String, ChronoOnDataEventAction>(_setChrono),
]);

String _setChrono(String oldChrono, ChronoOnDataEventAction action){
  return action.crono;
}
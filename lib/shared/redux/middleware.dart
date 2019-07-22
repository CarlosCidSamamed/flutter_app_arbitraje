// En este archivo se definirá la conexión con Firestore para actualizar el AppState
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'actions.dart';
import 'app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_arbitraje/shared/shared.dart';

final allEpics = combineEpics<AppState>([chronoEpic, updateChronoEpic]);

Stream<dynamic> updateChronoEpic(Stream<dynamic> actions, EpicStore<AppState> store){
  return new Observable(actions)
      .ofType(new TypeToken<UpdateChronoInfoAction>())
      .flatMap((_) {
        return new Observable.fromFuture(Firestore.instance.document("datos/crono") // Esta ruta del documento que almacena el valor de crono es para TESTS
            .updateData({'crono': store.state.crono})
            .then((_) => new ChronoDataPushedAction())
            .catchError((error) => new ChronoOnErrorEventAction(error)));

        // TODO: La ruta del documento deberá incluir el idCombate e idAsalto. El crono de cada asalto será único y se identificará con esos dos IDs.
    });
}

Stream<dynamic> chronoEpic(Stream<dynamic> actions, EpicStore<AppState> store){
  return new Observable(actions)
      .ofType(new TypeToken<RequestChronoDataEventsAction>())
      .flatMap((RequestChronoDataEventsAction requestAction) {
         return getChrono()
             .map((chrono) => new ChronoOnDataEventAction(chrono))
             .takeUntil(actions.where((action) => action is CancelChronoDataEventsAction));
  });
}


Observable<String> getChrono() {
  Stream<DocumentSnapshot> datos = Firestore.instance.document("datos/crono").snapshots();
  return new Observable(datos).map((DocumentSnapshot doc) => doc['chrono'] as String);
}

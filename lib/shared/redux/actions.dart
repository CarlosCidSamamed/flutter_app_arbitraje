// En este archivo se definirán las acciones que usará la app para enviar datos al store
// Dichas acciones son la única fuente de información que recibirá la store
// Se usan dichas acciones mediante store.dispatch()

// Las actions describen el hecho de que ha ocurrido algo con respecto al AppState.

class UpdateChronoInfoAction {}

class ChronoDataPushedAction {}

class RequestChronoDataEventsAction {}

class CancelChronoDataEventsAction {}

class ChronoOnDataEventAction { // Esta action se enviará cada vez que Firestore realice una modificación sobre los datos del crono.
  final String crono;

  ChronoOnDataEventAction(this.crono);
}

class ChronoOnErrorEventAction {
  final dynamic error;

  ChronoOnErrorEventAction(this.error);

  @override
  String toString() => 'ChronoOnErrorEventAction{error: $error}';

}
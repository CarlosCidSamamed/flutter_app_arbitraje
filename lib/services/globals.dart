import 'services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'models.dart';

// Static global state. Immutable services that do not care about build context.abstract
class Global {
  // App data
  static final String title = 'AppArbitraje';

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    Organizador: (data) => Organizador.fromMap(data),
    Campeonato: (data) => Campeonato.fromMap(data),
    Modalidad: (data) => Modalidad.fromMap(data),
    Categoria: (data) => Categoria.fromMap(data),
    Combate: (data) => Combate.fromMap(data),
    Asalto: (data) => Asalto.fromMap(data),
    Competidor: (data) => Competidor.fromMap(data),
    Juez: (data) => Juez.fromMap(data),
    Puntuacion: (data) => Puntuacion.fromMap(data),
    Incidencia: (data) => Incidencia.fromMap(data),
    Escuela: (data) => Escuela.fromMap(data),
    Usuario: (data) => Usuario.fromMap(data),
    MensajeFCM: (data) => MensajeFCM.fromMap(data),
  };

  // Firestore References for Writes
  //static final Collection

}
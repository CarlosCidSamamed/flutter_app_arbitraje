/// En esta clase definiremos el AppState que se almacenará en el Store. La App solo tendrá un Store que almancenará distintos valores que conforman el estado.
/// Crono
/// Puntuaciones
/// Incidencias
/// numAsalto
/// numCombate
/// Con estas dos variables se podrá identificar el asalto y el combate correctos en los que actualizar los datos (y su documento correspondiente en Firestore).
/// numJueces --> Dependiendo del número de jueces se actualizarán más o menos valores del AppState.
/// El número máximo de jueces para un combate será el siguiente: 7
///   1 Juez Principal (Mesa)
///   1 Cronometrador
///   5 Jueces de Silla
/// El número mínimo de jueces para un combate será el siguiente: 5
///   1 Juez Principal (Mesa)
///   1 Cronometrador
///   3 Jueces de Silla
///
///   Por esto se crearán 5 variables que almacenen las puntuaciones otorgadas por cada uno de los jueces de silla para cada uno de los competidores
///   Ejemplo --> PuntRojoJuez1
///
///   Si el número de jueces es el máximo se actualizarán las variables para todos los jueces de silla. En caso contrario solo se actualizarán las de los jueces 1 a 3.
///
import 'package:meta/meta.dart';

class AppState {
  final String crono; // El widget Crono nos devuelve el valor en formato String 00:00 (minutos:segundos).
  // Ese será el valor que almacenará el AppState para poder sincronizar el crono de las apps de los jueces de Silla y Mesa.

  AppState({this.crono = "00:00"});

  AppState copyWith({String newCrono}) => new AppState(crono : newCrono ?? this.crono);
  // El nuevo valor de crono será el indicado mediante el parámetro o el valor anterior si no se han producido cambios en su valor.
}

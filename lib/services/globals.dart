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
    Emparejamiento: (data) => Emparejamiento.fromMap(data),
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

  // TODO: Añadir las colecciones de datos para los distintos modelos siguiendo el ejemplo del código del curso de Fireship de Flutter.
  static final Collection<Organizador> organizadoresRef = Collection<Organizador>(path: 'organizadores');
  static final Collection<Usuario> usuariosRef = Collection<Usuario>(path: 'usuarios');
  static final UserData<Usuario> userRef = UserData<Usuario>(collection: 'usuarios');
  static final Collection<MensajeFCM> mensajesRef = Collection<MensajeFCM>(path: 'mensajes');
  // Se inicializan aquí estas referencias pero en la prácticas las referencias serán variables. Por ejemplo, la colección de los campeonatos de una organización
  // deberá incluir en su ruta el id de dicha organización.
  static final Collection<Campeonato> campeonatosRef = Collection<Campeonato>(path: 'campeonatos');
  static final Collection<Modalidad> modalidadesRef = Collection<Modalidad>(path: 'modalidades');
  static final Collection<Categoria> categoriasRef = Collection<Categoria>(path: 'categorias');
  static final Collection<Emparejamiento> emparejamientosRef = Collection<Emparejamiento>(path: 'emparejamientos');
  static final Collection<Combate> combatesRef = Collection<Combate>(path: 'combates');
  static final Collection<Asalto> asaltosRef = Collection<Asalto>(path: 'asaltos');
  static final Collection<Competidor> competidoresRef = Collection<Competidor>(path: 'competidores');
  static final Collection<Juez> juecesRef = Collection<Juez>(path: 'jueces');
  static final Collection<Puntuacion> puntuacionesRef = Collection<Puntuacion>(path: 'puntuaciones');
  static final Collection<Incidencia> incidenciasRef = Collection<Incidencia>(path: 'incidencias');
  static final Collection<Escuela> escuelasRef = Collection<Escuela>(path: 'escuelas');


}
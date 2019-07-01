// En este archivo se definirán las clases que describen los documentos que guardaremos en la BD de Firestore.
// Mensajería FCM :
//  MensajeFCM 
//
// Datos Arbitraje : (Orden descendente en la jerarquía)
//  Federacion / Asociacion --> Organizador
//  Campeonato
//  Modalidad
//  Categoría
//  Emparejamiento
//  Combate
//  Asalto
//  Puntuacion
//  Incidencia
//
//  Escuela
//  Competidor
//
//  Juez
//
// Datos Usuarios:
//  Usuario

import 'package:flutter/widgets.dart';

class MensajeFCM {
  String title;
  String body;
  String type;
  String emisor;
  String receptor;
  String fechaHora;
  bool leido;


  String idCamp;
  String idCat;
  String idZona;
  String idCombateActual;
  String idAsaltoActual;
  String idRojo;
  String idAzul;

  String tiempoAsalto; // Este campo solo tendrá valor cuando se use el mensaje para sincronizar el CRONO entre Mesa y Sillas.

  MensajeFCM({ this.title, this.body, this.type, this.emisor, this.receptor, this.fechaHora, 
               this.idCamp, this.idCat, this.idZona, this.idCombateActual, this.idAsaltoActual, 
               this.idRojo, this.idAzul, this.tiempoAsalto});

  factory MensajeFCM.fromMap(Map data) {
    return MensajeFCM(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      type: data['type'] ?? '',
      emisor: data['emisor'] ?? '',
      receptor: data['receptor'] ?? '',
      fechaHora: data['fechaHora'] ?? '',

      idCamp: data['idCamp'] ?? '',
      idCat: data['idCat'] ?? '',
      idZona: data['idZona'] ?? '',
      idCombateActual: data['idCombateActual'] ?? '',
      idAsaltoActual: data['idAsaltoActual'] ?? '',
      idRojo: data['idRojo'] ?? '',
      idAzul: data['idAzul'] ?? '',
      tiempoAsalto: data['tiempoAsalto'] ?? ''
    );
  }
}

class Organizador { // Entidad Organizadora de un Campeonato, ya sea una Federación o una Asociación
  String id;
  String nombre;
  String pais;
  String ciudad;
  String direccion;
  String tipo; // Federación, Asociación...

  String logo; // URL
  String web;
  String email;
  String telf;

  // Datos relacionados con los Campeonatos
  int numCamps; // Número de Campeonatos organizados
  List<String> listaIDsCamps; // Listado de los IDs de los Campeonatos organizados

  // Datos relacionados con los Jueces
  int numJueces;  // Número de Jueces que pertenecen a esta organización
  List<String> listaIDsJueces;

  // Datos relacionados con los Competidores
  int numCompetidores; // Número de los Competidores que pertenecen a esta organización
  List<String> listaIDsCompetidores;

  Organizador({ this.id, this.nombre, this.pais, this.ciudad, this.direccion,
                this.tipo, this.logo, this.web, this.email, this.telf, 
                this.numCamps, this.listaIDsCamps,
                this.numJueces, this.listaIDsJueces, 
                this.numCompetidores, this.listaIDsCompetidores});

  factory Organizador.fromMap(Map data) {
    return Organizador(
      id: data['id'],
      nombre: data['nombre'],
      pais: data['pais'],
      ciudad: data['ciudad'],
      direccion: data['direccion'],
      telf: data['telefono'],
      web: data['web'],
      email: data['email'],
      tipo: data['tipo'],

      numCamps: data['numCamps'],
      listaIDsCamps: (data['listaIDsCamps'] as List ?? []), 

      numJueces: data['numJueces'],
      listaIDsJueces: (data['listaIDsCamps'] as List ?? []),

      numCompetidores: data['numCompetidores'],
      listaIDsCompetidores: (data['listaIDsCompetidores'] as List ?? [])
    );
  }

}

class Campeonato {
  String idCamp;
  String nombre;
  String fecha;
  String lugar;
  String tipo;
  String urlCartel;

  String idOrg; // Id de la organización de la que depende este Campeonato

  List<String> listaIDsJueces;
  List<Modalidad> listaModalidades;

  int numZonasCombate;
  List<String> listaIDsZonasCombate;

  Campeonato({ this.idCamp, this.nombre, this.fecha, this.lugar, this.tipo, this.urlCartel, this.idOrg,
               this.listaIDsJueces, this.listaModalidades, 
               this.numZonasCombate, this.listaIDsZonasCombate});

  factory Campeonato.fromMap(Map data) {
    return Campeonato(
      idCamp: data['idCamp'],
      nombre: data['nombre'],
      fecha: data['fecha'],
      lugar: data['lugar'],
      tipo: data['tipo'],
      urlCartel: data['urlCartel'],

      idOrg: data['idOrg'],

      listaIDsJueces: (data['listaIDsJueces'] as List ?? []),
      listaModalidades: (data['listaModalidades'] as List ?? []).map((v) => Modalidad.fromMap(v)).toList(),

      numZonasCombate: data['numZonasCombate'],
      listaIDsZonasCombate: (data['listaIDsZonasCombate'] as List ?? [])
    );
  }
}

class Modalidad {
  String idMod;
  String nombre;
  String descripcion;
  List<String> listaIDsCats;

  Modalidad({ this.idMod, this.nombre, this.descripcion, this.listaIDsCats});

  factory Modalidad.fromMap(Map data) {
    return Modalidad(
      idMod: data['idMod'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      listaIDsCats: (data['listaIDsCats'] as List ?? [])
    );
  }
}

class Categoria {
  String idCat;
  String nombre;
  String edad;
  String sexo;
  String peso;
  List<String> listaIDsCombates;

  Categoria({ this.idCat, this.nombre, this.edad, this.sexo, this.peso, this.listaIDsCombates});

  factory Categoria.fromMap(Map data) {
    return Categoria(
      idCat: data['idCat'],
      nombre: data['nombre'],
      edad: data['edad'],
      sexo: data['sexo'],
      peso: data['peso'],
      listaIDsCombates: (data['listaIDsCombates'] as List ?? [])
    );
  }
}

enum EsFinal {SI, NO, TERCEROS}

class Emparejamiento {
  String id;
  String numeroCombate;
  String idRojo;
  String idAzul;
  String sigCombateGanador;
  String sigCombatePerdedor;
  EsFinal esFinal;
  String idGanador;
  String idPerdedor;

  Emparejamiento({ this.id, this.numeroCombate, this.idRojo, this.idAzul,
                   this.sigCombateGanador, this.sigCombatePerdedor,
                   this.esFinal, this.idGanador, this.idPerdedor});

  factory Emparejamiento.fromMap(Map data){
    return Emparejamiento(
      id: data['id'],
      numeroCombate: data['numeroCombate'],
      idRojo: data['idRojo'],
      idAzul: data['idAzul'],
      sigCombateGanador: data['sigCombateGanador'],
      sigCombatePerdedor: data['sigCombatePerdedor'],
      esFinal: data['esFinal'],
      idGanador: data['idGanador'],
      idPerdedor: data['idPerdedor']
    );
  }
}

enum Estado {Pendiente, Finalizado, Cancelado}

class Combate {
  String idCombate;
  String numCombate;

  String ganador; // ID del Competidor Ganador
  String perdedor;
  String motivo;

  String enlaceVideo;
  String idRojo;
  String idAzul;

  List<Asalto> listaAsaltos;

  String numAsaltosRojo;
  String numAsaltosAzul;

  String modalidad;
  String categoria;
  String campeonato;
  String idZonaCombate;

  Estado estadoCombate;

  int numJuecesConfirmados;
  List<String> listaIDsJueces;

  Combate({ this.idCombate, this.numCombate, this.ganador, this.perdedor, this.motivo,
            this.enlaceVideo, this.idRojo, this.idAzul, this.listaAsaltos,
            this.numAsaltosRojo, this.numAsaltosAzul,
            this.modalidad, this.categoria, this.campeonato, this.idZonaCombate,
            this.estadoCombate, this.numJuecesConfirmados, this.listaIDsJueces});

  factory Combate.fromMap(Map data){
    return Combate(
      idCombate: data['idCombate'],
      numCombate: data['numCombate'],
      ganador: data['ganador'],
      perdedor: data['perdedor'],
      motivo: data['motivo'],
      enlaceVideo: data['enlaceVideo'],
      idRojo: data['idRojo'],
      idAzul: data['idAzul'],
      listaAsaltos: (data['listaAsaltos'] as List ?? []).map((v) => Asalto.fromMap(v)).toList(),
      numAsaltosRojo: data['numAsaltosRojo'],
      numAsaltosAzul: data['numAsaltosAzul'],
      modalidad: data['modalidad'],
      categoria: data['categoria'],
      campeonato: data['campeonato'],
      idZonaCombate: data['idZonaCombate'],
      estadoCombate: data['estadoCombate'],
      numJuecesConfirmados: data['numJuecesConfirmados'],
      listaIDsJueces: (data['listaIDsJueces'] as List ?? [])
    );
  }
}

class Asalto {
  String idAsalto;
  String numAsalto;
  String fotoRojo;
  String fotoAzul;
  String ganador;
  String perdedor;
  String motivo;
  String descripcion;
  int puntuacionRojo;
  int puntuacionAzul;
  int duracion; // Duración en milisegundos
  List<Puntuacion> listaPuntuaciones;
  List<Incidencia> listaIncidencias;
  Estado estado;

  Asalto({ this.idAsalto, this.numAsalto,
           this.fotoRojo, this.fotoAzul,
           this.ganador, this.perdedor, this.motivo, this.descripcion,
           this.puntuacionRojo, this.puntuacionAzul, this.duracion, 
           this.listaPuntuaciones, this.listaIncidencias, this.estado});

  factory Asalto.fromMap(Map data) {
    return Asalto(
      idAsalto: data['idAsalto'],
      numAsalto: data['numAsalto'],
      fotoRojo: data['fotoRojo'],
      fotoAzul: data['fotoAzul'],
      ganador: data['ganador'],
      perdedor: data['perdedor'],
      motivo: data['motivo'],
      descripcion: data['descripcion'],
      puntuacionRojo: data['puntuacionRojo'],
      puntuacionAzul: data['puntuacionAzul'],
      duracion: data['duracion'],
      listaPuntuaciones: (data['listaPuntuaciones'] as List ?? []).map((v) => Puntuacion.fromMap(v)).toList(),
      listaIncidencias: (data['listaIncidencias'] as List ?? []).map((v) => Incidencia.fromMap(v)).toList(),
      estado: data['estado']
    );
  }
}

class Puntuacion {
  String idPunt;
  String idJuez;
  String idAsalto;
  String idCompetidor;
  int valor;
  String concepto;
  String zonaContacto;
  String tipoAtaque;
  String marcaTiempo;

  Puntuacion({ this.idPunt, this.idJuez, this.idAsalto, this.idCompetidor, this.valor, 
               this.concepto, this.zonaContacto, this.tipoAtaque, this.marcaTiempo});

  factory Puntuacion.fromMap(Map data) {
    return Puntuacion(
      idPunt: data['idPunt'],
      idJuez: data['idJuez'],
      idAsalto: data['idAsalto'],
      idCompetidor: data['idCompetidor'],
      valor: data['valor'],
      concepto: data['concepto'],
      zonaContacto: data['zonaContacto'],
      tipoAtaque: data['tipoAtaque'],
      marcaTiempo: data['marcaTiempo']
    );
  }
}

class Incidencia {
  String idInc;
  String idJuez;
  String idAsalto;
  String idCompetidor;
  int valor;
  String tipo;
  String descripcion;
  String marcaTiempo;

  Incidencia({ this.idInc, this.idJuez, this.idAsalto, this.idCompetidor, this.valor, this.tipo, this.descripcion, this.marcaTiempo});

  factory Incidencia.fromMap(Map data){
    return Incidencia(
      idInc: data['idInc'],
      idJuez: data['idJuez'],
      idAsalto: data['idAsalto'],
      idCompetidor: data['idCompetidor'],
      valor: data['valor'],
      tipo: data['tipo'],
      descripcion: data['descripcion'],
      marcaTiempo: data['marcaTiempo']
    );
  }
}

class Escuela {
  String idEsc;
  String nombre;
  String pais;
  String ciudad;
  String direccion;
  String logo;
  String web;
  String email;
  String telf;

  int numCompetidores;
  List<String> listaIDsCompetidores;

  Escuela({ this.idEsc, this.nombre, this.pais, this.ciudad, this.direccion, this.logo, this.web, this.email, this.telf,
            this.numCompetidores, this.listaIDsCompetidores});

  factory Escuela.fromMap(Map data){
    return Escuela(
      idEsc: data['id'],
      nombre: data['nombre'],
      pais: data['pais'],
      ciudad: data['ciudad'],
      direccion: data['direccion'],

      logo: data['logo'],
      web: data['web'],
      email: data['email'],
      telf: data['telf'],

      numCompetidores: data['numCompetidores'],
      listaIDsCompetidores: (data['listaIDsCompetidores'] as List ?? [])
    );
  }
}

class Competidor {
  String id;
  String dni;
  String nombre;
  String apellido1;
  String apellido2;
  String fechaNac;

  String sexo;
  int edad;
  double peso;
  List<double> historicoPesos;
  String catEdad;
  String catPeso;
  double altura;
  double envergadura;
  String guardia;

  int combatesGanados;
  int combatesPerdidos;

  String federacionAsoc;
  String escuelaClub;
  String pais;

  String foto;

  Competidor({ this.id, this.dni, this.nombre, this.apellido1, this.apellido2, this.fechaNac,
               this.sexo, this.edad, this.peso, this.historicoPesos, this.catEdad, this.catPeso,
               this.altura, this.envergadura, this.guardia,
               this.combatesGanados, this.combatesPerdidos,
               this.federacionAsoc, this.escuelaClub, this.pais, this.foto});

  factory Competidor.fromMap(Map data){
    return Competidor(
      id: data['id'],
      dni: data['dni'],
      nombre: data['nombre'],
      apellido1: data['apellido1'],
      apellido2: data['apellido2'],
      fechaNac: data['fechaNac'],
      sexo: data['sexo'],
      edad: data['edad'],
      peso: data['peso'],
      historicoPesos: (data['historicoPesos'] as List ?? []),
      catEdad: data['catEdad'],
      catPeso: data['catPeso'],
      altura: data['altura'],
      envergadura: data['envergadura'],
      guardia: data['guardia'],
      combatesGanados: data['combatesGanados'],
      combatesPerdidos: data['combatesPerdidos'],
      federacionAsoc: data['federacionAsoc'],
      escuelaClub: data['escuelaClub'],
      pais: data['pais'],
      foto: data['foto']
    );
  }

}

class Juez {
  String id;
  String dni;
  String email;
  String password;

  String tokenIDFCM;
  bool conectado;
  bool listo;

  String foto;
  String pais;
  String federacionAsoc;

  String nivel;
  String cargo;

  String idCamp;
  String idCat;
  String idZona;
  String idCombate;
  String zonaCombate; // Número

  List<String> listaCamps;
  List<String> listaCombates;

  List<String> listaPuntuaciones;
  List<String> listaIncidencias;

  Juez({ this.id, this.dni, this.email, this.password,
         this.tokenIDFCM, this.conectado, this.listo,
         this.foto, this.pais, this.federacionAsoc,
         this.nivel, this.cargo,
         this.idCamp, this.idCat, this.idZona, this.idCombate, this.zonaCombate,
         this.listaCamps, this.listaCombates,
         this.listaPuntuaciones, this.listaIncidencias});

  factory Juez.fromMap(Map data){
    return Juez(
      id: data['id'],
      dni: data['dni'],
      email: data['email'],
      password: data['password'],
      tokenIDFCM: data['tokenIDFCM'],
      conectado: data['conectado'],
      listo: data['listo'],
      nivel: data['nivel'],
      cargo: data['cargo'],
      idCamp: data['idCamp'],
      idCat: data['idCat'],
      idZona: data['idZona'],
      idCombate: data['idCombate'],
      zonaCombate: data['zonaCombate'],
      listaCamps: (data['listaCamps'] as List ?? []),
      listaCombates: (data['listaCombates'] as List ?? []),
      listaPuntuaciones: (data['listaPuntuaciones'] as List ?? []),
      listaIncidencias: (data['listaIncidencias'] as List ?? [])
    );
  }


}

enum Rol {Admin, Editor, JuezMesa, JuezSilla, Visitante}

class Usuario {
  String id;
  String email;
  String password;
  String nombreUsuario;
  //Rol rol;
  String rol;
  String foto;

  Usuario({ this.id, this.email, this.password, this.nombreUsuario, this.rol, this.foto });

  factory Usuario.fromMap(Map data){
    return Usuario(
      id: data['id'],
      email: data['email'],
      password: data['password'],
      nombreUsuario: data['nombreUsuario'],
      rol: data['Rol'] ?? '',
      foto: data['foto']
    );
  }

  String mostrarRol(String rol){
    switch(rol){
      case "admin":{
        return "Admin";
      }
      case "editor":{
        return "Editor";
      }
      case "juezMesa":{
        return "Juez de Mesa";
      }
      case "juezSilla":{
        return "Juez de Silla";
      }
      case "visitante":{
        return "Visitante";
      }
      default: {
        return "Rol no Especificado";
      }
    }
  }

}
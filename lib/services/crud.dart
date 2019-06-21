// En esta clase definiremos los métodos para Crear, Leer, Borrar y Actuaclizar. (Create Read Update Delete) --> CRUD
// Los métodos aceptarán un tipo generíco T pero actuarán de manera distinta según el modelo que se trate en cada caso.
// El proceso de almacenar datos es igual en todos los casos (datos->documentos->colecciones) pero la ruta de la colección será distinta según el modelo.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import './db.dart';

class CrudDocs<T> {

  final Firestore _db = Firestore.instance;
  final String path;
  DocumentReference docRef;

  CrudDocs ({ this.path }) {
    docRef = _db.document(path);
  }

  // Documentos

  // Las operaciones de Lectura están implementadas en el archivo db.dart
  // Lectura de un documento  --> Document.getData
  // Lectura de una colección --> Collection.getData

  Future<T> readDocument (String path){
    return new Document(path: path).getData();
  }

  // Crea un documento de tipo T en la ruta especificada mediante una transacción de Firestore.
  // Los datos del documento se especificarán en un Map.
  void createDocument (String path, Map data) {
    _db.runTransaction((Transaction transaction) async {
      CollectionReference colRef = _db.collection(path);
      await colRef.add(data);
    });
  }

  void updateDocument (String path, Map data){
    DocumentReference docRef = _db.document(path);
    _db.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      transaction.update(snapshot.reference, data);
    });
  }

  void deleteDocument (String path) {
    DocumentReference docRef = _db.document(path);
    _db.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      await transaction.delete(snapshot.reference);
    });
  }

}

class CrudCols<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference colRef;

  CrudCols ({ this.path }){
    colRef = _db.collection(path);
  }

  Stream<List<T>> readCollection (String path) {
    return new Collection(path: path).streamData();
  }
}


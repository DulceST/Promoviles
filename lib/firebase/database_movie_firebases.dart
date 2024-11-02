import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseMovieFirebases {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  DatabaseMovieFirebases() {
    collectionReference = firebaseFirestore.collection('movies');
  }

  Future<bool> INSERT(Map<String, dynamic> movies) async {
   try {
      await collectionReference!.doc().set(movies);
      return true;
   } catch (e) {
      kDebugMode ? print('Error al insertar: ${e.toString()}') : '';
      return false;
   }
}


  Future<void> UPDATE(Map<String, dynamic> movies, String id) async {
    return collectionReference!.doc(id).update(movies);
  }

  Future<void> DELETE(String UId) async {
    return collectionReference!.doc(UId).delete();
  }

  Stream<QuerySnapshot> SELECT() {
    return collectionReference!
        .snapshots(); //manda todos los documentos de la colección
  }
}

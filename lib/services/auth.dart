import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'db.dart';
import 'models.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> googleSignIn() async {
    try{
      
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = await _auth.signInWithCredential(credential);
      // Antes de modificar los datos del Usuario en Firestore deberemos ver si ya tenía un Rol
      // asignado para no modificarlo cada vez que se inicie sesión seleccionando la cuenta de
      // gmail.
      UserData<Usuario> userData = UserData(collection: 'usuarios');
      userData.getDocument().then((value) {
        if(value.rol != ""){ // Si ya tenía un Rol asignado no se modifica dicho Rol.
          updateUserData(user, null);
        } else {             // En caso contrario se le asigna el Rol de juezSilla. (El juez de menor nivel)
          updateUserData(user, "juezSilla");
        }
      }).catchError((e) {
        print("auth.dart --> googleSignIn --> Error al obtener los datos del Usuario desde Firestore");
      });


      return user;

    } catch(error) {
      print(error);
      return null;
    }
  }

  Future<FirebaseUser> anonLogin() async {
    FirebaseUser user = await _auth.signInAnonymously();
    updateUserData(user, "visitante");
    return user;
  }

  Future<void> updateUserData(FirebaseUser user, String rol) {
    DocumentReference userRef = _db.collection('usuarios').document(user.uid);
    if(rol != null) {
      return userRef.setData({
        'uid': user.uid,
        'lastActivity': DateTime.now(),
        'nombreUsuario': user.displayName,
        'email': user.email,
        'foto': user.photoUrl,
        'password': "",
        // Al hacer Login con Google no será necesario usar una contraseña en nuestro documento.
        'Rol': rol,
      }, merge: true);
    } else{
      return userRef.setData({
        'uid': user.uid,
        'lastActivity': DateTime.now(),
        'nombreUsuario': user.displayName,
        'email': user.email,
        'foto': user.photoUrl,
        'password': "",
        // Al hacer Login con Google no será necesario usar una contraseña en nuestro documento.
      }, merge: true);
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
import 'package:firebase_auth/firebase_auth.dart';

class IngresoUsuarioEmail {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> loginConEmail({String emailValor, String passwordValor}) async {
    FirebaseUser firebaseUser =
        (await _auth.signInWithEmailAndPassword(email: emailValor, password: passwordValor)).user;
    return firebaseUser;
  }

  Future<void> logoutEmail() {
    return _auth.signOut();
  }

  Future<void> sendPasswordResetEmail({String emailValor}) async {
    return _auth.sendPasswordResetEmail(email: emailValor);
  }
}

class CrearUsuario {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> crearUsuario({String emailValor, String passwordValor}) async {
    FirebaseUser firebaseUser =
        (await _auth.createUserWithEmailAndPassword(email: emailValor, password: passwordValor))
            .user;
    firebaseUser.sendEmailVerification();
    return firebaseUser;
  }

  Future<String> uidUsuarioCreado({String emailValor, String passwordValor}) async {
    FirebaseUser firebaseUser =
        (await _auth.createUserWithEmailAndPassword(email: emailValor, password: passwordValor))
            .user;
    return firebaseUser.uid;
  }
}

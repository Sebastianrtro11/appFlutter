import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Email y contraseña
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential resultado = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return resultado.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Cerrar sesión
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //Crear usuario Email y contraseña
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential resultado = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return resultado.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/verify_email_screen.dart';


//Verifica auth y redirecciona a la pantalla de inicio
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          User user = snapshot.data!;
          print("Usuario: ${user}");
          if (user.emailVerified) {
            return HomeScreen();
          } else {
            return VerifyEmailScreen(user: user);
          }
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

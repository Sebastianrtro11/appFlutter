// lib/utils/auth_wrapper.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/verify_email_screen.dart';
import '../utils/app_routes.dart';

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
          if (user.emailVerified) {
            Future.microtask(() => Navigator.pushReplacementNamed(context, AppRoutes.home));
          } else {
            return VerifyEmailScreen(user: user);
          }
        } else {
          return const LoginScreen();
        }

        // Devuelve un widget vacío en caso de que no se cumpla ninguna condición
        return const SizedBox.shrink();
      },
    );
  }
}

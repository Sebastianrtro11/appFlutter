import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../screens/verify_email_screen.dart';
import 'create_acount.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      User? user = await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        if (user.emailVerified) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _showErrorDialog(
              "Debes verificar tu correo antes de iniciar sesión.");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyEmailScreen(user: user)),
          );
        }
      } else {
        _showErrorDialog("Error al iniciar sesión. Verifica tus credenciales.");
      }
    } catch (e) {
      _showErrorDialog("Error al iniciar sesión: ${e.toString()}");
    }
  }
  

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signUp() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: Image.asset("assets/logo.jpg"),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: _signUp,
              child: const Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

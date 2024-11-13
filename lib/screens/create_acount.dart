import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'verify_email_screen.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _createAccount() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        User? user = await _authService.createUserWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VerifyEmailScreen(user: user)),
          );
        } else {
          _showErrorDialog("Error al crear la cuenta. Inténtalo de nuevo.");
        }
      } catch (e) {
        _showErrorDialog("Error al crear la cuenta: ${e.toString()}");
      }
    } else {
      _showErrorDialog("Las contraseñas no coinciden. Inténtalo de nuevo.");
    }
  }

  Future<void> _goBack(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta'), actions: [
        IconButton(
            onPressed: () => _goBack(context),
            icon: const Icon(Icons.arrow_back_ios))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico', filled: true, fillColor: Colors.black12),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña', filled: true, fillColor: Colors.black12),
              obscureText: true,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirmar contraseña', filled: true, fillColor: Colors.black12),
              obscureText: true,
            ),
            const SizedBox(height: 5  ),
            ElevatedButton(
              onPressed: _createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  final User user;
  const VerifyEmailScreen({super.key, required this.user});

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    widget.user.sendEmailVerification(); // Enviar email de verificación
    checkEmailVerified();
  }

  Future<void> checkEmailVerified() async {
    await widget.user.reload(); // Recargar el estado del usuario
    setState(() {
      isEmailVerified = widget.user.emailVerified;
    });

    print("Email verificado: ${widget.user}");

    if (isEmailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verificar Email")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Un correo de verificación ha sido enviado a tu email. Por favor, verifica tu correo para completar el registro.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await checkEmailVerified();
              },
              child: const Text("He verificado mi correo"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await widget.user.sendEmailVerification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Correo de verificación reenviado")),
                );
              },
              child: const Text("Reenviar correo de verificación"),
            ),
          ],
        ),
      ),
    );
  }
}

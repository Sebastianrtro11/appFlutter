import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailScreen extends StatefulWidget {
  final User user;
  const VerifyEmailScreen({super.key, required this.user});

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  @override
  void initState() {
    super.initState();
    widget.user.sendEmailVerification();
  }

  Future<void> checkEmailVerified() async {
    if (widget.user.emailVerified) {
      Navigator.pushReplacementNamed(context, '/home');
    }
    else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _goBack(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verificar Email"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () => _goBack(context),
              icon: const Icon(Icons.arrow_back_ios))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Un correo de verificación ha sido enviado a tu email. Por favor, verifica tu correo para completar el registro.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await checkEmailVerified();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("He verificado mi correo", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await widget.user.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Correo de verificación reenviado")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al enviar el correo")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Reenviar correo de verificación", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

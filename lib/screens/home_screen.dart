import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/clickService.dart';
import '../widgets/drawer.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthService _authService = AuthService();
  final ClickService _clickService = ClickService();

  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _clickCount = 0;

  @override
  void initState() {
    super.initState();
    _loadClickCount();
  }

  Future<void> _loadClickCount() async {
    int count = await widget._clickService.getClickCount();
    setState(() {
      _clickCount = count;
    });
  }

  Future<void> _incrementClick() async {
    setState(() {
      _clickCount += 1;
    });

    try {
      await widget._clickService.incrementClickCount();
    } catch (e) {
      setState(() {
        _clickCount -= 1;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Ocurrió un problema al actualizar el contador de clics. Por favor, intenta de nuevo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await widget._authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Investigación CIDTCA'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'El Centro de Investigación y Desarrollo Tecnológico en Ciencias Aplicadas (CIDTCA) está desarrollando una profunda investigación sobre los últimos avances del proceso de paz en Colombia, enfocándose en los efectos directos e indirectos sobre el desplazamiento forzoso.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  Text(
                    'Has visitado esta página $_clickCount veces.',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: _incrementClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 30.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Incrementar Conteo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Información clave:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10.0),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• El proceso de paz ha permitido la reconstrucción social en áreas afectadas.',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                SizedBox(height: 5.0),
                Text(
                  '• Persisten retos como la falta de infraestructura en ciertas regiones.',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                SizedBox(height: 5.0),
                Text(
                  '• La plataforma Samay busca educar a los jóvenes en zonas de baja conectividad.',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

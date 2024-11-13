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
        title: const Text(
            'Centro de Investigacion y Desarrollo Tecnologico (CIDTCA)'),
      ),
      drawer: const AppDrawer(),
      body: SizedBox(
        width: 500.0,
        child: Column(
          children: [
            const Text(
                'El Centro de Investigacion y Desarrollo Tecnológico en Ciencias Aplicadas (CIDTCA) está desarrollando una profunda investigacion sobre los últimos avances del proceso de paz en Colombia, enfocándose en los efectos directos e indirectos que este ha tenido sobre el fenómeno del desplazamiento forzoso.'),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  Text('Has visitado esta pagina $_clickCount veces.'),
                  const SizedBox(height: 5.0),
                  ElevatedButton(
                    onPressed: _incrementClick,
                    child: const Text('Click!'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Informacion clave:'),
            const SizedBox(height: 20.0),
            const Text('1. El proceso de paz ha permitido la recontruccion social en áreas afectadas.'),
            const Text('2. Retos persistentes como la falta de infraestructura en ciertas regiones.'),
            const Text('3. La plataforma Samay busca educar a los jovenes en zonas de baja conectividad.'),
          ],
        ),
      ),
    );
  }
}

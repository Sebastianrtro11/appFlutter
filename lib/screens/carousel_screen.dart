import 'package:flutter/material.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Carrusel')),
      body: const Center(
        child: Text('Aquí se mostrarán las imágenes del carrusel'),
      ),
    );
  }
}

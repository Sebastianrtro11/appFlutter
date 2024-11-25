import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/drawer.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://picsum.photos/400/600?random=1',
      'https://picsum.photos/400/600?random=2',
      'https://picsum.photos/400/600?random=3',
      'https://picsum.photos/400/600?random=4',
      'https://picsum.photos/400/600?random=5',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Carrusel'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a la App de CIDTCA',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: imageUrls.map((String url) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Ir a la página de inicio',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

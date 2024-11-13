import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/carousel_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String carousel = '/carousel';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    carousel: (context) => CarouselScreen(),
    login: (context) => LoginScreen(),
  };
}
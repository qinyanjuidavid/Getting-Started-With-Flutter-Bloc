import 'package:bloc_intro/views/home.dart';
import 'package:bloc_intro/views/second_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  
  static const homeScreen = "/";
  static const secondScreen = "/second_screen";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );

      case secondScreen:
        return MaterialPageRoute(
          builder: (context) => Secondscreen(
            title: args?['title'] ?? '',
            color: args?['color'] ?? Colors.black,
          ),
        );

      default:
        // Handle unknown routes
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}

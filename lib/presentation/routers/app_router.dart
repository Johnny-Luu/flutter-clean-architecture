import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/domain/exceptions/exception.dart';
import 'package:flutter_clean_architecture/presentation/features/home/home_screen.dart';

class RouteNames {
  static const String home = 'home';
}

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}

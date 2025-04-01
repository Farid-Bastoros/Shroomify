import 'package:flutter/material.dart';
import 'package:shroomify/screens/home_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
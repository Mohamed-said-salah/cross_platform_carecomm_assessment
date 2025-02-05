import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../components/buttons/animated_theme_switcher.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CareComm Task"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AnimatedThemeSwitcher(),
          ),
        ],
      ),
    );
  }
}

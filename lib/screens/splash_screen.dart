import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_screen.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _navigate);
  }

  Future<void> _navigate() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? langSelected = prefs.getBool('isLanguageSelected');
    if (langSelected == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/AshiLara2007/ZOD-Photos/main/ZOD%20LOGO%20(1).png',
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text('ZOD MANPOWER', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../services/localization_service.dart';
import 'main_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LocalizationService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/AshiLara2007/ZOD-Photos/main/ZOD%20LOGO%20(1).png',
              height: 120,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await langService.setLanguage('en');
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLanguageSelected', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
              },
              child: const Text('English'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await langService.setLanguage('ar');
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLanguageSelected', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
              },
              child: const Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
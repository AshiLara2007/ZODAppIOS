import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/localization_service.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => LocalizationService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationService>(
      builder: (context, langService, _) {
        return MaterialApp(
          title: 'ZOD MANPOWER',
          locale: langService.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            // අවශ්‍ය නම් easy_localization දාන්න; දැනට අපේම localization service එක ප්‍රමාණවත්
          ],
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
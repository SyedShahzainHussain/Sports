import 'package:flutter/material.dart';
import 'package:sports/features/authentication/view/splash_screen/splash_screen.dart';
import 'package:sports/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports',
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}

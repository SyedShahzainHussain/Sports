import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sports/features/authentication/view/splash_screen/splash_screen.dart';
import 'package:sports/firebase_options.dart';
import 'package:sports/provider/app_provider.dart';
import 'package:sports/utils/theme/theme.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform, 
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sports',
        theme: SAppTheme.lightTheme,
        darkTheme: SAppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

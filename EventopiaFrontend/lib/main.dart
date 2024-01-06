import 'package:awp/core/theme/colors.dart';
import 'package:awp/features/home/home_page.dart';
import 'package:awp/features/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColorScheme.blue,
            primary: AppColorScheme.blue,
            secondary: AppColorScheme.blue,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 24,
              color: AppColorScheme.secondaryGreen3,
              fontWeight: FontWeight.w300,
            ),
            displayMedium: TextStyle(
              fontSize: 20,
              color: AppColorScheme.secondaryGreen3,
              fontWeight: FontWeight.w300,
            ),
            displaySmall: TextStyle(
              fontSize: 14,
              color: AppColorScheme.secondaryGreen3,
              fontWeight: FontWeight.w300,
            ),
          )),
      home: RegisterPage(),
    );
  }
}

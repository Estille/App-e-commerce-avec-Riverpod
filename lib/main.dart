import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_shell.dart';
import 'theme/app_theme.dart';

void main() {
  // ProviderScope est OBLIGATOIRE : il doit englober toute l'application
  // pour que les providers Riverpod fonctionnent.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomeShell(),
    );
  }
}

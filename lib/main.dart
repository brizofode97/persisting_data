import 'package:flutter/material.dart';
import 'package:persisting_data/screen/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlobApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingScreen(),
    );
  }
}



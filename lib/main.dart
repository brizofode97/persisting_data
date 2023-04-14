import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:persisting_data/data/moor_db.dart';
import 'package:persisting_data/screens/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => /*BlogDb(NativeDatabase.memory())*/ BlogDb(),
      child: MaterialApp(
        title: 'GlobeApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite_new/controller/homescreen-controller.dart';
import 'package:sqflite_new/view/screenone/screenone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomescreenController.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Screenone(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tictac_game/screens/main_home.dart';
import 'package:flutter_launcher_icons/android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff00061a),
        shadowColor: const Color(0xff001456),
        splashColor: const Color(0xff4169e8),
      ),
      home: MainHome(),
    );
  }
}

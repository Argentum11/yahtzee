import  'package:flutter/material.dart';
import 'package:yahtzee/yahtzee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  root of this application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: YahtzeeGamePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

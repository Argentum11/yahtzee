import 'package:flutter/material.dart';
import 'package:yahtzee/yahtzee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  root of this application.
  @override
  Widget build(BuildContext context) {
    const Color gameBackgroundColor = Color.fromARGB(255, 15, 117, 178);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: gameBackgroundColor,
        ),
        body: const YahtzeeGamePage(),
        backgroundColor: gameBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

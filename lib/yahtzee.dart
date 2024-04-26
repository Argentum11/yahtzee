import 'package:flutter/material.dart';
import 'package:yahtzee/roll.dart';
import 'package:yahtzee/score.dart';
import 'dart:math';

class YahtzeeGamePage extends StatefulWidget {
  const YahtzeeGamePage({super.key});

  @override
  State<YahtzeeGamePage> createState() => _YahtzeeGamePageState();
}

class _YahtzeeGamePageState extends State<YahtzeeGamePage> {
  int _diceRolledTimes = 0;
  List<int> _dicePoints = List.filled(5, 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_diceRolledTimes.toString()),
        ScoreBlock(dicePoints: _dicePoints,),
        DiceRow(
          dicePoints: _dicePoints,
        ),
        RollButton(
          onPressed: rollDice,
          rolledTimes: _diceRolledTimes,
        ),
      ],
    );
  }

  void rollDice() {
    setState(() {
      if (_diceRolledTimes <= 2) {
        _diceRolledTimes++;
        Random random = Random();
        for (int i = 0; i <= 4; i++) {
          int randomNumber = random.nextInt(6) + 1;
          _dicePoints[i] = randomNumber;
        }
      }
    });
  }
}

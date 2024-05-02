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
  final List<int> _dicePoints = List.filled(5, 0);
  final List<bool> _lock = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_diceRolledTimes.toString()),
        ScoreSection(
          dicePoints: _dicePoints,
        ),
        DiceRow(
          dicePoints: _dicePoints,
          lockDice: lockDice,
          lock: _lock,
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
          if (!_lock[i]) {
            int randomNumber = random.nextInt(6) + 1;
            _dicePoints[i] = randomNumber;
          }
        }
      }
    });
  }

  void lockDice(int diceIndex) {
    setState(() {
      _lock[diceIndex] = !_lock[diceIndex];
    });
  }
}

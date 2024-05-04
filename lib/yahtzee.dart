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
  final List<bool> _diceLock = List.filled(5, false);
  List<bool> _scoreLock = List.filled(13, false);
  int _newScore = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_newScore.toString()),
        ScoreSection(
          dicePoints: _dicePoints,
          lockScore: lockScore,
          scoreLock: _scoreLock,
        ),
        DiceRow(
          dicePoints: _dicePoints,
          lockDice: lockDice,
          lock: _diceLock,
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
      unlockScore();
      _newScore = 0;
      if (_diceRolledTimes <= 2) {
        _diceRolledTimes++;
        Random random = Random();
        for (int i = 0; i <= 4; i++) {
          if (!_diceLock[i]) {
            int randomNumber = random.nextInt(6) + 1;
            _dicePoints[i] = randomNumber;
          }
        }
      }
    });
  }

  void lockDice(int diceIndex) {
    setState(() {
      _diceLock[diceIndex] = !_diceLock[diceIndex];
    });
  }

  void unlockScore() {
    _scoreLock = List.filled(13, false);
  }

  void lockScore(int scoreIndex, int score) {
    setState(() {
      if (!_scoreLock[scoreIndex]) {
        unlockScore();
        _scoreLock[scoreIndex] = true;
      } else {
        unlockScore();
      }

      _newScore = score;
    });
  }
}

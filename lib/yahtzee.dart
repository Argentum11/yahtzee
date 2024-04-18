import 'package:flutter/material.dart';
import 'package:yahtzee/roll.dart';

class YahtzeeGamePage extends StatefulWidget {
  const YahtzeeGamePage({super.key});

  @override
  State<YahtzeeGamePage> createState() => _YahtzeeGamePageState();
}

class _YahtzeeGamePageState extends State<YahtzeeGamePage> {
  int _diceRolledTimes = 0;
  bool _roll = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_diceRolledTimes.toString()),
        DiceRow(roll:_roll),
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
        _roll = true;
      }
    });
  }
}

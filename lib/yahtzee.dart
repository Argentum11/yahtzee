import 'package:flutter/material.dart';
import 'package:yahtzee/roll.dart';
import 'package:yahtzee/score.dart';
import 'package:yahtzee/player.dart';
import 'dart:math';

class YahtzeeGamePage extends StatefulWidget {
  const YahtzeeGamePage({super.key});

  @override
  State<YahtzeeGamePage> createState() => _YahtzeeGamePageState();
}

class _YahtzeeGamePageState extends State<YahtzeeGamePage> {
  // constants
  final int diceAmount = 5;
  final int scoreBlockAmount = 13;
  // state variables
  int _diceRolledTimes = 0;
  late List<int> _dicePoints;
  late List<bool> _diceLock;
  late List<bool> _scoreLock;
  late List<bool> _isScorePlayed;
  late List<int> _playScore;
  int _newScoreIndex = -1;
  int _newScore = 0;
  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _dicePoints = List.filled(diceAmount, 0);
    _diceLock = List.filled(diceAmount, false);
    _scoreLock = List.filled(scoreBlockAmount, false);
    _isScorePlayed = List.filled(scoreBlockAmount, false);
    _playScore = List.filled(scoreBlockAmount, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayerBlock(
          player1Score: _totalScore,
          player2Score: 0,
        ),
        ScoreSection(
          dicePoints: _dicePoints,
          lockScore: lockScore,
          scoreLock: _scoreLock,
          isScorePlayed: _isScorePlayed,
          playScore: _playScore,
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
        if (_diceRolledTimes >= 1)
          ScorePlayButton(
            playScore: playScore,
            scoreSelected: scoreSelected(),
          )
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
        for (int i = 0; i < diceAmount; i++) {
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
    _scoreLock = List.filled(scoreBlockAmount, false);
    _newScore = 0;
  }

  void lockScore(int scoreIndex, int score) {
    setState(() {
      if (_isScorePlayed[scoreIndex] == false) {
        if (!_scoreLock[scoreIndex]) {
          unlockScore();
          _scoreLock[scoreIndex] = true;
          _newScoreIndex = scoreIndex;
        } else {
          unlockScore();
          _newScoreIndex = -1;
        }
        _newScore = score;
      }
    });
  }

  bool scoreSelected() {
    return _newScoreIndex >= 0;
  }

  void resetDice() {
    _diceRolledTimes = 0;
    _dicePoints = List.filled(diceAmount, 0);
    _diceLock = List.filled(diceAmount, false);
  }

  void playScore() {
    setState(() {
      if (_isScorePlayed[_newScoreIndex] == false) {
        _totalScore += _newScore;
        _isScorePlayed[_newScoreIndex] = true;
        _playScore[_newScoreIndex] = _newScore;
        _newScoreIndex = -1;
        unlockScore();
        resetDice();
      }
    });
  }
}

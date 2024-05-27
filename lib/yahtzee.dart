import 'package:flutter/material.dart';
import 'package:yahtzee/roll.dart';
import 'package:yahtzee/score.dart';
import 'package:yahtzee/player.dart';
import 'dart:math';

const int scoreBlockAmount = 13;

class Player {
  late int totalScore;
  late List<bool> _isScorePlayed;

  Player() {
    totalScore = 0;
    _isScorePlayed = List.filled(scoreBlockAmount, false);
  }

  void addScore(int newTotalScore) {
    if (newTotalScore >= 0) {
      totalScore += newTotalScore;
    }
  }

  void saveScoreBlockState(List<bool> currentIsScorePlayed) {
    for (int i = 0; i < currentIsScorePlayed.length; i++) {
      _isScorePlayed[i] = currentIsScorePlayed[i];
    }
  }
}

class YahtzeeGamePage extends StatefulWidget {
  const YahtzeeGamePage({super.key});

  @override
  State<YahtzeeGamePage> createState() => _YahtzeeGamePageState();
}

class _YahtzeeGamePageState extends State<YahtzeeGamePage> {
  // constants
  final int diceAmount = 5;

  // state variables
  int _diceRolledTimes = 0;
  late List<int> _dicePoints;
  late List<bool> _diceLock;
  late List<bool> _scoreLock;
  late List<bool> _isScorePlayed;
  late List<int> _playScore;
  int _newScoreIndex = -1;
  int _newScore = 0;
  late List<Player> _players;
  late int _turn;

  @override
  void initState() {
    super.initState();
    _dicePoints = List.filled(diceAmount, 0);
    _diceLock = List.filled(diceAmount, false);
    _scoreLock = List.filled(scoreBlockAmount, false);
    _isScorePlayed = List.filled(scoreBlockAmount, false);
    _playScore = List.filled(scoreBlockAmount, -1);
    _players = [
      Player(),
      Player(),
    ];
    _turn = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayerBlock(
          player1Score: _players[0].totalScore,
          player2Score: _players[1].totalScore,
          turn: _turn,
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
        _players[_turn].addScore(_newScore);
        // score block disabled until next game
        _isScorePlayed[_newScoreIndex] = true;
        _playScore[_newScoreIndex] = _newScore;
        _newScoreIndex = -1;
        unlockScore();
        resetDice();
        switchPlayer();
      }
    });
  }

  void loadScoreBlockState(Player currentPlayer) {
    for (int i = 0; i < currentPlayer._isScorePlayed.length; i++) {
      _isScorePlayed[i] = currentPlayer._isScorePlayed[i];
    }
  }

  void switchPlayer() {
    _turn = 1 - _turn;
  }
}

import 'package:flutter/material.dart';

class ScoreBlock extends StatefulWidget {
  const ScoreBlock({super.key, required this.dicePoints});
  final List<int> dicePoints;

  @override
  State<ScoreBlock> createState() => _ScoreBlockState();
}

class _ScoreBlockState extends State<ScoreBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LeftScoreColumn(dicePoints: widget.dicePoints),
        RightScoreColumn(dicePoints: widget.dicePoints)
      ],
    );
  }
}

class Score {}

class LeftScoreColumn extends StatefulWidget {
  const LeftScoreColumn({super.key, required this.dicePoints});
  final List<int> dicePoints;

  @override
  State<LeftScoreColumn> createState() => _LeftScoreColumnState();
}

class _LeftScoreColumnState extends State<LeftScoreColumn> {
  int faceCount(List<int> dicePoints, int face) {
    int faceAmount = 0;
    for (int i = 0; i <= 4; i++) {
      if (dicePoints[i] == face) {
        faceAmount++;
      }
    }
    return faceAmount;
  }

  int threeOfAKind(List<int> dicePoints) {
    int diceSum = 0;
    bool isThreeOfAKind = false;
    List<int> faceAmount = List.filled(7, 0);
    for (int i = 0; i <= 4; i++) {
      int currentPoint = dicePoints[i];
      diceSum += currentPoint;
      faceAmount[currentPoint]++;
      if (faceAmount[currentPoint] == 3) {
        isThreeOfAKind = true;
      }
    }
    if (isThreeOfAKind) {
      return diceSum;
    } else {
      return 0;
    }
  }

  List<Function> generateAllDiceFaceCountFunctions() {
    List<Function> functions = [];
    for (int i = 1; i <= 6; i++) {
      functions.add((List<int> dicePoints) => faceCount(dicePoints, i));
    }
    return functions;
  }

  @override
  Widget build(BuildContext context) {
    List<Function> allDiceFaceCountFunctions =
        generateAllDiceFaceCountFunctions();
    List<int> scores = [];
    for (var func in allDiceFaceCountFunctions) {
      scores.add(func(widget.dicePoints));
    }
    return Column(
      children: [for (int score in scores) ScoreRow(score: score)],
    );
  }
}

class RightScoreColumn extends StatefulWidget {
  const RightScoreColumn({super.key, required this.dicePoints});
  final List<int> dicePoints;

  @override
  State<RightScoreColumn> createState() => _RightScoreColumnState();
}

class _RightScoreColumnState extends State<RightScoreColumn> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("TODO"),
      ],
    );
  }
}

class ScoreRow extends StatefulWidget {
  const ScoreRow({super.key, required this.score});
  final int score;

  @override
  State<ScoreRow> createState() => _ScoreRowState();
}

class _ScoreRowState extends State<ScoreRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(widget.score.toString()), const Text(" ")],
    );
  }
}

//one https://www.flaticon.com/free-icon/one_8286872
//two https://www.flaticon.com/free-icon/two_8286876
// three https://www.flaticon.com/free-icon/three_8286875
//four https://www.flaticon.com/free-icon/four_8286870
// five https://www.flaticon.com/free-icon/five_8286868?term=dice&related_id=8286868
// six https://www.flaticon.com/free-icon/six_8286874

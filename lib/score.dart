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
    return Column(
      children: [
        ScoreColumn(dicePoints: widget.dicePoints),
      ],
    );
  }
}

class Score {}

class ScoreColumn extends StatefulWidget {
  const ScoreColumn({super.key, required this.dicePoints});
  final List<int> dicePoints;

  @override
  State<ScoreColumn> createState() => _ScoreColumnState();
}

class _ScoreColumnState extends State<ScoreColumn> {
  int faceCount(List<int> dicePoints, int face) {
    int faceAmount = 0;
    for (int i = 0; i <= 4; i++) {
      if (dicePoints[i] == face) {
        faceAmount++;
      }
    }
    return faceAmount;
  }

  int nOfAKind(List<int> dicePoints, n) {
    int diceSum = 0;
    bool isNOfAKind = false;
    List<int> faceAmount = List.filled(7, 0);
    for (int i = 0; i <= 4; i++) {
      int currentPoint = dicePoints[i];
      diceSum += currentPoint;
      faceAmount[currentPoint]++;
      if (faceAmount[currentPoint] == n) {
        isNOfAKind = true;
        break;
      }
    }
    if (isNOfAKind) {
      return diceSum;
    } else {
      return 0;
    }
  }

  List<int> getFaceAmount(List<int> dicePoints) {
    List<int> faceAmount = List.filled(7, 0);
    for (int i = 0; i <= 4; i++) {
      int currentPoint = dicePoints[i];
      faceAmount[currentPoint]++;
    }
    return faceAmount;
  }

  int fullHouse(List<int> dicePoints) {
    List<int> faceAmount = getFaceAmount(dicePoints);
    bool threeSameFace = false, twoSameFace = false;
    for (int i = 1; i <= 6; i++) {
      if (faceAmount[i] == 3) {
        threeSameFace = true;
      }
      if (faceAmount[i] == 2) {
        twoSameFace = true;
      }
    }
    if (threeSameFace && twoSameFace) {
      return 25;
    } else {
      return 0;
    }
  }

  int smallStraight(List<int> dicePoints) {
    List<int> faceAmount = getFaceAmount(dicePoints);
    if (faceAmount[3] == 1 && faceAmount[4] == 1) {
      if ((faceAmount[1] == 1 && faceAmount[2] == 1) ||
          (faceAmount[2] == 1 && faceAmount[3] == 1) ||
          (faceAmount[5] == 1 && faceAmount[6] == 1)) {
        return 30;
      }
    }
    return 0;
  }

  int largeStraight(List<int> dicePoints) {
    List<int> faceAmount = getFaceAmount(dicePoints);
    for (int i = 2; i <= 5; i++) {
      if (faceAmount[i] != 1) {
        return 0;
      }
    }
    if (faceAmount[1] == 1 || faceAmount[6] == 1) {
      return 40;
    } else {
      return 0;
    }
  }

  int yahtzee(List<int> dicePoints) {
    List<int> faceAmount = getFaceAmount(dicePoints);
    for (int i = 1; i <= 6; i++) {
      if (faceAmount[i] == 5) {
        return 50;
      }
    }
    return 0;
  }

  int chance(List<int> dicePoints) {
    int totalPoints = 0;
    for (int i = 0; i <= 4; i++) {
      totalPoints+=dicePoints[i];
    }
    return totalPoints;
  }

  List<Function> generateAllDiceFaceCountFunctions() {
    List<Function> functions = [];
    for (int i = 1; i <= 6; i++) {
      functions.add((List<int> dicePoints) => faceCount(dicePoints, i));
    }
    for (int i = 3; i <= 4; i++) {
      functions.add((List<int> dicePoints) => nOfAKind(dicePoints, i));
    }
    functions.add((List<int> dicePoints) => fullHouse(dicePoints));
    functions.add((List<int> dicePoints) => smallStraight(dicePoints));
    functions.add((List<int> dicePoints) => largeStraight(dicePoints));
    functions.add((List<int> dicePoints) => yahtzee(dicePoints));
    functions.add((List<int> dicePoints) => chance(dicePoints));
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
    return Row(
      children: [
        Column(
          children: [for (int score in scores.take(6)) ScoreRow(score: score)],
        ),
        Column(
          children: [for (int score in scores.skip(6)) ScoreRow(score: score)],
        )
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
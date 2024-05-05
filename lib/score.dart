import 'package:flutter/material.dart';

class ScoreSection extends StatefulWidget {
  const ScoreSection({
    super.key,
    required this.dicePoints,
    required this.lockScore,
    required this.scoreLock,
    required this.isScorePlayed,
    required this.playScore,
  });
  final List<int> dicePoints;
  final Function(int, int) lockScore;
  final List<bool> scoreLock;
  final List<bool> isScorePlayed;
  final List<int> playScore;

  @override
  State<ScoreSection> createState() => _ScoreSectionState();
}

class _ScoreSectionState extends State<ScoreSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScoreColumn(
          dicePoints: widget.dicePoints,
          lockScore: widget.lockScore,
          scoreLock: widget.scoreLock,
          isScorePlayed: widget.isScorePlayed,
          playScore: widget.playScore,
        ),
      ],
    );
  }
}

class ScoreData {
  int score;
  final String image;

  ScoreData(this.score, this.image);
}

class ScoreColumn extends StatefulWidget {
  const ScoreColumn({
    super.key,
    required this.dicePoints,
    required this.lockScore,
    required this.scoreLock,
    required this.isScorePlayed,
    required this.playScore,
  });
  final List<int> dicePoints;
  final Function(int, int) lockScore;
  final List<bool> scoreLock;
  final List<bool> isScorePlayed;
  final List<int> playScore;

  @override
  State<ScoreColumn> createState() => _ScoreColumnState();
}

class _ScoreColumnState extends State<ScoreColumn> {
  int faceScore(List<int> dicePoints, int face) {
    int faceAmount = 0;
    for (int i = 0; i <= 4; i++) {
      if (dicePoints[i] == face) {
        faceAmount++;
      }
    }
    return faceAmount * face;
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
          (faceAmount[2] == 1 && faceAmount[5] == 1) ||
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
      totalPoints += dicePoints[i];
    }
    return totalPoints;
  }

  List<Function> generateAllDiceFaceCountFunctions() {
    List<Function> functions = [];
    for (int i = 1; i <= 6; i++) {
      functions.add((List<int> dicePoints) => faceScore(dicePoints, i));
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
    List<ScoreData> allScoreData = [];
    for (int i = 1; i <= 6; i++) {
      allScoreData.add(ScoreData(faceScore(widget.dicePoints, i), "dice_$i"));
    }
    for (int i = 3; i <= 4; i++) {
      allScoreData
          .add(ScoreData(nOfAKind(widget.dicePoints, i), "${i}_of_a_kind"));
    }
    allScoreData.add(ScoreData(fullHouse(widget.dicePoints), "full_house"));
    allScoreData
        .add(ScoreData(smallStraight(widget.dicePoints), "small_straight"));
    allScoreData
        .add(ScoreData(largeStraight(widget.dicePoints), "large_straight"));
    allScoreData.add(ScoreData(yahtzee(widget.dicePoints), "yahtzee"));
    allScoreData.add(ScoreData(chance(widget.dicePoints), "chance"));
    for (int i = 0; i < 13; i++) {
      if (widget.isScorePlayed[i]) {
        allScoreData[i].score = widget.playScore[i];
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i <= 5; i++)
              ScoreRow(
                scoreData: allScoreData[i],
                scoreIndex: i,
                lockScore: widget.lockScore,
                blockLock: widget.scoreLock[i],
                isPlayed: widget.isScorePlayed[i],
              )
          ],
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 6; i <= 12; i++)
              ScoreRow(
                scoreData: allScoreData[i],
                scoreIndex: i,
                lockScore: widget.lockScore,
                blockLock: widget.scoreLock[i],
                isPlayed: widget.isScorePlayed[i],
              )
          ],
        )
      ],
    );
  }
}

const double blockSize = 58;

class ScoreRow extends StatefulWidget {
  const ScoreRow({
    super.key,
    required this.scoreData,
    required this.scoreIndex,
    required this.lockScore,
    required this.blockLock,
    required this.isPlayed,
  });
  final ScoreData scoreData;
  final int scoreIndex;
  final Function(int, int) lockScore;
  final bool blockLock;
  final bool isPlayed;

  @override
  State<ScoreRow> createState() => _ScoreRowState();
}

class _ScoreRowState extends State<ScoreRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/${widget.scoreData.image}.png",
              width: blockSize,
            )),
        ScoreBlock(
          score: widget.scoreData.score,
          scoreIndex: widget.scoreIndex,
          lockScore: widget.lockScore,
          blockLock: widget.blockLock,
          isPlayed: widget.isPlayed,
        ),
        ScoreBlock(
          score: widget.scoreData.score,
          scoreIndex: widget.scoreIndex,
          lockScore: widget.lockScore,
          blockLock: widget.blockLock,
          isPlayed: widget.isPlayed,
        )
      ],
    );
  }
}

class ScoreBlock extends StatelessWidget {
  const ScoreBlock({
    super.key,
    required this.score,
    required this.scoreIndex,
    required this.lockScore,
    required this.blockLock,
    required this.isPlayed,
  });
  final int score;
  final int scoreIndex;
  final Function(int, int) lockScore;
  final bool blockLock;
  final bool isPlayed;

  @override
  Widget build(BuildContext context) {
    BorderRadius roundRadius = BorderRadius.circular(12);

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isPlayed
                ? Colors.transparent
                : blockLock
                    ? const Color.fromARGB(255, 167, 215, 242)
                    : Colors.transparent,
            width: 0.8,
          ),
          borderRadius: roundRadius,
        ),
        child: InkWell(
          onTap: () {
            lockScore(scoreIndex, score);
          },
          borderRadius: roundRadius,
          child: ClipRRect(
            borderRadius: roundRadius,
            child: Container(
              color: isPlayed
                  ? Colors.blueGrey
                  : blockLock
                      ? Colors.white
                      : const Color.fromARGB(255, 167, 215, 242),
              child: SizedBox.square(
                dimension: blockSize,
                child: Text(
                  score.toString(),
                  style: TextStyle(
                      color: isPlayed?const Color.fromARGB(255, 228, 160, 136): const Color.fromARGB(255, 56, 154, 196),
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    ); //
  }
}

class ScorePlayButton extends StatelessWidget {
  const ScorePlayButton({
    super.key,
    required this.playScore,
    required this.scoreSelected,
  });
  final Function() playScore;
  final bool scoreSelected;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        fixedSize: const Size(200, 70),
      ),
      onPressed: scoreSelected
          ? () {
              playScore();
            }
          : null,
      child: const Text(
        "PLAY",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}

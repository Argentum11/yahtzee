import 'package:flutter/material.dart';

class PlayerBlock extends StatelessWidget {
  const PlayerBlock(
      {super.key,
      required this.player1Score,
      required this.player2Score,
      required this.turn});
  final int player1Score;
  final int player2Score;
  final int turn;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(52),
      child: SizedBox(
        width: 300,
        child: Row(
          children: [
            SinglePlayerBlock(
              name: "Peter",
              score: player1Score,
              left: true,
              playing: turn == 0,
            ),
            SinglePlayerBlock(
              name: "Player 2",
              score: player2Score,
              left: false,
              playing: turn == 1,
            ),
          ],
        ),
      ),
    );
  }
}

class SinglePlayerBlock extends StatelessWidget {
  const SinglePlayerBlock(
      {super.key,
      required this.name,
      required this.score,
      required this.left,
      required this.playing});
  final String name;
  final int score;
  final bool left;
  final bool playing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 219, 242, 254),
      width: 150,
      child: Row(
        children: left
            ? [
                AccountIcon(
                  left: true,
                  playing: playing,
                ),
                const SizedBox(
                  width: 10,
                ),
                NameAndScore(
                  name: name,
                  score: score,
                ),
              ]
            : [
                NameAndScore(
                  name: name,
                  score: score,
                ),
                const SizedBox(
                  width: 10,
                ),
                AccountIcon(
                  left: false,
                  playing: playing,
                ),
              ],
      ),
    );
  }
}

class NameAndScore extends StatelessWidget {
  const NameAndScore({super.key, required this.name, required this.score});
  final String name;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(name),
        Text(
          score.toString(),
          style: const TextStyle(fontSize: 40),
        )
      ],
    );
  }
}

class AccountIcon extends StatelessWidget {
  const AccountIcon({super.key, required this.left, required this.playing});
  final bool left;
  final bool playing;

  @override
  Widget build(BuildContext context) {
    return Icon(
      playing ? Icons.account_circle : Icons.account_circle_outlined,
      color: left ? Colors.blue : Colors.red,
      size: 75,
    );
  }
}

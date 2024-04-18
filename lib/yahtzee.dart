import 'package:flutter/material.dart';

class YahtzeeGamePage extends StatefulWidget {
  const YahtzeeGamePage({super.key});

  @override
  State<YahtzeeGamePage> createState() => _YahtzeeGamePageState();
}

class _YahtzeeGamePageState extends State<YahtzeeGamePage> {
  int _diceRolledTimes = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_diceRolledTimes.toString()),
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
      }
    });
  }
}

class RollButton extends StatefulWidget {
  final VoidCallback onPressed;
  final int rolledTimes;
  const RollButton(
      {super.key, required this.onPressed, required this.rolledTimes});

  @override
  State<RollButton> createState() => _RollButtonState();
}

class _RollButtonState extends State<RollButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(254, 189, 27, 1.000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fixedSize: const Size(378, 60)),
          child: Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              const StrokeTextWithColor(text: "ROLL"),
              const SizedBox(
                width: 33,
              ),
              RemainingRollsSignal(rolledTimes: widget.rolledTimes)
            ],
          )),
    );
  }
}

class StrokeTextWithColor extends StatelessWidget {
  final String text;
  const StrokeTextWithColor({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 50,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Colors.brown,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class Signal extends StatelessWidget {
  final bool filled;
  final double radius = 35;
  const Signal({super.key, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? Colors.green : Colors.brown,
      ),
    );
  }
}

class RemainingRollsSignal extends StatefulWidget {
  final int rolledTimes;
  const RemainingRollsSignal({super.key, required this.rolledTimes});

  @override
  State<RemainingRollsSignal> createState() => _RemainingRollsSignalState();
}

class _RemainingRollsSignalState extends State<RemainingRollsSignal> {
  @override
  Widget build(BuildContext context) {
    List<bool> signalArray = turnRolledTimesToSignalArray(widget.rolledTimes);
    return Row(
      children: [
        for (int i = 0; i < signalArray.length; i++)
          Padding(
            padding: EdgeInsets.only(right: i < signalArray.length - 1 ? 8 : 0),
            child: Signal(filled: signalArray[i]),
          ),
      ],
    );
  }

  List<bool> turnRolledTimesToSignalArray(int rolledTimes) {
    int remainTimes = 3 - rolledTimes;
    List<bool> result = List.filled(3, false);

    if (remainTimes >= 1) {
      result[0] = true;
    }
    if (remainTimes >= 2) {
      result[1] = true;
    }
    if (remainTimes >= 3) {
      result[2] = true;
    }

    return result;
  }
}

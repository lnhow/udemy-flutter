import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final int finalScore;
  final VoidCallback handleReset;

  const QuizResult({required this.finalScore, required this.handleReset, super.key});

  String get resultText {
    if (finalScore > 35) {
      return 'High attention span. You passed!';
    }
    else if (finalScore > 30) {
      return 'Failed. Did your hand slip or something?';
    }
    else if (finalScore > 9) {
      return 'Failed. Kid nowadays.....';
    }
    return 'This must be an attemp to troll. You passed!';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultText,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text('Final score: $finalScore'),
        TextButton(
          onPressed: handleReset,
          child: const Text('Restart'),
        )
      ],
    ));
  }
}

import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final void Function(Map<String, Object>) handleAnswer;
  final int currentQuestion;

  const Quiz({required this.questions, required this.handleAnswer, required this.currentQuestion, super.key});

  @override
  Widget build(BuildContext context) {
    var question = questions[currentQuestion];
    return Column(children: [
        Question(question: question['question'] as String),
        ...(question['answers'] as List<Map<String, Object>>).map((e) {
          return Answer(onSelect: handleAnswer, answer: e);
        })
      ]);
  }
}
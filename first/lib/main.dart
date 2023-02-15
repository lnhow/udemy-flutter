import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() {
  runApp(const MyApp());
}

class _MyAppState extends State<MyApp> {
  int _currentQuestion = 0;
  int _totalScore = 0;
  static const _questions = [
    {
      'question': 'Select A',
      'answers': [
        { 'text': 'A', 'score': 10 },
        { 'text': 'B', 'score': 5 },
        { 'text': 'C', 'score': 3 },
        { 'text': 'D', 'score': 1 },
      ],
      'correctAnswer': 0
    },
    {
      'question': 'Select B',
      'answers': [
        { 'text': 'A', 'score': 5 },
        { 'text': 'B', 'score': 10 },
        { 'text': 'C', 'score': 5 },
        { 'text': 'D', 'score': 3 },
      ],
      'correctAnswer': 1
    },
    {
      'question': 'Select C',
      'answers': [
        { 'text': 'A', 'score': 3 },
        { 'text': 'B', 'score': 5 },
        { 'text': 'C', 'score': 10 },
        { 'text': 'D', 'score': 5 },
      ],
      'correctAnswer': 2
    },
    {
      'question': 'Select D',
      'answers': [
        { 'text': 'A', 'score': 1 },
        { 'text': 'B', 'score': 3 },
        { 'text': 'C', 'score': 5 },
        { 'text': 'D', 'score': 10 },
      ],
      'correctAnswer': 3
    },
  ];

  void handleAnswer(Map<String, Object> answer) {
    setState(() {
      _currentQuestion += 1;
      _totalScore += answer['score'] as int;
    });
  }

  void handleReset() {
    setState(() {
      _currentQuestion = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNotAllAnswered = _currentQuestion < _questions.length;
    
    return MaterialApp(
      title: 'Attentspan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Attentspan')),
        body: isNotAllAnswered
            ? Quiz(
                questions: _questions,
                currentQuestion: _currentQuestion,
                handleAnswer: handleAnswer,
              )
            : QuizResult(finalScore: _totalScore, handleReset: handleReset),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

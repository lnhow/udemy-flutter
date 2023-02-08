import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

void main() {
  runApp(const MyApp());
}

class _MyAppState extends State<MyApp> {
  var _currentQuestion = 0;
  static const _questions = [
    {
      'question': 'Select A',
      'answers': ['A', 'B', 'C', 'D'],
      'correctAnswer': 0
    },
    {
      'question': 'Select B',
      'answers': ['A', 'B', 'C', 'D'],
      'correctAnswer': 1
    },
    {
      'question': 'Select C',
      'answers': ['A', 'B', 'C', 'D'],
      'correctAnswer': 2
    },
    {
      'question': 'Select D',
      'answers': ['A', 'B', 'C', 'D'],
      'correctAnswer': 3
    },
  ];

  void handleAnswer() {
    setState(() {
      _currentQuestion += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNotAllAnswered = _currentQuestion < _questions.length;
    
    return MaterialApp(
      title: 'Text',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('App Bar Title')),
        body: isNotAllAnswered
            ? Column(children: [
                Question(question: _questions[_currentQuestion]['question'] as String),
                ...(_questions[_currentQuestion]['answers'] as List<String>).map((e) {
                  return Answer(onSelect: handleAnswer, text: e);
                })
              ])
            : const Center(child: Text('All answered')),
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

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Map<String, Object> answer;
  final void Function(Map<String, Object>) onSelect;

  const Answer({required this.answer, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => onSelect(answer),
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          child: Text(answer['text'] as String),
        ));
  }
}

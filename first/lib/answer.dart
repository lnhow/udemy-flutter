import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String text;
  final VoidCallback onSelect;

  const Answer({required this.text, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: onSelect,
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          child: Text(text),
        ));
  }
}

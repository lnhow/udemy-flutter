import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String text;
  const EmptyList({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

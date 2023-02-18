import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('No transaction yet',style: Theme.of(context).textTheme.headline6,),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 200,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          )
        ]
      ),
    );
  }
}
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) => Center(
      child: Column(
        children: [
          Text('No transaction yet',style: Theme.of(context).textTheme.headline6,),
          Container(
            margin: EdgeInsets.only(top: constraint.maxHeight * 0.05),
            height: constraint.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          )
        ]
      ),
    ));
  }
}
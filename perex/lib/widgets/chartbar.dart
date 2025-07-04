import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double value;
  final double valueTotal;

  const Chartbar(
      {required this.label,
      required this.value,
      required this.valueTotal,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) => Column(
      children: [
        SizedBox(
          height: constraint.maxHeight * 0.15,
          child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                  '${value.toStringAsFixed(0)}|${valueTotal.toStringAsFixed(0)}k')),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: constraint.maxHeight * 0.05),
          height: constraint.maxHeight * 0.6,
          width: 10,
          child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: valueTotal == 0 ? 0 : value / valueTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: constraint.maxHeight * 0.15,
          child: FittedBox(child: Text(label),),
        ),
      ],
    ));
  }
}

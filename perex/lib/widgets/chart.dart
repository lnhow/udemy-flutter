import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perex/model/transaction.dart';
import 'package:perex/widgets/chartbar.dart';

class Chart extends StatelessWidget {
  List<Map<String, Object>> get amountByWeekday {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double amountSum = transactions.fold(0.0, (amountSum, tx) {
        if (tx.date.day == weekday.day &&
            tx.date.month == weekday.month &&
            tx.date.year == weekday.year) {
          return amountSum + tx.amount;
        }
        return amountSum;
      });

      return {
        'day': DateFormat.E().format(weekday),
        'amount': amountSum,
      };
    }).reversed.toList();
  }

  double get amountThisWeek {
    return amountByWeekday.fold(0.0, (total, e) {
      return total + (e['amount'] as double);
    });
  }

  final List<Transaction> transactions;

  const Chart({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: amountByWeekday.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Chartbar(
                            label: e['day'] as String,
                            value: e['amount'] as double,
                            valueTotal: amountThisWeek)));
              }).toList(),
            ),
          )),
    );
  }
}

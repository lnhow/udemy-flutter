import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perex/model/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction tx;
  const TransactionWidget({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '${tx.amount.toStringAsFixed(3)} đ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tx.id),
                    Text(
                      tx.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat('dd/MM/yyyy').format(tx.date),
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            )));
  }
}

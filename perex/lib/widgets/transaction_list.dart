import 'package:flutter/material.dart';
import 'package:perex/widgets/empty_list.dart';
import 'package:perex/widgets/transaction.dart';
import 'package:perex/model/transaction.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onDelete;
  const TransactionListWidget({required this.transactions, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 550,
        child: transactions.isEmpty
            ? const EmptyListWidget()
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionWidget(tx: transactions[index], onDelete: onDelete);
                },
                itemCount: transactions.length,
              ));
  }
}

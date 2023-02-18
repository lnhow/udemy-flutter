import 'package:flutter/material.dart';
import 'package:perex/widgets/transaction_input.dart';
import 'package:perex/widgets/transaction_list.dart';
import 'package:perex/widgets/chart.dart';

import 'package:perex/model/transaction.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final List<Transaction> _transactions = [
    // Transaction(id: '1', title: 'Bánh mì', amount: 20, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final now = DateTime.now();
    final newTx = Transaction(
        title: title, amount: amount, date: date, id: now.toString());
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _openTransactionInput(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: TransactionInput(onSubmit: _addTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Column(
        children: [
          Chart(
            transactions: _recentTransactions,
          ),
          // TransactionInput(
          //   onSubmit: _addTransaction,
          // ),
          TransactionListWidget(
            transactions: _transactions,
            onDelete: _deleteTransaction,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openTransactionInput(ctx);
          },
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
